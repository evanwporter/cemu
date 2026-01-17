`include "ppu/Fetcher.sv"
`include "ppu/FIFO.sv"
`include "ppu/Framebuffer.sv"
`include "ppu/PPU.sv"

import ppu_types_pkg::*;
import ppu_util_pkg::*;

module ppu_top (
    input logic clk,
    input logic reset
);

  Bus_if ppu_bus ();
  Interrupt_if IF_bus ();

  PPU ppu (
      clk,
      reset,
      ppu_bus,
      IF_bus
  );

  initial begin
    ppu.regs.SCX  = 8'd0;
    ppu.regs.SCY  = 8'd0;
    ppu.regs.LCDC = 8'b1001_0001;  // LCD on, BG on, 0x8000 tiles, 0x9800 map

    ppu.VRAM <= '{default: 8'h00};

    ppu.mode = PPU_MODE_3;
  end

endmodule
