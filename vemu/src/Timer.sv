`ifndef TIMER_SV
`define TIMER_SV 

// https://gbdev.io/pandocs/Timer_and_Divider_Registers.html#timer-and-divider-registers

`include "mmu/addresses.sv"

module Timer (
    input logic clk,
    input logic reset
);
  /// Divider Register
  logic [7:0] DIV;

  /// Timer Counter
  logic [7:0] TIMA;

  /// Timer Modulo
  logic [7:0] TMA;

  /// Timer Control
  logic [7:0] TAC;

endmodule

`endif
