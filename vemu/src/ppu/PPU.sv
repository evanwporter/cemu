`ifndef PPU_SV
`define PPU_SV 

`include "ppu/types.sv"
`include "ppu/interface.sv"

module PPU (
    input logic clk,
    input logic reset,

    PPU_MMU_IF.PPU_side bus,
    output ppu_mode_t mode
);

  logic [8:0] cycle_counter;
  logic [7:0] line;

  ppu_regs_t regs;

  localparam int CYCLES_PER_LINE = 456;
  localparam int LINES_PER_FRAME = 154;

  // Mode durations in clock cycles
  localparam int MODE2_LEN = 80;
  localparam int MODE3_LEN = 172;
  localparam int MODE0_LEN = 204;

  // Write PPU registers
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      // TODO: Initialize all registers
    end else if (bus.reg_write_en) begin
      unique case (bus.reg_addr)
        16'hFF40: regs.LCDC <= bus.reg_wdata;
        16'hFF42: regs.SCY <= bus.reg_wdata;
        16'hFF43: regs.SCX <= bus.reg_wdata;
        16'hFF47: regs.BGP <= bus.reg_wdata;
        default:  ;
      endcase
    end
  end

  // Read PPU registers
  always_comb begin
    unique case (bus.reg_addr)
      16'hFF40: bus.reg_rdata = regs.LCDC;
      16'hFF42: bus.reg_rdata = regs.SCY;
      16'hFF43: bus.reg_rdata = regs.SCX;
      16'hFF44: bus.reg_rdata = regs.LY;
      default:  bus.reg_rdata = 8'h00;
    endcase
  end

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
