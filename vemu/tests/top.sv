`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

`include "cpu/CPU.sv"
`include "cpu/RAM.sv"

`include "ppu/PPU.sv"
import ppu_types_pkg::*;

`include "mmu/MMU.sv"

`include "Cartridge.sv"
`include "Serial.sv"
`include "Timer.sv"
`include "Input.sv"

`include "MockMMU.sv"

// `include "svlogger.sv"

module top (
    input logic clk,
    input logic reset
);

  Bus_if cpu_bus ();

  CPU cpu_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (cpu_bus)
  );

  MockMMU mmu_inst (
      .clk(clk),
      .reset(reset),
      .cpu_bus(cpu_bus)
  );

endmodule

`endif  // GAMEBOY_SV
