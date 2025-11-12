`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

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

`include "svlogger.sv"

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
  Bus_if serial_bus ();
  Bus_if ram_bus ();

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

`ifndef SYNTHESIS
  initial begin
    svlogger::init("gameboy.log", `SVL_VERBOSE_DEBUG, `SVL_ROUTE_ALL);
    svlogger::info("Gameboy system initialized");
  end
`endif

endmodule

`endif  // GAMEBOY_SV
