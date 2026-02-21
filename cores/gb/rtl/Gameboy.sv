`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

`define LOG_LEVEL_WARN 

`include "gb/util/logger.svh"

import gb_mmu_addresses_pkg::*;

module Gameboy (
    input logic clk,
    input logic reset
);

  initial begin
    __log_fd = $fopen("simulation.log", "w");
    $display("Logging to simulation.log, log fd: %0d", __log_fd);
  end

  /// Current t-cycle within machine cycle
  gb_types_pkg::t_phase_t t_phase;

  GB_Bus_if cpu_bus ();
  GB_DMA_if dma_bus ();

  GB_Bus_if ppu_bus ();
  GB_Bus_if apu_bus ();

  GB_Bus_if cart_bus ();
  GB_Bus_if timer_bus ();
  GB_Bus_if input_bus ();
  GB_Bus_if ram_bus ();
  GB_Bus_if hram_bus ();
  GB_Bus_if serial_bus ();
  GB_Bus_if interrupt_bus ();
  GB_Bus_if dma_wrbus ();

  GB_Interrupt_if IF_bus ();

  SM83 cpu_inst (
      .clk(clk),
      .reset(reset),
      .t_phase(t_phase),
      .bus(cpu_bus),
      .interrupt_bus(interrupt_bus),
      .IF_bus(IF_bus)
  );

  GB_DMA dma_inst (
      .clk(clk),
      .reset(reset),
      .bus(dma_wrbus),
      .mmu_bus(dma_bus)
  );

  GB_MMU mmu_inst (
      .cpu_bus(cpu_bus),
      .dma_bus(dma_bus),
      .ppu_bus(ppu_bus),
      .apu_bus(apu_bus),
      .cart_bus(cart_bus),
      .ram_bus(ram_bus),
      .hram_bus(hram_bus),
      .serial_bus(serial_bus),
      .timer_bus(timer_bus),
      .input_bus(input_bus),
      .interrupt_bus(interrupt_bus),
      .dma_wrbus(dma_wrbus)
  );

  GB_PPU ppu_inst (
      .clk   (clk),
      .reset (reset),
      .bus   (ppu_bus),
      .IF_bus(IF_bus),
      .dma_bus(dma_bus)
  );

  GB_Cartridge cart_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (cart_bus)
  );

  GB_Timer timer_inst (
      .clk   (clk),
      .reset (reset),
      .t_phase(t_phase),
      .bus   (timer_bus),
      .IF_bus(IF_bus)
  );

  GB_Input input_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (input_bus)
  );

  GB_Serial serial_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (serial_bus)
  );

  GB_Memory #(
      .START_ADDR(HRAM_start),
      .END_ADDR  (HRAM_end),
      .SIZE      (HRAM_len)
  ) hram_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (hram_bus)
  );

  GB_Memory #(
      .START_ADDR(WRAM_start),
      .END_ADDR  (WRAM_end),
      .SIZE      (WRAM_len)
  ) wram_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (ram_bus)
  );

endmodule

`endif  // GAMEBOY_SV
