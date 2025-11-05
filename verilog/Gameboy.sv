`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

`include "types.sv"
`include "CPU.sv"
`include "MMU.sv"

module Gameboy (
    input logic clk,
    input logic reset
);

  logic [15:0] addr_bus;
  tri [7:0] data_bus;

  logic MMU_req_read;
  logic MMU_req_write;

  CPU cpu (
      .clk          (clk),
      .reset        (reset),
      .addr_bus     (addr_bus),
      .data_bus     (data_bus),
      .MMU_req_read (MMU_req_read),
      .MMU_req_write(MMU_req_write)
  );

  MMU mmu (
      .clk      (clk),
      .reset    (reset),
      .addr_bus (addr_bus),
      .data_bus (data_bus),
      .req_read (MMU_req_read),
      .req_write(MMU_req_write)
  );

endmodule

`endif  // GAMEBOY_SV
