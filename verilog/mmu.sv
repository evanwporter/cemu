module MMU (
    input logic clk,
    input logic reset,
    input bus_op_t mmu_bus_op,

    input logic [15:0] addr,
    input logic [ 7:0] data_in,

    output logic [7:0] data_out
);

  //  64 KB block RAM 
  logic [7:0] mem[0:16'hFFFF];

  initial begin
    foreach (mem[i]) mem[i] = 8'h00;
  end

  // Write logic
  always_ff @(posedge clk) begin
    if (mmu_bus_op == BUS_WRITE) mem[addr] <= data_in;
  end

  // Read logic
  always_ff @(posedge clk) begin
    if (mmu_bus_op == BUS_READ) data_out <= mem[addr];
  end

endmodule
