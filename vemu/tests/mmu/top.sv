`include "mmu/interface.sv"
`include "mmu/MMU.sv"

`include "ppu/PPU.sv"

module top (
    input logic clk,
    input logic reset,

    // Flattened CPU bus
    input  logic [15:0] cpu_addr,
    input  logic [ 7:0] cpu_wdata,
    input  logic        cpu_read_en,
    input  logic        cpu_write_en,
    output logic [ 7:0] cpu_rdata,

    output logic ppu_read_en_dbg,
    output logic ppu_write_en_dbg,
    output logic apu_read_en_dbg,
    output logic apu_write_en_dbg
);

  Bus_if cpu_bus ();
  Bus_if ppu_bus ();
  Bus_if apu_bus ();
  Bus_if cart_bus ();
  Bus_if ram_bus ();
  Bus_if serial_bus ();
  Bus_if timer_bus ();
  Interrupt_if IF_bus ();

  assign cpu_bus.addr     = cpu_addr;
  assign cpu_bus.wdata    = cpu_wdata;
  assign cpu_bus.read_en  = cpu_read_en;
  assign cpu_bus.write_en = cpu_write_en;
  assign cpu_rdata        = cpu_bus.rdata;

  MMU dut (
      .clk(clk),
      .reset(reset),
      .cpu_bus(cpu_bus.MMU_side),
      .ppu_bus(ppu_bus.MMU_master),
      .apu_bus(apu_bus.MMU_master),
      .cart_bus(cart_bus),
      .ram_bus(ram_bus),
      .serial_bus(serial_bus),
      .timer_bus(timer_bus),
      .IF_bus(IF_bus)
  );

  PPU ppu (
      .clk  (clk),
      .reset(reset),
      .bus  (ppu_bus)
  );

endmodule
