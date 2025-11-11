`ifndef PPU_FRAMEBUFFER_SV
`define PPU_FRAMEBUFFER_SV 

`include "ppu/types.sv"

module Framebuffer (
    input logic clk,
    input logic reset
);

  localparam WIDTH = 160;
  localparam HEIGHT = 144;

  localparam int NUM_PIXELS = WIDTH * HEIGHT;

  gb_color_t buffer[HEIGHT][WIDTH];

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      x_screen <= 8'd0;
      y_screen <= 8'd0;
      frame_done <= 1'b0;
      fifo_pop_en <= 1'b0;
    end else if (dot_en) begin

      fifo_pop_en <= 1'b0;
      frame_done  <= 1'b0;

      // Only draw visible area (160x144) when FIFO has pixels
      if (!fifo_empty && y_screen < HEIGHT && x_screen < WIDTH) begin
        // pop one pixel
        fifo_pop_en <= 1'b1;

        // Store pixel in framebuffer
        buffer[y_screen][x_screen] <= fifo_pop_px.color;

        // Advance to next screen pixel
        if (x_screen == WIDTH - 1) begin
          x_screen <= 8'd0;
          if (y_screen == HEIGHT - 1) begin
            y_screen   <= 8'd0;
            frame_done <= 1'b1;
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
