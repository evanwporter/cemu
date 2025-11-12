`ifndef CARTRIDGE_SV
`define CARTRIDGE_SV 

`include "mmu/addresses.sv"

module Cartridge (
    input logic clk,
    input logic reset
);

  logic [7:0] ROM[ROM_len];
  logic [7:0] RAM[RAM_len];

endmodule

`endif
