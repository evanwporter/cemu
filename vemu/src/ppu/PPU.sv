import ppu_types_pkg::*;
import mmu_addresses_pkg::*;
import ppu_util_pkg::*;

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

  ppu_mode_t mode;

  logic flush;

  logic [7:0] VRAM[VRAM_len];
  logic [7:0] OAM[OAM_len];

  // ======================================================
  // Renderer Submodules
  // ======================================================

  // TODO: better name
  logic dot_en;
  assign dot_en = (mode == PPU_MODE_3);

  logic line_done;
  logic frame_done;

  Fetcher_if fetcher_bus (
      .regs(regs),
      .dot_counter(dot_counter),
      .mode(mode)
  );

  FIFO_if fifo_bus ();

  // Fetcher
  Fetcher fetcher_inst (
      .clk(clk),
      .reset(reset),
      .bus(fetcher_bus),
      .fifo_bus(fifo_bus),
      .flush(flush)
  );

  // FIFO
  FIFO fifo_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (fifo_bus),
      .flush(flush)
  );

  // Framebuffer
  Framebuffer framebuffer_inst (
      .clk(clk),
      .reset(reset),
      .dot_en(dot_en),
      .fifo_bus(fifo_bus),
      .flush(flush),
      .SCX(regs.SCX),
      .line_done(line_done),
      .frame_done(frame_done)
  );


  // ======================================================
  // Update STAT
  // ======================================================

  logic [7:0] LY_prev;
  ppu_mode_t mode_prev;

  // Enable STAT interrupt requests
  wire stat_en_lyc = regs.STAT[6];
  wire stat_en_mode2 = regs.STAT[5];
  wire stat_en_mode1 = regs.STAT[4];
  wire stat_en_mode0 = regs.STAT[3];

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      IF_bus.stat_req <= 1'b0;
    end else begin
      IF_bus.stat_req <= 1'b0;

      if (stat_en_lyc && regs.LY != LY_prev && regs.LY == regs.LYC) begin
        IF_bus.stat_req <= 1'b1;
      end else if (mode != mode_prev) begin
        if (stat_en_mode2 && mode == PPU_MODE_2) begin
          IF_bus.stat_req <= 1'b1;
        end else if (stat_en_mode1 && mode == PPU_MODE_1) begin
          IF_bus.stat_req <= 1'b1;
        end else if (stat_en_mode0 && mode == PPU_MODE_0) begin
          IF_bus.stat_req <= 1'b1;
        end
      end

      LY_prev   <= regs.LY;
      mode_prev <= mode;
    end
  end


  // ======================================================
  // Address Selections
  // ======================================================
  wire VRAM_selected = bus.addr inside {[VRAM_start : VRAM_end]};
  wire OAM_selected = bus.addr inside {[OAM_start : OAM_end]};
  wire PPU_regs_selected = bus.addr inside {[PPU_regs_start : PPU_regs_end]} & (bus.addr != DMA_OAM_addr);


  // ======================================================
  // Write
  // ======================================================
  always_ff @(posedge clk or posedge reset) begin
    if (bus.write_en) begin
      `LOG_TRACE(("PPU: WRITE addr=%h data=%h", bus.addr, bus.wdata))

      // VRAM writes (blocked in Mode 3)
      if (VRAM_selected) begin
        if (mode != PPU_MODE_3) begin
          VRAM[13'(bus.addr-16'h8000)] <= bus.wdata;
          `LOG_TRACE(("[PPU] VRAM WRITE addr=%h data=%h (mode=%0d)", bus.addr, bus.wdata, mode))
        end else begin
          `LOG_TRACE(
              ("[PPU] VRAM WRITE BLOCKED addr=%h data=%h (mode=%0d)", bus.addr, bus.wdata, mode))
        end
      end

      // OAM writes (blocked in Mode 2 & 3)
      if (OAM_selected) begin
        // if (!(mode == PPU_MODE_2 || mode == PPU_MODE_3)) begin
        OAM[8'(bus.addr-16'hFE00)] <= bus.wdata;
        `LOG_TRACE(("[PPU] OAM WRITE addr=%h data=%h (mode=%0d)", bus.addr, bus.wdata, mode))
        // end else begin
        //   `LOG_INFO(
        //       ("[PPU] OAM WRITE BLOCKED addr=%h data=%h (mode=%0d)", bus.addr, bus.wdata, mode))
        // end
      end

      // PPU register writes
      // TODO: check whether this ever needs to be blocked 
      if (PPU_regs_selected) begin
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
          // DMA transfer handled elsewhere
          16'hFF47: regs.BGP <= bus.wdata;
          16'hFF4A: regs.WY <= bus.wdata;
          16'hFF4B: regs.WX <= bus.wdata;
          default:  ;
        endcase
      end
    end
  end


  // ======================================================
  // Read
  // ======================================================
  always_comb begin
    bus.rdata = 8'hFF;  // open bus unless selected & allowed
    fetcher_bus.rdata = 8'hFF;

    if (fetcher_bus.read_req) begin
      // VRAM reads for fetcher (not blocked in Mode 3)
      fetcher_bus.rdata = VRAM[13'(fetcher_bus.addr)];
      `LOG_TRACE(
          ("[PPU] VRAM FETCHER READ addr=%h -> %h (mode=%0d)", fetcher_bus.addr, fetcher_bus.rdata, mode))
    end

    if (bus.read_en) begin
      // VRAM reads (blocked in Mode 3)
      if (VRAM_selected) begin
        bus.rdata = (mode == PPU_MODE_3) ? 8'hFF : VRAM[13'(bus.addr-VRAM_start)];
        `LOG_TRACE(("[PPU] VRAM READ addr=%h -> %h (mode=%0d)", bus.addr, bus.rdata, mode))
      end

      // OAM reads (blocked in Mode 2 & 3)
      if (OAM_selected) begin
        bus.rdata = OAM[8'(bus.addr-OAM_start)];
        `LOG_TRACE(("[PPU] OAM READ addr=%h -> %h (mode=%0d)", bus.addr, bus.rdata, mode))
      end

      // PPU register reads
      if (PPU_regs_selected) begin
        `LOG_TRACE(("[PPU] REG READ addr=%h -> %h", bus.addr, bus.rdata))
        case (bus.addr)
          16'hFF40: bus.rdata = regs.LCDC;
          16'hFF41: bus.rdata = {1'b1, regs.STAT[6:2], mode};
          16'hFF42: bus.rdata = regs.SCY;
          16'hFF43: bus.rdata = regs.SCX;
          16'hFF44: bus.rdata = regs.LY;
          16'hFF45: bus.rdata = regs.LYC;
          // 16'hFF46: bus.rdata = regs.DMA;
          16'hFF47: bus.rdata = regs.BGP;
          16'hFF4A: bus.rdata = regs.WY;
          16'hFF4B: bus.rdata = regs.WX;
          default:  bus.rdata = 8'hFF;
        endcase
      end
    end
  end


  // ======================================================
  // Update Mode
  // ======================================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      mode <= PPU_MODE_2;
    end else begin
      flush <= 1'b0;

      if (regs.LCDC[7] == 1'b0) begin
        mode <= PPU_MODE_2;
      end else begin
        // VBlank
        if (regs.LY >= 8'd144) begin
          mode <= PPU_MODE_1;
        end else begin
          // Visible lines
          unique case (mode)
            // OAM Scan
            PPU_MODE_2: begin
              // On dot_counter 80, enter Pixel Transfer
              if (dot_counter == MODE2_LEN - 1) begin
                mode  <= PPU_MODE_3;
                flush <= 1'b1;
              end
            end

            // Pixel Transfer
            PPU_MODE_3: begin
              if (framebuffer_inst.line_done) mode <= PPU_MODE_0;
            end

            // HBlank
            PPU_MODE_0: begin
              if (dot_counter == DOTS_PER_LINE - 1) mode <= PPU_MODE_2;
            end

            // VBlank
            PPU_MODE_1: begin
              // Exit VBlank at start of new frame
              if (regs.LY == LINES_PER_FRAME - 1 && dot_counter == DOTS_PER_LINE - 1)
                mode <= PPU_MODE_2;
            end
          endcase
        end
      end
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

      regs.STAT[2] <= regs.LY == regs.LYC;

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
          if (regs.LY == GB_SCREEN_HEIGHT - 1) IF_bus.vblank_req <= 1'b1;

        end else begin
          // If we haven't reached end of line, then advance dot
          dot_counter <= dot_counter + 1'b1;
        end
      end
    end
  end
endmodule
