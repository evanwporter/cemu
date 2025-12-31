`ifndef TIMER_SV
`define TIMER_SV 

// https://gbdev.io/pandocs/Timer_and_Divider_Registers.html#timer-and-divider-registers

import mmu_addresses_pkg::*;

module Timer (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus,
    Interrupt_if.Timer_side IF_bus
);
  /// Divider Register
  // To the CPU the DIV appears as an 8-bit register at address 0xFF04. However,
  // internally it is a 16-bit counter that increments at every t-cycle, where
  // only the upper 8 bits are exposed to the CPU.
  // Source: https://github.com/Ashiepaws/GBEDG/blob/97f198d330a51be558aa8fc9f3f0760846d02d95/timers/index.md#ff04---divider-register-div
  logic [15:0] DIV;

  /// Timer Counter
  logic [ 7:0] TIMA;

  /// Timer Modulo
  logic [ 7:0] TMA;

  /// Timer Control
  logic [ 7:0] TAC;

  /// Number of t-cycles since last TIMA increment
  logic [ 9:0] timer_prescaler;

  /// Number of t-cycles per TIMA increment
  logic [ 9:0] timer_limit;

  always_comb begin
    unique case (TAC[1:0])
      2'b00: timer_limit = 10'd1023;  // t-cycles
      2'b01: timer_limit = 10'd15;
      2'b10: timer_limit = 10'd63;
      2'b11: timer_limit = 10'd255;
    endcase
  end

  // Tick
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      timer_prescaler  <= 10'd0;
      IF_bus.timer_req <= 1'b0;
    end else begin
      // Increment DIV every t-cycle
      DIV <= DIV + 16'd1;

      // Clear timer interrupt request
      IF_bus.timer_req <= 1'b0;

      if (TAC[2]) begin  // Timer enabled
        timer_prescaler <= timer_prescaler + 10'd1;

        if (timer_prescaler >= timer_limit) begin // less than or equal to to account for changes in TAC
          timer_prescaler <= 10'd0;

          if (TIMA == 8'hFF) begin
            TIMA <= TMA;
            IF_bus.timer_req <= 1'b1;
          end else begin
            TIMA <= TIMA + 8'h01;
          end
        end
      end
    end
  end

  wire div_selected = bus.addr == 16'hFF04;
  wire tima_selected = bus.addr == 16'hFF05;
  wire tma_selected = bus.addr == 16'hFF06;
  wire tac_selected = bus.addr == 16'hFF07;

  // Write
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      DIV  <= 16'h0000;
      TIMA <= 8'h00;
      TMA  <= 8'h00;
      TAC  <= 8'h00;
    end else if (bus.write_en) begin
      // TODO: DIV
      if (div_selected) DIV <= 16'h0000;  // Writing any value resets DIV to 0
      else if (tima_selected) TIMA <= bus.wdata;
      else if (tma_selected) TMA <= bus.wdata;
      else if (tac_selected) TAC <= bus.wdata & 8'b00000111;  // Only lower 3 bits writable
    end
  end

  // Read
  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en) begin
      if (div_selected) bus.rdata = DIV[15:8];
      else if (tima_selected) bus.rdata = TIMA;
      else if (tma_selected) bus.rdata = TMA;
      else if (tac_selected) bus.rdata = TAC;
    end
  end

endmodule

`endif
