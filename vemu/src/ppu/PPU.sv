`ifndef PPU_SV
`define PPU_SV 

`include "ppu/types.sv"

module PPU (
    input logic clk,
    input logic reset,

    output ppu_mode_t mode
);

  logic [8:0] cycle_counter;
  logic [7:0] line;

  localparam int CYCLES_PER_LINE = 456;
  localparam int LINES_PER_FRAME = 154;

  // Mode durations in clock cycles
  localparam int MODE2_LEN = 80;
  localparam int MODE3_LEN = 172;
  localparam int MODE0_LEN = 204;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      mode          <= PPU_MODE_2;
      line          <= 8'd0;
      cycle_counter <= 0;
      frame_done    <= 1'b0;
    end else begin
      frame_done <= 1'b0;
      cycle_counter <= cycle_counter + 1;

      // Mode switching logic
      unique case (mode)
        PPU_MODE_2: if (cycle_counter == MODE2_LEN) mode <= PPU_MODE_3;
        PPU_MODE_3: if (cycle_counter == MODE2_LEN + MODE3_LEN) mode <= PPU_MODE_0;
        PPU_MODE_0: begin
          if (cycle_counter == CYCLES_PER_LINE - 1) begin
            cycle_counter <= 0;
            line <= line + 1;
            if (line == 8'd143) mode <= PPU_MODE_1;
            else mode <= PPU_MODE_2;
          end
        end
        PPU_MODE_1: begin
          if (cycle_counter == CYCLES_PER_LINE - 1) begin
            cycle_counter <= 0;
            line <= line + 1;
            if (line == LINES_PER_FRAME - 1) begin
              line <= 8'd0;
              mode <= PPU_MODE_2;
              frame_done <= 1'b1;
            end
          end
        end
      endcase
    end
  end

endmodule

`endif  // PPU_SV
