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
  logic resp_done;
  logic [15:0] resp_read_data;

  CPU cpu (
      .clk(clk),
      .reset(reset),
      .mmu_data_in(mem_to_cpu),
      .mmu_data_out(cpu_to_mem),
      .mmu_bus_op(mmu_bus_op),
  );

  MMU mmu (
      .clk  (clk),
      .reset(reset),

      .req_op   (mmu_req_op),
      .req_size (mmu_req_size),
      .req_addr (mmu_req_addr),
      .req_wdata(mmu_req_wdata),

      .resp_valid(mmu_resp_valid),
      .resp_rdata(mmu_resp_rdata)
  );
endmodule
