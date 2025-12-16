import ppu_types_pkg::*;

module FIFO (
    input  logic             clk,
    input  logic             reset,
    // push
    input  logic             push_en,
    input  ppu_pixel_t       push_px,
    output logic             full,
    // pop
    input  logic             pop_en,
    output ppu_pixel_t       top_px,
    output logic             empty,
    // utils
    output logic       [4:0] count,
    input  logic             flush
);
  localparam logic [4:0] DEPTH = 5'd16;

  ppu_pixel_t mem[DEPTH];
  logic [4:0] rptr, wptr;

  // TODO: Mod count somewhere
  assign count = wptr - rptr;
  assign empty = (count == 0);
  assign full = (count == DEPTH);
  assign top_px = (empty) ?
      '{color: GB_COLOR_WHITE, palette: 3'd0, spr_idx: 6'd0, bg_prio: 1'b0, valid: 1'b0}
      : mem[rptr[3:0]];

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      rptr <= '0;
      wptr <= '0;
    end else begin
      if (push_en && !full) begin
        mem[wptr[3:0]] <= push_px;
        wptr <= wptr + 1;
      end
      if (pop_en && !empty) begin
        rptr <= rptr + 1;
      end
    end
  end
endmodule
