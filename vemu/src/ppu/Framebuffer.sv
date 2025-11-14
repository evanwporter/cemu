`ifndef PPU_FRAMEBUFFER_SV
`define PPU_FRAMEBUFFER_SV 

`include "ppu/types.sv"

module Framebuffer (
    input  logic       clk,
    input  logic       reset,
    input  logic       dot_en,       // PPU mode 3 active
    // FIFO interface
    input  logic       fifo_empty,
    output logic       fifo_pop_en,  // pop request to FIFO
    input  ppu_pixel_t fifo_top_px,  // pixel popped from FIFO
    // control
    input  logic       flush
    // status
    // TODO: frame_done signal
);

  localparam logic [7:0] WIDTH = 160;
  localparam logic [7:0] HEIGHT = 144;

  localparam int NUM_PIXELS = WIDTH * HEIGHT;

  wire [14:0] write_addr = 15'((y_screen * WIDTH) + {8'b0, x_screen});

  gb_color_t buffer[NUM_PIXELS];

  logic [7:0] x_screen;
  logic [7:0] y_screen;

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      x_screen <= 8'd0;
      y_screen <= 8'd0;
      fifo_pop_en <= 1'b0;
    end else if (dot_en) begin

      fifo_pop_en <= 1'b0;

      // Only draw visible area (160x144) when FIFO has pixels
      if (!fifo_empty && y_screen < HEIGHT && x_screen < WIDTH) begin
        // pop one pixel
        fifo_pop_en <= 1'b1;

        // Store pixel in framebuffer
        buffer[write_addr] <= fifo_top_px.color;

        // Advance to next screen pixel
        if (x_screen == WIDTH - 1) begin
          x_screen <= 8'd0;
          if (y_screen == HEIGHT - 1) begin
            y_screen <= 8'd0;
          end else begin
            y_screen <= y_screen + 1;
          end
        end else begin
          x_screen <= x_screen + 1;
        end
      end
    end
  end

endmodule

`endif  // PPU_FRAMEBUFFER_SV
