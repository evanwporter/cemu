`ifndef CARTRIDGE_SV
`define CARTRIDGE_SV 

`include "mmu/addresses.sv"

module Cartridge (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus
);

  logic [7:0] ROM[ROM_len];

  wire ROM_selected = bus.addr inside {[ROM_start : ROM_end]};

  wire [15:0] rom_index = bus.addr;

  always_ff @(posedge clk) begin
    if (bus.write_en) begin
      if (rom_selected) ROM[rom_index] <= bus.wdata;
    end
  end

  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en) begin
      if (rom_selected) bus.rdata = ROM[rom_index];
    end
  end
endmodule

`endif
