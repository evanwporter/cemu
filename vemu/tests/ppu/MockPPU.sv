`include "ppu/Fetcher.sv"
`include "ppu/FIFO.sv"
`include "ppu/Framebuffer.sv"

import ppu_types_pkg::*;
import ppu_util_pkg::*;

module MockPPU (
    input logic clk,
    input logic reset
);

  // Minimal regs
  ppu_regs_t regs;

  ppu_mode_t mode;

  logic [8:0] dot_counter;

  // VRAM
  logic [7:0] VRAM[0:8191]  /* verilator public */;

  logic fifo_reset;

  logic flush;

  // Hardcode scroll
  initial begin
    regs.SCX  = 8'd0;
    regs.SCY  = 8'd0;
    regs.LCDC = 8'b1001_0001;  // LCD on, BG on, 0x8000 tiles, 0x9800 map
    // regs.LY   = 8'd0;

    VRAM <= '{default: 8'h00};

    mode = PPU_MODE_3;
  end

  Fetcher_if fetcher_bus (
      .regs(regs),
      .dot_counter(dot_counter),
      .mode(mode)
  );

  FIFO_if fifo_bus ();

  Fetcher fetcher_inst (
      .clk(clk),
      .reset(reset),
      .bus(fetcher_bus),
      .fifo_bus(fifo_bus),
      .flush(flush)
  );

  FIFO fifo_inst (
      .clk  (clk),
      .reset(fifo_reset),
      .bus  (fifo_bus),
      .flush(flush)
  );

  Framebuffer fb_inst (
      .clk(clk),
      .reset(reset),
      .dot_en(1'b1),
      .fifo_bus(fifo_bus),
      .SCX(regs.SCX),
      .flush(flush)
  );

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      regs.LY <= '0;
      flush   <= 1'b0;
    end else begin
      flush <= 1'b0;
      if (fb_inst.line_done) begin
        regs.LY <= regs.LY + 1'b1;
        flush   <= 1'b1;
      end
    end
  end

  always_comb begin
    fetcher_bus.rdata = 8'hFF;

    if (fetcher_bus.read_req) begin
      // VRAM reads for fetcher (not blocked in Mode 3)
      fetcher_bus.rdata = VRAM[13'(fetcher_bus.addr)];
      `LOG_TRACE(
          ("[PPU] VRAM FETCHER READ addr=%h -> %h (mode=%0d)", fetcher_bus.addr, fetcher_bus.rdata, mode))
    end
  end

endmodule
