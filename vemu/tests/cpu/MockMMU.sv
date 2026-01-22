`ifndef MMU_SV
`define MMU_SV 

module MockMMU (
    input logic clk,
    input logic reset,

    Bus_if.Slave_side cpu_bus
);

  logic [7:0] memory[65535];

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      // TODO: initialize memory to zero or some known state
    end else if (cpu_bus.write_en) begin
      memory[cpu_bus.addr] <= cpu_bus.wdata;
    end
  end

  assign cpu_bus.rdata = memory[cpu_bus.addr];
endmodule

`endif  // MMU_SV
