`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

`include "types.sv"
`include "CPU.sv"
`include "MMU.sv"


module Gameboy (
    input logic clk,
    input logic reset
);
  // MMU request signals
  bus_op_t mmu_req_op;
  bus_size_t mmu_req_size;
  logic [15:0] mmu_req_addr;
  logic [15:0] mmu_req_write_data;

  // MMU response signals
  logic mmu_resp_done;
  logic [15:0] mmu_resp_read_data;

  CPU cpu (
      .clk  (clk),
      .reset(reset),

      .mmu_req_op(mmu_req_op),
      .mmu_req_size(mmu_req_size),
      .mmu_req_addr(mmu_req_addr),
      .mmu_req_wdata(mmu_req_write_data),

      .mmu_resp_done (mmu_resp_done),
      .mmu_resp_rdata(mmu_resp_read_data)
  );

  MMU mmu (
      .clk  (clk),
      .reset(reset),

      .req_op(mmu_req_op),
      .req_size(mmu_req_size),
      .req_addr(mmu_req_addr),
      .req_write_data(mmu_req_write_data),

      .resp_done(mmu_resp_done),
      .resp_read_data(mmu_resp_read_data)
  );
endmodule

`endif  // GAMEBOY_SV
