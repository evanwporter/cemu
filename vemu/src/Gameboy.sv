`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

`include "cpu/CPU.sv"

`include "ppu/PPU.sv"
`include "ppu/types.sv"

`include "mmu/MMU.sv"
`include "mmu/interface.sv"

module Gameboy (
    input logic clk,
    input logic reset
);

  Bus_if cpu_bus ();
  Bus_if ppu_bus ();
  Bus_if apu_bus ();

  CPU cpu_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (cpu_bus)
  );

  MMU mmu_inst (
      .clk(clk),
      .reset(reset),
      .cpu_bus(cpu_bus),
      .ppu_bus(ppu_bus),
      .apu_bus(apu_bus),
      .ppu_mode(ppu_mode)
  );

  PPU ppu_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (ppu_bus)
  );

endmodule

`endif  // GAMEBOY_SV
