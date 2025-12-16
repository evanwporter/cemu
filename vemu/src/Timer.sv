`ifndef TIMER_SV
`define TIMER_SV 

// https://gbdev.io/pandocs/Timer_and_Divider_Registers.html#timer-and-divider-registers

import mmu_addresses_pkg::*;

module Timer (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus
);
  /// Divider Register
  logic [15:0] DIV;

  /// Timer Counter
  logic [7:0] TIMA;

  /// Timer Modulo
  logic [7:0] TMA;

  /// Timer Control
  logic [7:0] TAC;

  logic [1:0] div_prescaler;

  wire div_selected = bus.addr == 16'hFF04;
  wire tima_selected = bus.addr == 16'hFF05;
  wire tma_selected = bus.addr == 16'hFF06;
  wire tac_selected = bus.addr == 16'hFF07;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      DIV  <= 16'h0000;
      TIMA <= 8'h00;
      TMA  <= 8'h00;
      TAC  <= 8'h00;
    end else if (bus.write_en) begin
      // TODO: DIV
      if (div_selected) DIV <= 16'h0000;
      else if (tima_selected) TIMA <= bus.wdata;
      else if (tma_selected) TMA <= bus.wdata;
      else if (tac_selected) TAC <= bus.wdata;
    end
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      div_prescaler <= 2'b00;
    end else begin
      // Increment DIV every 4 cycles
      div_prescaler <= div_prescaler + 2'b01;
      if (div_prescaler == 2'd3) begin
        DIV <= DIV + 16'h0001;
      end
    end
  end

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
