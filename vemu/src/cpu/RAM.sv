`ifndef CPU_RAM_SV
`define CPU_RAM_SV 

`include "mmu/addresses.sv"
`include "mmu/interface.sv"

module RAM (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus,
    Bus_if.Peripheral_side hram_bus
);
  logic [7:0] WRAM[WRAM_len];
  logic [7:0] HRAM[HRAM_len];

  wire wram_selected = bus.addr inside {[WRAM_start : WRAM_end]} ||
                       bus.addr inside {[Echo_RAM_start : Echo_RAM_end]}; // Echo RAM
  wire hram_selected = hram_bus.addr inside {[HRAM_start : HRAM_end]};

  wire [13:0] wram_index = bus.addr[13:0] & 14'h3FFF;
  wire [6:0] hram_index = 7'(hram_bus.addr - HRAM_start);

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      // TODO
    end else begin
      if (bus.write_en && wram_selected) WRAM[wram_index] <= bus.wdata;
      if (hram_bus.write_en && hram_selected) HRAM[hram_index] <= hram_bus.wdata;
    end
  end

  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en && wram_selected) bus.rdata = WRAM[wram_index];
  end

  always_comb begin
    hram_bus.rdata = 8'hFF;
    if (hram_bus.read_en && hram_selected) hram_bus.rdata = HRAM[hram_index];
  end

endmodule

`endif  // CPU_RAM_SV
