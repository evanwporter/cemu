import ppu_types_pkg::*;

interface Fetcher_if (
    input ppu_regs_t regs
);

  // ======================================================
  // VRAM Access
  // ======================================================

  /// VRAM read request
  logic vram_read_req;

  /// VRAM address to read from
  logic [15:0] vram_addr;

  /// VRAM read data
  logic [7:0] vram_rdata;

  modport PPU_side(input vram_read_req, vram_addr, output vram_rdata);

  modport Fetcher_side(input vram_rdata, regs, output vram_read_req, vram_addr);

endinterface


interface FIFO_if;
  // Producer (fetcher) writes
  logic write_en;
  pixel_t write_data;
  logic full;  // FIFO is full (can't accept writes)

  // Consumer (framebuffer) reads
  logic read_en;
  pixel_t read_data;
  logic empty;  // FIFO is empty (can't be read)

  /// Number of pixels inside buffer
  logic [3:0] count;

  modport Fetcher_side(output write_en, write_data, input full, empty);

  modport FIFO_side(input write_en, write_data, read_en, output read_data, full, empty, count);

  modport Framebuffer_side(output read_en, input read_data, empty);

endinterface
