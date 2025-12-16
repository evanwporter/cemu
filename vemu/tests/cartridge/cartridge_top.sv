`ifndef CARTRIDGE_TOP_SV
`define CARTRIDGE_TOP_SV 

`include "Cartridge.sv"

module cartridge_top (
    input logic clk,
    input logic reset,

    input logic [15:0] cpu_addr,
    input logic [7:0] cpu_wdata,
    input logic cpu_read_en,
    input logic cpu_write_en,
    output logic [7:0] cpu_rdata
);

  Bus_if bus ();

  assign bus.addr     = cpu_addr;
  assign bus.wdata    = cpu_wdata;
  assign bus.read_en  = cpu_read_en;
  assign bus.write_en = cpu_write_en;

  assign cpu_rdata    = bus.rdata;

  Cartridge cart_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (bus)
  );

endmodule

`endif  // CARTRIDGE_TOP_SV
