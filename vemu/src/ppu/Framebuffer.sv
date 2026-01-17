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

  // wire [14:0] write_addr = 15'((y_screen * GB_SCREEN_WIDTH) + x_screen);

  gb_color_t buffer[NUM_PIXELS];

  logic frame_done;

  logic [14:0] write_addr;

  /// Number of pixels to discard at start of each scanline
  logic [2:0] discard_count;

  logic line_done;

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      x_screen <= 8'd0;
      // y_screen <= 8'd0;
      // frame_done <= 1'b0;
      discard_count <= 0;  // SCX[2:0];

      fifo_bus.read_en <= 1'b0;

      // write_addr <= 15'd0;

      line_done <= 1'b0;

      // $display("[PPU] [FB] Framebuffer reset (flush=%0b)", flush);
    end else begin
      fifo_bus.read_en <= 1'b0;

      if (dot_en) begin

        frame_done <= 1'b0;
        line_done  <= 1'b0;

        // Only draw visible area (160x144) when FIFO has pixels
        if (!fifo_bus.empty) begin
          fifo_bus.read_en <= 1'b1;

          // Store pixel in framebuffer
          // The read_data is always the top pixel in the FIFO
          for (logic [3:0] i = 0; i < FIFO_DEPTH; i++) begin
            buffer[write_addr+15'(i)] <= fifo_bus.read_data[3'(i)];
          end

          write_addr <= write_addr + 14'd8;

          if (x_screen == 152) begin
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
              write_addr <= 15'd0;

              `LOG_TRACE(("[PPU] [FB] Frame complete!"))
            end
          end else begin
            // Next pixel
            x_screen <= x_screen + 8'd8;
          end

        end
      end
    end
  end

endmodule
