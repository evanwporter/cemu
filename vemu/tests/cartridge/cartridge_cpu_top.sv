`ifndef CARTRIDGE_CPU_TOP_SV
`define CARTRIDGE_CPU_TOP_SV 

`define LOG_LEVEL_TRACE 

`include "Cartridge.sv"

`include "cpu/CPU.sv"
`include "cpu/RAM.sv"

`include "mmu/MMU.sv"

module cartridge_cpu_top (
    input logic clk,
    input logic reset,

    output logic [15:0] pc_out,
    output logic [ 7:0] boot_switch_out
);

  Bus_if cpu_bus ();
  Bus_if cart_bus ();
  Bus_if ram_bus ();
  Bus_if ppu_bus ();
  Bus_if apu_bus ();
  Bus_if serial_bus ();
  Bus_if timer_bus ();
  Bus_if input_bus ();
  Bus_if interrupt_bus ();
  Bus IF_bus ();

  CPU cpu_inst (
      .clk,
      .reset,
      .bus(cpu_bus),
      .interrupt_bus(interrupt_bus),
      .IF_bus(IF_bus)
  );

  assign pc_out = {cpu_inst.regs.pch, cpu_inst.regs.pcl};

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
      .input_bus(input_bus),
      .interrupt_bus(interrupt_bus)
  );

  Cartridge cart_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (cart_bus)
  );

  assign boot_switch_out = cart_inst.boot_rom_switch;

  RAM ram_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (ram_bus)
  );

  // Dummy PPU (just returns 0x00)
  assign ppu_bus.rdata = 8'h00;
  assign ppu_bus.addr = cpu_bus.addr;
  assign ppu_bus.wdata = cpu_bus.wdata;
  assign ppu_bus.read_en = 1'b0;
  assign ppu_bus.write_en = 1'b0;

  // Dummy APU
  assign apu_bus.rdata = 8'h00;
  assign apu_bus.addr = cpu_bus.addr;
  assign apu_bus.wdata = cpu_bus.wdata;
  assign apu_bus.read_en = 1'b0;
  assign apu_bus.write_en = 1'b0;

endmodule

`endif
