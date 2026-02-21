`ifndef INPUT_SV
`define INPUT_SV 

import gb_mmu_addresses_pkg::*;

module GB_Input (
    input logic clk,
    input logic reset,
    GB_Bus_if.Slave_side bus
);
  logic [7:0] JOYPAD_reg;

  localparam address_t JOYPAD_addr = 16'hFF00;

  wire joypad_selected = bus.addr == JOYPAD_addr;

  // ======================================================
  // Write
  // ======================================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) JOYPAD_reg <= 8'b11000000;
    else if (bus.write_en && joypad_selected) JOYPAD_reg <= 8'hCF;  // bus.wdata | 8'b11000000;
  end

  // ======================================================
  // Read
  // ======================================================
  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en && joypad_selected) begin
      bus.rdata = JOYPAD_reg;
    end
  end

endmodule

`endif  // INPUT_SV
