import ppu_types_pkg::*;
import ppu_util_pkg::*;

`include "util/logger.svh"

module Framebuffer (
    input logic clk,
    input logic reset,
    input logic pixel_transfer_en, // PPU mode 3 active

    // FIFO interface
    FIFO_if.Framebuffer_side fifo_bus,

    input logic [7:0] SCX,

    // control
    input logic flush,

    // status
    output logic line_done,
    output logic frame_done
);

  localparam int NUM_PIXELS = GB_SCREEN_WIDTH * GB_SCREEN_HEIGHT;

  logic [7:0] x_screen;
  logic [7:0] y_screen;

  wire [14:0] write_addr = 15'((y_screen * GB_SCREEN_WIDTH) + x_screen);

  gb_color_t buffer[NUM_PIXELS];

  /// Number of pixels to discard at start of each scanline
  logic [2:0] discard_count;

  // TODO: better name for pop
  wire pop = pixel_transfer_en && !fifo_bus.empty;

  assign fifo_bus.read_en = pop;

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      x_screen <= 8'd0;
      // y_screen <= 8'd0;
      // frame_done <= 1'b0;
      discard_count <= SCX[2:0];

      line_done <= 1'b0;

      // $display("[PPU] [FB] Framebuffer reset (flush=%0b)", flush);
    end else begin

      frame_done <= 1'b0;
      line_done  <= 1'b0;

      // Only draw visible area (160x144) when FIFO has pixels
      if (pop) begin

        if (discard_count != 3'd0) begin
          // Discard pixel
          discard_count <= discard_count - 1'b1;
        end else begin

          // Store pixel in framebuffer
          // The read_data is always the top pixel in the FIFO
          buffer[write_addr] <= fifo_bus.read_data;

          if (x_screen == (GB_SCREEN_WIDTH - 8'd1)) begin
            // End of scanline
            x_screen <= 8'd0;
            y_screen <= y_screen + 8'd1;
            discard_count <= SCX[2:0];

            line_done <= 1'b1;

            `LOG_TRACE(("[PPU] [FB] Completed scanline %0d", y_screen))

            if (y_screen == GB_SCREEN_HEIGHT - 1) begin
              // End of frame
              frame_done <= 1'b1;
              y_screen   <= 8'd0;

              `LOG_TRACE(("[PPU] [FB] Frame complete!"))
            end
          end else begin
            // Next pixel
            x_screen <= x_screen + 8'd1;
          end
        end
      end
    end
  end

endmodule
