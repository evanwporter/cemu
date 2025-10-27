typedef enum logic [1:0] {
  BUS_IDLE,  // no operation
  BUS_READ,  // read from memory (MMU)
  BUS_WRITE,  // write to memory (MMU)
  BUS_FINISHED_OP // I added a finished operation state here becuase I don't want another thread to take control
} bus_op_t;


module gameboy_top (
    input logic clk,
    input logic reset
);
  logic [15:0] address;
  logic [7:0] read_data, write_data;
  logic read_en, write_en;

  bus_op_t mmu_bus_op;

  CPU cpu (
      .clk(clk),
      .reset(reset),
      .mmu_data_in(mem_to_cpu),
      .mmu_data_out(cpu_to_mem),
      .mmu_bus_op(mmu_bus_op)
  );

  MMU mmu (
      .clk(clk),
      .reset(reset),
      .read_en(read_en),
      .write_en(write_en),
      .data_in(cpu_to_mem),
      .data_out(mem_to_cpu)
  );
endmodule
