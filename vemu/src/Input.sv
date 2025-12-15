`ifndef INPUT_SV
`define INPUT_SV 

`include "mmu/addresses.svh"
`include "mmu/interface.sv"

module Input (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus
);
  logic [7:0] JOYPAD_reg;

  localparam address_t JOYPAD_addr = 16'hFF00;

  wire joypad_selected = bus.addr == JOYPAD_addr;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) JOYPAD_reg <= 8'h3F;
    else if (bus.write_en && joypad_selected) JOYPAD_reg <= bus.wdata;
  end

  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en && joypad_selected) bus.rdata = JOYPAD_reg;
  end

endmodule

`endif  // INPUT_SV
