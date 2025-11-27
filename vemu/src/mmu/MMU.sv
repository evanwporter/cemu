`ifndef MMU_SV
`define MMU_SV 

`include "mmu/util.sv"
`include "mmu/interface.sv"
`include "mmu/addresses.sv"

`include "ppu/types.sv"

`include "util/logger.svh"

module MMU (
    input logic clk,
    input logic reset,

    Bus_if.MMU_side   cpu_bus,
    Bus_if.MMU_master ppu_bus,
    Bus_if.MMU_master apu_bus,
    Bus_if.MMU_master cart_bus,
    Bus_if.MMU_master ram_bus,
    Bus_if.MMU_master serial_bus,
    Bus_if.MMU_master timer_bus,
    Bus_if.MMU_master input_bus,
    Bus_if.MMU_master interrupt_bus
);

  // DMA
  logic [7:0] DMA;
  logic DMA_active;
  logic [7:0] DMA_index;  // sprite index 0-40

  wire [15:0] DMA_read_addr = {DMA, DMA_index * 8'd4};
  wire [15:0] DMA_write_addr = {OAM_start[15:8], DMA_index};

  wire [15:0] DMA_addr = (DMA_direction == DMA_DIRECTION_READ) ? DMA_read_addr : DMA_write_addr;
  dma_direction_t DMA_direction;

  wire dma_req_read = DMA_active && (DMA_direction == DMA_DIRECTION_READ);

  assign DMA_active = 1'b0;

  wire [15:0] effective_addr = DMA_active ? DMA_addr : cpu_bus.addr;

  wire cpu_req_read = cpu_bus.read_en && !DMA_active;
  wire cpu_req_write = cpu_bus.write_en && !DMA_active;

  assign ppu_bus.addr = effective_addr;
  assign apu_bus.addr = effective_addr;
  assign cart_bus.addr = effective_addr;
  assign ram_bus.addr = effective_addr;
  assign serial_bus.addr = effective_addr;
  assign timer_bus.addr = effective_addr;

  assign ppu_bus.wdata = cpu_bus.wdata;
  assign apu_bus.wdata = cpu_bus.wdata;
  assign cart_bus.wdata = cpu_bus.wdata;
  assign ram_bus.wdata = cpu_bus.wdata;
  assign serial_bus.wdata = cpu_bus.wdata;
  assign timer_bus.wdata = cpu_bus.wdata;

  // PPU VRAM: $8000–$9FFF, OAM: $FE00–$FE9F, PPU I/O: $FF40–$FF4B
  wire ppu_selected =
       (effective_addr inside {[VRAM_start : VRAM_end]})  ||
       (effective_addr inside {[OAM_start : OAM_end]})   ||
       (effective_addr inside {[PPU_regs_start : PPU_regs_end]});
  assign ppu_bus.read_en  = (cpu_req_read || dma_req_read) && ppu_selected;
  assign ppu_bus.write_en = cpu_bus.write_en && ppu_selected;

  // APU I/O: $FF10–$FF3F
  wire apu_selected = effective_addr inside {[AUDIO_addr_start : AUDIO_addr_end]};
  assign apu_bus.read_en  = (cpu_req_read || dma_req_read) && apu_selected;
  assign apu_bus.write_en = cpu_req_write && apu_selected;

  // ROM: $0000–$7FFF, RAM: $A000–$BFFF
  wire cart_selected = (effective_addr inside {[ROM_start : ROM_end]}) || (effective_addr == 16'hFF50);
  assign cart_bus.read_en  = (cpu_req_read || dma_req_read) && cart_selected;
  assign cart_bus.write_en = cpu_req_write && cart_selected;

  // RAM
  wire ram_selected = (effective_addr inside {[WRAM_start : Echo_RAM_end]});
  wire hram_selected = (cpu_bus.addr inside {[HRAM_start : HRAM_end]});
  assign ram_bus.read_en  = (cpu_req_read || dma_req_read) && (ram_selected || hram_selected);
  assign ram_bus.write_en = cpu_req_write && (ram_selected || hram_selected);

  // Serial
  wire serial_selected = effective_addr inside {[SERIAL_addr_start : SERIAL_addr_end]};
  assign serial_bus.read_en  = (cpu_req_read || dma_req_read) && serial_selected;
  assign serial_bus.write_en = cpu_req_write && serial_selected;

  wire timer_selected = effective_addr inside {[TIMER_addr_start : TIMER_addr_end]};
  assign timer_bus.read_en  = (cpu_req_read || dma_req_read) && timer_selected;
  assign timer_bus.write_en = cpu_req_write && timer_selected;

  wire unused_selected = (effective_addr inside {[Unusable_start : Unusable_end]});

  wire input_selected = (effective_addr == JOYPAD_addr_start);
  assign input_bus.read_en  = (cpu_req_read || dma_req_read) && input_selected;
  assign input_bus.write_en = cpu_req_write && input_selected;

  wire interrupt_selected = (effective_addr == 16'hFF0F) || (effective_addr == 16'hFFFF);
  assign interrupt_bus.read_en  = (cpu_req_read || dma_req_read) && interrupt_selected;
  assign interrupt_bus.write_en = cpu_req_write && interrupt_selected;

  wire DMA_selected = (effective_addr == DMA_OAM_addr);

  // Map Read Data
  always_comb begin
    cpu_bus.rdata = 8'hFF;

    if (DMA_active == 1'b1) begin
      if (hram_selected) begin
        // HRAM has priority over RAM when DMA is inactive
        cpu_bus.rdata = ram_bus.rdata;
      end

    end else if (DMA_active == 1'b0) begin
      if (ppu_selected) begin
        cpu_bus.rdata = ppu_bus.rdata;

      end else if (apu_selected) begin
        cpu_bus.rdata = apu_bus.rdata;

      end else if (cart_selected) begin
        cpu_bus.rdata = cart_bus.rdata;

      end else if (ram_selected || hram_selected) begin
        cpu_bus.rdata = ram_bus.rdata;

      end else if (serial_selected) begin
        cpu_bus.rdata = serial_bus.rdata;

      end else if (timer_selected) begin
        cpu_bus.rdata = timer_bus.rdata;

      end else if (unused_selected) begin
        `LOG_WARN(("[MMU] READ operation performed in unused area (addr=%h)", effective_addr));
        cpu_bus.rdata = 8'hFF;

      end else if (input_selected) begin
        cpu_bus.rdata = input_bus.rdata;

      end else if (interrupt_selected) begin
        cpu_bus.rdata = interrupt_bus.rdata;

      end else if (DMA_selected) begin
        cpu_bus.rdata = DMA;

      end else begin
        `LOG_WARN(("[MMU] Unmapped READ addr=%h", effective_addr));
        cpu_bus.rdata = 8'hFF;
        // TODO
      end
    end
  end

  // TODO handle writing to DMA (start DMA transfer)
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      DMA_active    <= 1'b0;
      DMA_index     <= 8'd0;
      DMA           <= 8'd00;
      DMA_direction <= DMA_DIRECTION_READ;
    end else begin
      // Writing to DMA register starts transfer
      if (cpu_bus.write_en && DMA_selected) begin
        DMA           <= cpu_bus.wdata;
        DMA_active    <= 1'b1;
        DMA_index     <= 8'd0;
        DMA_direction <= DMA_DIRECTION_READ;
      end
    end
  end

endmodule

`endif  // MMU_SV
