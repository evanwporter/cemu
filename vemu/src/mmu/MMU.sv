`ifndef MMU_SV
`define MMU_SV 

`include "mmu/util.sv"

`include "ppu/interface.sv"
`include "ppu/types.sv"

module MMU (
    input logic clk,
    input logic reset,

    Bus_if.MMU_side  cpu_bus,
    BusIF.MMU_master ppu_bus,
    BusIF.MMU_master apu_bus
);

  assign ppu_bus.addr  = cpu_bus.addr;
  assign apu_bus.addr  = cpu_bus.addr;

  assign ppu_bus.wdata = cpu_bus.wdata;
  assign apu_bus.wdata = cpu_bus.wdata;

  // PPU VRAM: $8000–$9FFF
  wire ppu_selected =
       (cpu_bus.addr inside {[VRAM_start : VRAM_end]})  ||
       (cpu_bus.addr inside {[OAM_start : OAM_end]})   ||
       (cpu_bus.addr inside {[PPU_regs_start : PPU_regs_end]});
  assign ppu_bus.read_en  = cpu_bus.read_en && ppu_selected;
  assign ppu_bus.write_en = cpu_bus.write_en && ppu_selected;

  // APU I/O: $FF10–$FF3F
  wire apu_selected = cpu_bus.addr inside {[AUDIO_addr_start : AUDIO_addr_end]};
  assign apu_bus.read_en  = cpu_bus.read_en && apu_selected;
  assign apu_bus.write_en = cpu_bus.write_en && apu_selected;

  // TODO: Remove and replace with modular memory
  logic [7:0] memory[65535];

  // Map Read Data
  always_comb begin
    cpu_bus.rdata = open_bus_value;

    if (ppu_selected) begin
      cpu_bus.rdata = ppu_bus.rdata;

    end else if (apu_selected) begin
      cpu_bus.rdata = apu_bus.rdata;

    end else begin
      // TODO
    end
  end
endmodule

`endif  // MMU_SV
