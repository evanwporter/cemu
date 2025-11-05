`ifndef MMU_SV
`define MMU_SV 

module MMU (
    input logic clk,
    input logic reset,

    // Bus interface
    input logic        req_read,
    input logic        req_write,
    input logic [15:0] addr_bus,
    inout logic [ 7:0] data_bus
);

  logic [7:0] memory[0:65535];

  // Only drive when CPU requests a read
  always_comb begin
    if (req_read) data_bus = memory[addr_bus];
    else data_bus = 'z;  // release bus otherwise
  end

  // Writes occur on the rising clock edge
  always_ff @(posedge clk) begin
    if (reset) begin
      // clear memory or maybe just leave uninitialized
      // for (int i = 0; i < 65536; i++) memory[i] <= 8'h00;
    end else if (req_write) begin
      memory[addr_bus] <= data_bus;
    end
  end

endmodule

`endif  // MMU_SV
