import mmu_addresses_pkg::*;

`include "util/logger.svh"

typedef enum logic [1:0] {
  T1,
  T2,
  T3,
  T4
} t_phase_t;

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

  localparam logic [7:0] DMA_MAX_CYCLES = 160;

  assign mmu_bus.active = dma_active;

  t_phase_t t_phase;

  // ======================================================
  // Write
  // ======================================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      `LOG_INFO(("[MMU] [DMA] DMA reset"))
      DMA <= 8'd0;
      dma_index <= 8'd0;
      dma_active <= 1'b0;
    end else if (bus.write_en && dma_selected) begin
      DMA <= bus.wdata;
      dma_index <= 8'd0;
      dma_active <= 1'b1;
      `LOG_INFO(("[MMU] [DMA] DMA started source=%02h00", bus.wdata))
    end
  end

  // ======================================================
  // Read
  // ======================================================
  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en && dma_selected) bus.rdata = DMA;
  end

  // ======================================================
  // Tick
  // ======================================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      dma_index <= 8'd0;
    end else if (dma_active) begin
      unique case (t_phase)
        T1: begin
          // start read
          mmu_bus.addr <= DMA_read_addr;
          mmu_bus.read_en <= 1'b1;
          mmu_bus.write_en <= 1'b0;
          t_phase <= T2;
        end
        T2: begin
          // read has finished
          // start write
          mmu_bus.addr <= DMA_write_addr;
          mmu_bus.wdata <= mmu_bus.rdata;
          mmu_bus.read_en <= 1'b0;
          mmu_bus.write_en <= 1'b1;
          t_phase <= T3;
          `LOG_TRACE(
              ("[MMU] [DMA] Transferred byte %0h, from %0h to %0h", mmu_bus.rdata,
                   DMA_read_addr, DMA_write_addr))
        end
        T3: begin
          // in this cycle, the OAM has recieved the wdata and the signal to begin writing
          // and it has now started the write.
          t_phase <= T4;
        end
        T4: begin
          // write has finished
          mmu_bus.write_en <= 1'b0;
          if (dma_index == DMA_MAX_CYCLES - 1) begin
            dma_active <= 1'b0;
            dma_index  <= 8'd0;
          end else begin
            dma_index <= dma_index + 8'd1;
          end

          t_phase <= T1;
        end
      endcase
    end
  end

endmodule
