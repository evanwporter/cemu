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

  assign ppu_bus.addr = cpu_bus.addr;
  assign apu_bus.addr = cpu_bus.addr;

  assign ppu_bus.wdata = cpu_bus.wdata;
  assign apu_bus.wdata = cpu_bus.wdata;

  // PPU VRAM: $8000–$9FFF
  assign ppu_bus.read_en = cpu_bus.read_en && cpu_bus.addr inside {[16'h8000 : 16'h9FFF]};
  assign ppu_bus.write_en = cpu_bus.write_en && cpu_bus.addr inside {[16'h8000 : 16'h9FFF]};

  // APU I/O: $FF10–$FF3F
  assign apu_bus.read_en = cpu_bus.read_en && cpu_bus.addr inside {[16'hFF10 : 16'hFF3F]};
  assign apu_bus.write_en = cpu_bus.write_en && cpu_bus.addr inside {[16'hFF10 : 16'hFF3F]};

  // TODO: Remove and replace with modular memory
  logic [7:0] memory[65535];

  // Map Read Data
  always_comb begin
    unique case (cpu_bus.addr) inside
      [16'h8000 : 16'h9FFF]: cpu_bus.rdata = ppu_bus.rdata;
      [16'hFF10 : 16'hFF3F]: cpu_bus.rdata = apu_bus.rdata;
      default: cpu_bus.rdata = 8'hFF;
    endcase
  end
endmodule

`endif  // MMU_SV
