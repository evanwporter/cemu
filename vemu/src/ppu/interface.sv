import ppu_types_pkg::*;
import ppu_util_pkg::*;

interface Fetcher_if (
    input ppu_regs_t regs,
    input logic [8:0] dot_counter,
    input ppu_mode_t mode
);

  // ======================================================
  // VRAM Access
  // ======================================================

  /// VRAM read request
  logic read_req;

  /// VRAM address to read from
  logic [15:0] addr;

  /// VRAM read data
  logic [7:0] rdata;

  modport PPU_side(input read_req, addr, output rdata);

  modport Fetcher_side(input rdata, regs, mode, dot_counter, output read_req, addr);
endinterface


interface FIFO_if;
  // Producer (fetcher) writes
  logic write_en;
  gb_color_t write_data[FIFO_DEPTH];
  logic full;  // FIFO is full (can't accept writes)

  // Consumer (framebuffer) reads
  logic read_en;
  gb_color_t read_data[FIFO_DEPTH];
  logic empty;  // FIFO is empty (can't be read)

  /// Number of pixels inside buffer
  logic [3:0] count;

  modport Fetcher_side(output write_en, write_data, input full, empty);

  modport FIFO_side(input write_en, write_data, read_en, output read_data, full, empty, count);

  modport Framebuffer_side(output read_en, input read_data, empty);

endinterface
