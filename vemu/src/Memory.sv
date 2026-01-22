module Memory #(
    parameter logic [15:0] START_ADDR = 16'h0000,
    parameter logic [15:0] END_ADDR = 16'h0000,
    parameter logic [15:0] SIZE = 100
) (
    input logic clk,
    input logic reset,
    Bus_if.Slave_side bus
);

  logic [7:0] mem[SIZE];

  // Address decode
  wire selected = bus.addr >= START_ADDR && bus.addr <= END_ADDR;

  // Address to index
  logic [$clog2(SIZE)-1:0] index;

  localparam int CLOG2 = $clog2(SIZE);

  always_comb begin
    index = CLOG2'(bus.addr - START_ADDR);
  end

  // Write
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      // TODO
    end else if (bus.write_en && selected) begin
      mem[index] <= bus.wdata;
    end
  end

  // Read
  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en && selected) begin
      bus.rdata = mem[index];
    end
  end

endmodule
