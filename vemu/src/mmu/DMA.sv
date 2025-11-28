`ifndef DMA_SV
`define DMA_SV 

`include "mmu/interface.sv"
`include "mmu/addresses.sv"

module DMA (
    input logic clk,
    input logic reset,

    Bus_if.Peripheral_side bus,
    DMA_if.DMA_side mmu_bus
);
  // DMA
  logic [7:0] DMA;
  logic dma_active;
  logic [7:0] dma_index;  // sprite index 0-40

  wire dma_selected = bus.addr == DMA_OAM_addr;

  wire [15:0] DMA_read_addr = {DMA, dma_index * 8'd4};
  wire [15:0] DMA_write_addr = {OAM_start[15:8], dma_index};

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      DMA <= 8'd0;
      dma_index <= 8'd0;
      dma_active <= 1'b0;
    end else if (bus.write_en && dma_selected) begin
      DMA <= bus.wdata;
      dma_index <= 8'd0;
      dma_active <= 1'b1;
    end
  end

  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en && dma_selected) bus.rdata = DMA;
  end

endmodule

`endif  // DMA_SV
