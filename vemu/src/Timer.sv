`ifndef TIMER_SV
`define TIMER_SV 

// https://gbdev.io/pandocs/Timer_and_Divider_Registers.html#timer-and-divider-registers

`include "mmu/addresses.sv"

module Timer (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus
);
  /// Divider Register
  logic [7:0] DIV;

  /// Timer Counter
  logic [7:0] TIMA;

  /// Timer Modulo
  logic [7:0] TMA;

  /// Timer Control
  logic [7:0] TAC;

  wire div_selected = bus.addr == DIV_addr;
  wire tima_selected = bus.addr == TIMA_addr;
  wire tma_selected = bus.addr == TMA_addr;
  wire tac_selected = bus.addr == TAC_addr;

  always_ff @(posedge clk) begin
    if (reset) begin
      DIV  <= 8'h00;
      TIMA <= 8'h00;
      TMA  <= 8'h00;
      TAC  <= 8'h00;
    end else if (bus.write_en) begin
      // TODO: DIV
      if (div_selected) DIV <= bus.wdata;
      else if (tima_selected) TIMA <= bus.wdata;
      else if (tma_selected) TMA <= bus.wdata;
      else if (tac_selected) TAC <= bus.wdata;
    end
  end

  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en) begin
      if (div_selected) bus.rdata = DIV;
      else if (tima_selected) bus.rdata = TIMA;
      else if (tma_selected) bus.rdata = TMA;
      else if (tac_selected) bus.rdata = TAC;
    end
  end

endmodule

`endif
