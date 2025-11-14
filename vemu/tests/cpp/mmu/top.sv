`include "mmu/interface.sv"
`include "mmu/MMU.sv"

`include "PPU.sv"
`include "APU.sv"

module top (
    input logic clk,
    input logic reset,

    // Flattened CPU bus
    input  logic [15:0] cpu_addr,
    input  logic [ 7:0] cpu_wdata,
    input  logic        cpu_read_en,
    input  logic        cpu_write_en,
    output logic [ 7:0] cpu_rdata
);

  Bus_if cpu_bus ();
  Bus_if ppu_bus ();
  Bus_if apu_bus ();

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
      .apu_bus(apu_bus.MMU_master)
  );

  PPU ppu (
      .clk(clk),
      .reset(reset),
      .addr(ppu_bus.addr),
      .wdata(ppu_bus.wdata),
      .rdata(ppu_bus.rdata),
      .read_en(ppu_bus.read_en),
      .write_en(ppu_bus.write_en)
  );

  APU apu (
      .clk(clk),
      .reset(reset),
      .addr(apu_bus.addr),
      .wdata(apu_bus.wdata),
      .rdata(apu_bus.rdata),
      .read_en(apu_bus.read_en),
      .write_en(apu_bus.write_en)
  );

endmodule
