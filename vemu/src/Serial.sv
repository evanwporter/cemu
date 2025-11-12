`ifndef SERIAL_SV
`define SERIAL_SV 

`include "mmu/addresses.sv"

module Serial (
    input logic clk,
    input logic reset
);
  /// Serial transfer registers
  logic [7:0] SB;

  /// Serial transfer control
  logic [7:0] SC;

endmodule

`endif
