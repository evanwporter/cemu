`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

`define LOG_LEVEL_TRACE 

`include "cpu/CPU.sv"
`include "cpu/RAM.sv"

`include "ppu/PPU.sv"
`include "ppu/types.sv"

`include "mmu/MMU.sv"
`include "mmu/interface.sv"

`include "Cartridge.sv"
`include "Serial.sv"
`include "Timer.sv"
`include "Input.sv"

module Gameboy (
    input logic clk,
    input logic reset
);

  Bus_if cpu_bus ();
  Bus_if ppu_bus ();
  Bus_if apu_bus ();

  Bus_if cart_bus ();
  Bus_if timer_bus ();
  Bus_if input_bus ();
  Bus_if ram_bus ();
  Bus_if serial_bus ();

  Interrupt_if IF_bus ();

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
      .cart_bus(cart_bus),
      .ram_bus(ram_bus),
      .serial_bus(serial_bus),
      .timer_bus(timer_bus),
      .IF_bus(IF_bus)
  );

  PPU ppu_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (ppu_bus)
  );

  Cartridge cart_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (cart_bus)
  );

  Timer timer_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (timer_bus)
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
      .clk  (clk),
      .reset(reset),
      .bus  (ram_bus)
  );

endmodule

`endif  // GAMEBOY_SV
