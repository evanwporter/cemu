import mmu_addresses_pkg::*;

`include "util/logger.svh"

module DMA (
    input logic clk,
    input logic reset,

    Bus_if.Peripheral_side bus,
    DMA_if.DMA_side mmu_bus
);
  // DMA
  logic [7:0] DMA;
  logic dma_active;
  logic [7:0] dma_index;  // byte index for OAM DMA (0-159)

  wire dma_selected = bus.addr == DMA_OAM_addr;

  wire [15:0] DMA_read_addr = {DMA, dma_index};
  wire [15:0] DMA_write_addr = {OAM_start[15:8], dma_index};

  // Write logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      `LOG_INFO(("[MMU] [DMA] DMA reset"));
      DMA <= 8'd0;
      dma_index <= 8'd0;
      dma_active <= 1'b0;
    end else if (bus.write_en && dma_selected) begin
      DMA <= bus.wdata;
      dma_index <= 8'd0;
      dma_active <= 1'b1;
      `LOG_INFO(("[MMU] [DMA] DMA started source=%02h00", bus.wdata));
    end
  end

  // Read logic
  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en && dma_selected) bus.rdata = DMA;
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      dma_index <= 8'd0;
    end else if (dma_active) begin
      if (dma_index == 8'd159) begin
        dma_active <= 1'b0;
        dma_index  <= 8'd0;
      end else begin
        dma_index <= dma_index + 8'd1;
      end
    end
  end

endmodule
