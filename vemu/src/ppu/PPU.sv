import ppu_types_pkg::*;
import mmu_addresses_pkg::*;

`include "util/logger.svh"

module PPU (
    input logic clk,
    input logic reset,
    Bus_if.Peripheral_side bus,
    Interrupt_if.PPU_side IF_bus
);

  // Cycle counters (reset each mode)
  logic [8:0] cycle_counter;

  // Dot counters (resets after each line)
  logic [8:0] dot_counter;

  ppu_regs_t regs;

  localparam logic [8:0] CYCLES_PER_LINE = 456;
  localparam logic [7:0] LINES_PER_FRAME = 154;

  // Mode durations in clock cycles
  localparam logic [8:0] MODE2_LEN = 80;
  localparam logic [8:0] MODE3_LEN = 172;
  localparam logic [8:0] MODE0_LEN = 204;

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
  // Background FIFO
  // ======================================================
  logic bg_push_en;
  logic bg_fifo_full, bg_fifo_empty;
  logic             bg_pop_en;
  logic       [4:0] bg_fifo_count;
  ppu_pixel_t       bg_push_px;
  ppu_pixel_t       bg_top_px;

  FIFO bg_fifo (
      .clk    (clk),
      .reset  (reset),
      .push_en(bg_push_en),
      .push_px(bg_push_px),
      .full   (bg_fifo_full),
      .pop_en (bg_pop_en),
      .top_px (bg_top_px),
      .empty  (bg_fifo_empty),
      .count  (bg_fifo_count),
      .flush  (1'b0)
  );


  // ======================================================
  // Fetcher (VRAM -> FIFO)
  // ======================================================
  logic        vram_read_req;
  logic [15:0] vram_addr;
  logic [ 7:0] vram_rdata;

  Fetcher fetcher (
      .clk          (clk),
      .reset        (reset),
      .dot_en       (dot_en),
      .regs         (regs),
      .x_clock      (cycle_counter),
      .window_active(window_active),
      .y_screen     (regs.LY),
      // VRAM bus
      .vram_read_req(vram_read_req),
      .vram_addr    (vram_addr),
      .vram_rdata   (vram_rdata),
      // FIFO interface
      .bg_fifo_full (bg_fifo_full),
      .bg_fifo_empty(bg_fifo_empty),
      .bg_push_en   (bg_push_en),
      .bg_push_px   (bg_push_px),
      .pushed_count (  /* unused for now */),
      // control
      .flush        (1'b0),
      .f_state_dbg  ()
  );

  // Fetcher reads from the VRAM immeditely.
  // TODO: block it if needed
  wire [7:0] vram_data_for_fetcher = vram_read_req ? VRAM[13'(vram_addr-16'h8000)] : '0;

  assign vram_rdata = vram_data_for_fetcher;

  // ======================================================
  // Framebuffer (FIFO -> pixel storage)
  // ======================================================
  logic fifo_pop_en;

  Framebuffer framebuffer (
      .clk        (clk),
      .reset      (reset),
      .dot_en     (dot_en),
      .fifo_empty (bg_fifo_empty),
      .fifo_pop_en(bg_pop_en),
      .fifo_top_px(bg_top_px),
      .flush      (1'b0)
  );


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
            16'hFF41: regs.STAT[6:2] <= bus.wdata[6:2];  // only bits 2-6 are writable
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
  // Update STAT
  // ======================================================

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
    if (regs.STAT[6] && regs.STAT[2]) stat_interrupt_now = 1'b1;

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
            16'hFF41: bus.rdata = regs.STAT;
            16'hFF42: bus.rdata = regs.SCY;
            16'hFF43: bus.rdata = regs.SCX;
            16'hFF44: bus.rdata = 8'h90;  // regs.LY;
            16'hFF45: bus.rdata = regs.LYC;
            // TODO: DMA transfer
            16'hFF47: bus.rdata = regs.BGP;
            default:  bus.rdata = 8'hFF;
          endcase
        end
      endcase
    end
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      mode <= PPU_MODE_2;
      regs.LY <= 8'd0;
      cycle_counter <= 0;
      regs.LCDC <= 8'hCD;
      dot_counter <= 0;
    end else begin
      cycle_counter <= cycle_counter + 1;
      dot_counter <= dot_counter + 1;

      // Regardless of mode, clear VBlank interrupt request
      IF_bus.vblank_req <= 1'd0;

      regs.STAT[2:0] <= stat_comb[2:0];

      if (regs.LCDC[7] == 1'b0) begin
        // LCD disabled
        mode <= PPU_MODE_2;
        regs.LY <= 8'd0;
        cycle_counter <= 0;
        dot_counter <= 0;

      end else begin
        // Mode switching logic
        unique case (mode)
          PPU_MODE_2: begin
            if (cycle_counter == 0) begin
              `LOG_TRACE(
                  ("[PPU] Entered MODE2 (OAM Search) at LY=%0d and dots=%0d", regs.LY, dot_counter))
              dot_counter <= 0;

            end else if (cycle_counter >= MODE2_LEN) begin
              mode <= PPU_MODE_3;
              cycle_counter <= 0;
            end
          end

          PPU_MODE_3: begin
            if (cycle_counter == 0) begin
              `LOG_TRACE(
                  ("[PPU] Entered MODE3 (Pixel Transfer) at LY=%0d and dots=%0d", regs.LY, dot_counter))

            end else if (cycle_counter >= MODE3_LEN) begin
              mode <= PPU_MODE_0;
              cycle_counter <= 0;
            end
          end

          // Do nothing phase for rest of 456 dots
          PPU_MODE_0: begin
            if (cycle_counter == 0) begin
              `LOG_TRACE(
                  ("[PPU] Entered MODE0 (HBlank) at LY=%0d and dots=%0d", regs.LY, dot_counter))

            end else if (cycle_counter == CYCLES_PER_LINE - 1) begin
              cycle_counter <= 0;
              regs.LY <= regs.LY + 1;

              if (regs.LY == 8'd143) begin
                // We displayed everything so now we just display the 10 blank lines
                mode <= PPU_MODE_1;
                IF_bus.vblank_req <= 1;
              end else
                // Goto next line
                mode <= PPU_MODE_2;
            end
          end

          PPU_MODE_1: begin
            if (cycle_counter == 0) begin
              `LOG_INFO(("[PPU] MODE1 (V-Blank) line=%0d and dots=%0d", regs.LY, dot_counter))
              dot_counter <= 0;

            end else if (cycle_counter == CYCLES_PER_LINE - 1) begin
              cycle_counter <= 0;
              regs.LY <= regs.LY + 1;
              if (regs.LY == LINES_PER_FRAME - 1) begin
                regs.LY <= 8'd0;
                mode <= PPU_MODE_2;
              end
            end
          end
        endcase
      end
    end
  end
endmodule
