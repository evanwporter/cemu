`ifndef CPU_RAM_SV
`define CPU_RAM_SV 

`include "mmu/addresses.sv"
`include "mmu/interface.sv"

module RAM (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus
);
  logic [7:0] WRAM[WRAM_len];
  logic [7:0] HRAM[HRAM_len];

  wire wram_selected = bus.addr inside {[WRAM_start : WRAM_end]} ||
                       bus.addr inside {[Echo_RAM_start : Echo_RAM_end]}; // Echo RAM
  wire hram_selected = bus.addr inside {[HRAM_start : HRAM_end]};

  wire [13:0] wram_index = bus.addr[13:0] & 14'h3FFF;
  wire [6:0] hram_index = bus.addr[6:0];

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      // TODO
    end else if (bus.write_en) begin
      if (wram_selected) WRAM[wram_index] <= bus.wdata;
      else if (hram_selected) HRAM[hram_index] <= bus.wdata;
    end
  end

  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en) begin
      if (wram_selected) bus.rdata = WRAM[wram_index];
      else if (hram_selected) bus.rdata = HRAM[hram_index];
    end
  end

endmodule

`endif  // CPU_RAM_SV
