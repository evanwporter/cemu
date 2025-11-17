`ifndef CARTRIDGE_SV
`define CARTRIDGE_SV 

`include "mmu/addresses.sv"
`include "boot.svh"

module Cartridge (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus
);

  logic [7:0] ROM[ROM_len];

  logic [7:0] boot_rom_switch;

  wire boot_rom_active = boot_rom_switch != 8'd1;

  wire boot_rom_selected = (bus.addr inside {[ROM_start : 8'h00FF]}) && boot_rom_active;
  wire rom_selected = bus.addr inside {[ROM_start : ROM_end]};
  wire boot_switch_selected = bus.addr == 16'hFF50;

  wire [14:0] rom_index = 15'(bus.addr);

  always_ff @(posedge clk) begin
    if (bus.write_en) begin
      if (rom_selected) ROM[rom_index] <= bus.wdata;
      else if (boot_switch_selected) begin
        boot_rom_switch <= bus.wdata;
        $display("[%0t] Boot ROM disabled", $time);
      end
    end
  end

  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en) begin
      if (boot_rom_selected) bus.rdata = BOOT_DMG[8'(rom_index)];
      else if (rom_selected) bus.rdata = ROM[rom_index];
      else if (boot_switch_selected) bus.rdata = boot_rom_switch;
    end
  end
endmodule

`endif
