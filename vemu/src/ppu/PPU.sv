import ppu_types_pkg::*;
import mmu_addresses_pkg::*;

`include "util/logger.svh"

module PPU (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus,
    Interrupt_if.PPU_side IF_bus
);

  // Dot counters (resets after each line)
  logic [8:0] dot_counter;

  ppu_regs_t regs;

  localparam logic [7:0] SCREEN_HEIGHT = 144;
  localparam logic [7:0] SCREEN_WIDTH = 160;

  localparam logic [8:0] DOTS_PER_LINE = 456;
  localparam logic [7:0] LINES_PER_FRAME = 154;

  // Mode durations in clock cycles
  localparam logic [8:0] MODE2_LEN = 80;
  localparam logic [8:0] MODE3_LEN = 172;
  localparam logic [8:0] MODE0_LEN = 204;  // 376 - 172;

  ppu_mode_t mode;

  logic dot_en;
  assign dot_en = (mode == PPU_MODE_3);

  logic [7:0] VRAM[VRAM_len];
  logic [7:0] OAM[OAM_len];

  // Window active check
  logic window_active;
  assign window_active = (regs.LCDC[5] && (regs.LY >= regs.WY) &&
                         (/* current X >= WX - 7 */ 1'b1)); // TODO: implement per-dot window condition


  // ======================================================
  // Update STAT
  // ======================================================

  // The lower 3 bits of the STAT register are updated combinationally.
  // Then it is combined with the writable bits when a read occurs.
  logic [2:0] stat_comb;

  // Update the mode bits in STAT register
  always_comb begin
    unique case (mode)
      PPU_MODE_0: stat_comb[1:0] = 2'd0;
      PPU_MODE_1: stat_comb[1:0] = 2'd1;
      PPU_MODE_2: stat_comb[1:0] = 2'd2;
      PPU_MODE_3: stat_comb[1:0] = 2'd3;
    endcase
  end

  // Update LY == LYC flag
  always_comb begin
    if (regs.LY == regs.LYC) begin
      stat_comb[2] = 1'b1;
    end else begin
      stat_comb[2] = 1'b0;
    end
  end

  // Raise interrupt
  logic stat_interrupt_prev;
  logic stat_interrupt_now;

  always_comb begin
    stat_interrupt_now = 1'b0;

    // LY == LYC
    if (regs.STAT[6] && stat_comb[2]) stat_interrupt_now = 1'b1;

    // Mode 2 (OAM)
    else if (regs.STAT[5] && mode == PPU_MODE_2) stat_interrupt_now = 1'b1;

    // Mode 0 (HBlank)
    else if (regs.STAT[4] && mode == PPU_MODE_0) stat_interrupt_now = 1'b1;

    // Mode 1 (VBlank)
    else if (regs.STAT[3] && mode == PPU_MODE_1) stat_interrupt_now = 1'b1;
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      stat_interrupt_prev <= 1'b0;
      IF_bus.stat_req     <= 1'b0;
    end else begin
      // Rising edge detect
      IF_bus.stat_req <= stat_interrupt_now & ~stat_interrupt_prev;

      // Latch previous value
      stat_interrupt_prev <= stat_interrupt_now;
    end
  end


  // ======================================================
  // Write
  // ======================================================
  always_ff @(posedge clk or posedge reset) begin
    if (bus.write_en) begin
      `LOG_TRACE(("PPU: WRITE addr=%h data=%h", bus.addr, bus.wdata));

      case (1'b1)

        // VRAM writes (blocked in Mode 3)
        (bus.addr inside {[VRAM_start : VRAM_end]}): begin
          // if (mode != PPU_MODE_3) begin
          VRAM[13'(bus.addr-16'h8000)] <= bus.wdata;
          `LOG_TRACE(("[PPU] VRAM WRITE addr=%h data=%h (mode=%0d)", bus.addr, bus.wdata, mode))
          // end else begin
          //   `LOG_TRACE(
          //       ("[PPU] VRAM WRITE BLOCKED addr=%h data=%h (mode=%0d)", bus.addr, bus.wdata, mode));
          // end
        end

        // OAM writes (blocked in Mode 2 & 3)
        (bus.addr inside {[OAM_start : OAM_end]}): begin
          if (!(mode == PPU_MODE_2 || mode == PPU_MODE_3)) begin
            OAM[8'(bus.addr-16'hFE00)] <= bus.wdata;
            `LOG_TRACE(("[PPU] OAM WRITE addr=%h data=%h (mode=%0d)", bus.addr, bus.wdata, mode))
          end else begin
            `LOG_INFO(
                ("[PPU] OAM WRITE BLOCKED addr=%h data=%h (mode=%0d)", bus.addr, bus.wdata, mode))
          end
        end

        // PPU register writes
        // TODO: check whether this ever needs to be blocked
        (bus.addr inside {[PPU_regs_start : PPU_regs_end]}): begin
          `LOG_TRACE(("[PPU] REG WRITE addr=%h data=%h", bus.addr, bus.wdata))
          case (bus.addr)
            16'hFF40: regs.LCDC <= bus.wdata;
            16'hFF41: regs.STAT[6:3] <= bus.wdata[6:3];  // only bits 3-6 are writable
            16'hFF42: regs.SCY <= bus.wdata;
            16'hFF43: regs.SCX <= bus.wdata;
            16'hFF44: begin
              `LOG_WARN(("[PPU] Attempted to write 0x%h to LY register", bus.wdata))
            end
            16'hFF45: regs.LYC <= bus.wdata;
            16'hFF47: regs.BGP <= bus.wdata;
            default:  ;
          endcase
        end

        default:  /* ignore */;
      endcase
    end
  end


  // ======================================================
  // Read
  // ======================================================
  always_comb begin
    bus.rdata = 8'hFF;  // open bus unless selected & allowed

    if (bus.read_en) begin
      unique case (bus.addr) inside

        // VRAM reads (blocked in Mode 3)
        [VRAM_start : VRAM_end]: begin
          bus.rdata = (mode == PPU_MODE_3) ? 8'hFF : VRAM[13'(bus.addr-VRAM_start)];
          `LOG_TRACE(("[PPU] VRAM READ addr=%h -> %h (mode=%0d)", bus.addr, bus.rdata, mode))
        end

        // OAM reads (blocked in Mode 2 & 3)
        [OAM_start : OAM_end]: begin
          bus.rdata = (mode == PPU_MODE_2 || mode == PPU_MODE_3)
            ? 8'hFF
            : OAM[8'(bus.addr-OAM_start)];
          `LOG_TRACE(("[PPU] OAM READ addr=%h -> %h (mode=%0d)", bus.addr, bus.rdata, mode))
        end

        // PPU register reads
        [PPU_regs_start : PPU_regs_end]: begin
          `LOG_TRACE(("[PPU] REG READ addr=%h -> %h", bus.addr, bus.rdata))
          case (bus.addr)
            16'hFF40: bus.rdata = regs.LCDC;
            16'hFF41: bus.rdata = {1'b0, regs.STAT[6:3], stat_comb};
            16'hFF42: bus.rdata = regs.SCY;
            16'hFF43: bus.rdata = regs.SCX;
            16'hFF44: bus.rdata = regs.LY;
            16'hFF45: bus.rdata = regs.LYC;
            // TODO: DMA transfer
            16'hFF47: bus.rdata = regs.BGP;
            default:  bus.rdata = 8'hFF;
          endcase
        end
      endcase
    end
  end


  // ======================================================
  // Update Mode
  // ======================================================
  always_comb begin
    if (regs.LY >= 8'd144) begin
      mode = PPU_MODE_1;  // VBlank
    end else if (dot_counter < MODE2_LEN) begin
      mode = PPU_MODE_2;  // OAM Scan
    end else if (dot_counter < MODE2_LEN + MODE3_LEN) begin
      mode = PPU_MODE_3;  // Pixel Transfer
    end else begin
      mode = PPU_MODE_0;  // HBlank
    end
  end

  // ======================================================
  // Tick
  // ======================================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      dot_counter <= 9'd0;
      regs.LY <= 8'd0;
      IF_bus.vblank_req <= 1'b0;
    end else begin
      // Regardless of mode, clear VBlank interrupt request
      IF_bus.vblank_req <= 1'd0;

      if (regs.LCDC[7] == 1'b0) begin  // LCD disabled
        dot_counter <= 9'd0;
        regs.LY <= 8'd0;
      end else begin
        // Advance dot
        if (dot_counter == DOTS_PER_LINE - 1) begin  // Reached end of line
          dot_counter <= 9'd0;

          // Reset LY at end of frame
          if (regs.LY == LINES_PER_FRAME - 1) regs.LY <= 8'd0;

          // Advance LY at end of line
          else
            regs.LY <= regs.LY + 1'b1;

          // Raise vblank interrupt exactly when entering LY=144
          if (regs.LY == SCREEN_HEIGHT - 1) IF_bus.vblank_req <= 1'b1;

        end else begin
          // If we haven't reached end of line, then advance dot
          dot_counter <= dot_counter + 1'b1;
        end
      end
    end
  end
endmodule
