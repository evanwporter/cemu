`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

`define LOG_LEVEL_INFO 

`include "util/logger.svh"

`include "cpu/CPU.sv"

module Gameboy (
    input logic clk,
    input logic reset
);

  //   initial begin
  //     __log_fd = $fopen("simulation.log", "w");
  //     $display("Logging to simulation.log, log fd: %0d", __log_fd);
  //   end

  Bus_if cpu_bus ();
  DMA_if dma_bus ();

  Bus_if ppu_bus ();
  Bus_if apu_bus ();

  Bus_if cart_bus ();
  Bus_if timer_bus ();
  Bus_if input_bus ();
  Bus_if ram_bus ();
  Bus_if hram_bus ();
  Bus_if serial_bus ();
  Bus_if interrupt_bus ();
  Bus_if dma_wbus ();

  Interrupt_if IF_bus ();

  CPU cpu_inst (
      .clk(clk),
      .reset(reset),
      .bus(cpu_bus),
      .interrupt_bus(interrupt_bus),
      .IF_bus(IF_bus)
  );

  DMA dma_inst (
      .clk(clk),
      .reset(reset),
      .bus(dma_wbus),
      .mmu_bus(dma_bus)
  );

  MMU mmu_inst (
      .clk(clk),
      .reset(reset),
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
      .dma_wbus(dma_wbus)
  );

  PPU ppu_inst (
      .clk   (clk),
      .reset (reset),
      .bus   (ppu_bus),
      .IF_bus(IF_bus)
  );

  Cartridge cart_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (cart_bus)
  );

  Timer timer_inst (
      .clk   (clk),
      .reset (reset),
      .bus   (timer_bus),
      .IF_bus(IF_bus)
  );

  Input input_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (input_bus)
  );

  Serial serial_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (serial_bus)
  );

  RAM ram_inst (
      .clk(clk),
      .reset(reset),
      .bus(ram_bus),
      .hram_bus(hram_bus)
  );

endmodule

`endif  // GAMEBOY_SV
