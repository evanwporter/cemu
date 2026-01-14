import ppu_types_pkg::*;
import ppu_util_pkg::*;

`include "util/logger.svh"

module Framebuffer (
    input logic clk,
    input logic reset,
    input logic dot_en, // PPU mode 3 active

    // FIFO interface
    FIFO_if.Framebuffer_side fifo_bus,

    input logic [7:0] SCX,

    // control
    input logic flush
    // status
    // TODO: frame_done signal
);

  localparam int NUM_PIXELS = GB_SCREEN_WIDTH * GB_SCREEN_HEIGHT;

  logic [7:0] x_screen;
  logic [7:0] y_screen;

  wire [14:0] write_addr = 15'((y_screen * GB_SCREEN_WIDTH) + x_screen);

  gb_color_t buffer[NUM_PIXELS];

  logic frame_done;

  /// Number of pixels to discard at start of each scanline
  logic [2:0] discard_count;

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      x_screen   <= 8'd0;
      y_screen   <= 8'd0;
      frame_done <= 1'b0;

      `LOG_INFO(("[PPU] [FB] Framebuffer reset (flush=%0b)", flush))
    end else begin
      fifo_bus.read_en <= 1'b0;

      if (dot_en) begin

        if (x_screen == 0) begin
          discard_count <= SCX[2:0];
        end

        // Clear at beginning of new frame
        if (x_screen == 0 && y_screen == 0) frame_done <= 1'b0;

        // Only draw visible area (160x144) when FIFO has pixels
        if (!fifo_bus.empty) begin
          if (discard_count != 0) begin
            discard_count <= discard_count - 1;

            `LOG_TRACE(("[PPU] [FB] Discard pixel, remaining=%0d", discard_count - 1))

          end else if (y_screen < GB_SCREEN_HEIGHT && x_screen < GB_SCREEN_WIDTH) begin
            // Pop one pixel
            fifo_bus.read_en   <= 1'b1;

            // Store pixel in framebuffer
            // The read_data is always the top pixel in the FIFO
            buffer[write_addr] <= fifo_bus.read_data.color;

            `LOG_TRACE(
                ("[PPU] [FB] Draw pixel (%0d,%0d) color=%0d", x_screen, y_screen, fifo_bus.read_data.color))

            // Advance to next screen pixel
            if (x_screen == GB_SCREEN_WIDTH - 1) begin
              x_screen <= 8'd0;
              if (y_screen == GB_SCREEN_HEIGHT - 1) begin
                y_screen   <= 8'd0;
                frame_done <= 1'b1;
                `LOG_INFO(
                    ("[PPU] [FB] Frame complete! (%0d x %0d pixels)", GB_SCREEN_WIDTH, GB_SCREEN_HEIGHT))
              end else begin
                y_screen <= y_screen + 1;
              end
            end else begin
              x_screen <= x_screen + 1;
            end
          end
        end
      end
    end
  end

endmodule
