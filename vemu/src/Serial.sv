`ifndef SERIAL_SV
`define SERIAL_SV 

// https://gbdev.io/pandocs/Serial_Data_Transfer_(Link_Cable).html#serial-data-transfer-link-cable

`include "mmu/addresses.svh"

module Serial (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus
);
  /// Serial transfer registers
  logic [7:0] SB;

  /// Serial transfer control
  logic [7:0] SC;

  localparam address_t SB_addr = 16'hFF01;
  localparam address_t SC_addr = 16'hFF02;

  wire sb_selected = bus.addr == SB_addr;
  wire sc_selected = bus.addr == SC_addr;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      SB <= 8'h00;
      SC <= 8'h7E;
    end else if (bus.write_en) begin
      if (sb_selected) SB <= bus.wdata;
      else if (sc_selected) SC <= bus.wdata;
    end
  end

  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en) begin
      if (sb_selected) bus.rdata = SB;
      else if (sc_selected) bus.rdata = SC;
    end
  end

endmodule

`endif
