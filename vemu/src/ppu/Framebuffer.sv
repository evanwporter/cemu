import ppu_types_pkg::*;
import ppu_util_pkg::*;

`include "util/logger.svh"

module Framebuffer (
    input logic clk,
    input logic reset,
    input logic dot_en, // PPU mode 3 active

    // FIFO interface
    FIFO_if.Framebuffer_side fifo_bus,

    // control
    input logic flush
    // status
    // TODO: frame_done signal
);

  localparam int NUM_PIXELS = GB_SCREEN_WIDTH * GB_SCREEN_HEIGHT;

  logic [7:0] x_screen;
  logic [7:0] y_screen;

  wire [14:0] write_addr = 15'((y_screen * GB_SCREEN_WIDTH) + x_screen);

  gb_color_t buffer[NUM_PIXELS]  /*verilator public_flat_rd*/;

  logic frame_done;

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      x_screen   <= 8'd0;
      y_screen   <= 8'd0;
      frame_done <= 1'b0;

      `LOG_INFO(("[PPU] [FB] Framebuffer reset (flush=%0b)", flush))
    end else if (dot_en) begin

      fifo_bus.read_en <= 1'b0;

      // Clear at beginning of new frame
      if (x_screen == 0 && y_screen == 0) frame_done <= 1'b0;

      // Only draw visible area (160x144) when FIFO has pixels
      if (!fifo_bus.empty && y_screen < GB_SCREEN_HEIGHT && x_screen < GB_SCREEN_WIDTH) begin
        // Pop one pixel
        fifo_bus.read_en   <= 1'b1;

        // Store pixel in framebuffer
        // The read_data is always the top pixel.
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

endmodule
