`ifndef INPUT_SV
`define INPUT_SV 

`include "mmu/addresses.sv"

module Input (
    input logic clk,
    input logic reset
);
  logic [7:0] JOYPAD_reg;

endmodule

`endif
