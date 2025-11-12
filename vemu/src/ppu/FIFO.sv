`ifndef PPU_FIFO_SV
`define PPU_FIFO_SV 

`include "ppu/types.sv"

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
  localparam int DEPTH = 16;

  ppu_pixel_t mem[DEPTH];
  logic [4:0] rptr, wptr;

  assign count  = wptr - rptr;
  assign empty  = (count == 0);
  assign full   = (count == DEPTH);
  assign top_px = (empty) ? '{default: '0} : mem[rptr[3:0]];

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

`endif  // PPU_FIFO_SV
