import ppu_types_pkg::*;
import mmu_addresses_pkg::*;
import ppu_util_pkg::*;

`include "util/logger.svh"

module PPU (
    input logic clk,
    input logic reset,
    Bus_if.Slave_side bus,
    Interrupt_if.PPU_side IF_bus,
    DMA_if.DMA_side dma_bus
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
  logic pixel_transfer_en;
  assign pixel_transfer_en = (mode == PPU_MODE_3);

  logic line_done;

  (* maybe_unused *)
  logic frame_done;

  object_t sprites_found[10];

  Fetcher_if fetcher_bus (
      .regs(regs),
      .dot_counter(dot_counter),
      .mode(mode)
  );

  Fetcher_if obj_fetcher_bus (
      .regs(regs),
      .dot_counter(dot_counter),
      .mode(mode)
  );

  FIFO_if fifo_bus ();

  FIFO_if obj_fifo_bus ();

  RenderingControl_if rendering_control_bus ();

  // Fetcher
  Fetcher fetcher_inst (
      .clk(clk),
      .reset(reset),
      .bus(fetcher_bus),
      .fifo_bus(fifo_bus),
      .control_bus(rendering_control_bus),
      .flush(flush)
  );

  ObjFetcher obj_fetcher_inst (
      .clk        (clk),
      .reset      (reset),
      .bus        (obj_fetcher_bus),
      .control_bus(rendering_control_bus),
      .fifo_bus   (obj_fifo_bus),
      .sprite_buf (sprites_found)
  );

  // FIFO
  FIFO fifo_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (fifo_bus),
      .flush(flush)
  );

  // FIFO for objects
  Obj_FIFO obj_fifo_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (obj_fifo_bus),
      .flush(flush)
  );

  // Framebuffer
  Framebuffer framebuffer_inst (
      .clk(clk),
      .reset(reset),
      .pixel_transfer_en(pixel_transfer_en),
      .fifo_bus(fifo_bus),
      .obj_fifo_bus(obj_fifo_bus),
      .control_bus(rendering_control_bus),
      .flush(flush),
      .regs(regs),
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
        if (dma_bus.active || !(mode == PPU_MODE_2 || mode == PPU_MODE_3)) begin
          OAM[8'(bus.addr-16'hFE00)] <= bus.wdata;
          `LOG_TRACE(("[PPU] OAM WRITE addr=%h data=%h (mode=%0d)", bus.addr, bus.wdata, mode))
        end else begin
          `LOG_INFO(
              ("[PPU] OAM WRITE BLOCKED addr=%h data=%h (mode=%0d)", bus.addr, bus.wdata, mode))
        end
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
          16'hFF48: regs.OBP0 <= bus.wdata;
          16'hFF49: regs.OBP1 <= bus.wdata;
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
    obj_fetcher_bus.rdata = 8'hFF;

    if (obj_fetcher_bus.read_req) begin
      // VRAM reads for obj fetcher (not blocked in Mode 3)
      obj_fetcher_bus.rdata = VRAM[13'(obj_fetcher_bus.addr-VRAM_start)];
      // $display("[PPU] VRAM OBJ FETCHER READ addr=%h -> %h (mode=%0d)", obj_fetcher_bus.addr,
      //          obj_fetcher_bus.rdata, mode);
    end

    if (fetcher_bus.read_req) begin
      // VRAM reads for fetcher (not blocked in Mode 3)
      fetcher_bus.rdata = VRAM[13'(fetcher_bus.addr-VRAM_start)];
      // $display("[PPU] VRAM FETCHER READ addr=%h -> %h (mode=%0d)", fetcher_bus.addr,
      //          fetcher_bus.rdata, mode);
    end

    if (bus.read_en) begin

      // VRAM reads (blocked in Mode 3)
      if (VRAM_selected) begin
        bus.rdata = (mode == PPU_MODE_3) ? 8'hFF : VRAM[13'(bus.addr-VRAM_start)];
        `LOG_TRACE(("[PPU] VRAM READ addr=%h -> %h (mode=%0d)", bus.addr, bus.rdata, mode))
      end

      // OAM reads (blocked in Mode 2 & 3)
      if (OAM_selected) begin
        bus.rdata = dma_bus.active ? 8'hFF : OAM[8'(bus.addr-OAM_start)];
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
          16'hFF48: bus.rdata = regs.OBP0;
          16'hFF49: bus.rdata = regs.OBP1;
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

      if (!regs.LCDC[7]) begin
        mode <= PPU_MODE_2;
      end else begin
        // Visible lines
        unique case (mode)
          // OAM Scan
          PPU_MODE_2: begin
            // On dot_counter 80, enter Pixel Transfer
            if (dot_counter == MODE2_LEN - 1) begin
              mode  <= PPU_MODE_3;
              flush <= 1'b1;
              // $display("[PPU] Entering MODE 3 at LY=%0d", regs.LY);
            end
          end

          // Pixel Transfer
          PPU_MODE_3: begin
            if (line_done) begin
              mode <= PPU_MODE_0;
              // $display("[PPU] Entering MODE 0 at LY=%0d", regs.LY);
            end
          end

          // HBlank
          PPU_MODE_0: begin
            if (dot_counter == DOTS_PER_LINE - 1) begin
              if (regs.LY == GB_SCREEN_HEIGHT - 1)
                mode <= PPU_MODE_1;  // enter VBlank after line 143
              else mode <= PPU_MODE_2;
            end
          end

          // VBlank
          PPU_MODE_1: begin
            if (regs.LY == LINES_PER_FRAME - 1 && dot_counter == DOTS_PER_LINE - 1)
              mode <= PPU_MODE_2;  // start next frame
          end
        endcase
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


  // ======================================================
  // OAM Scan
  // ======================================================

  /// Current sprite being scanned (0-39)
  /// Each sprite takes 2 dots to scan
  /// Effectively: `dot_counter / 2`
  wire [5:0] sprite_num = dot_counter[6:1];

  /// Current sprite index in OAM (0-159)
  /// Effectively: `sprite_num * 4`
  wire [7:0] sprite_idx = 8'(sprite_num) << 2;

  logic [3:0] sprites_found_count;

  enum logic {
    T1,
    T2
  } scan_state;

  assign scan_state = (dot_counter[0]) ? T2 : T1;

  wire [4:0] sprite_height = regs.LCDC[2] ? 5'd16 : 5'd8;

  object_t current_sprite;
  always_comb begin
    current_sprite.y_pos = OAM[sprite_idx+0];
    current_sprite.x_pos = OAM[sprite_idx+1];
    current_sprite.tile_idx = OAM[sprite_idx+2];
    current_sprite.attr = OAM[sprite_idx+3];
    current_sprite.oam_idx = sprite_num;
    current_sprite.valid = 1'b1;
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < 10; i++) begin
        sprites_found[i].y_pos    <= 8'd0;
        sprites_found[i].x_pos    <= 8'd0;
        sprites_found[i].tile_idx <= 8'd0;
        sprites_found[i].attr     <= 8'd0;
        sprites_found[i].valid    <= 1'b0;
      end
      sprites_found_count <= 4'd0;
    end else begin
      if (dot_counter == 9'd455) begin
        sprites_found_count <= 4'd0;
        for (int i = 0; i < 10; i++) begin
          sprites_found[i].valid <= 1'b0;
        end
      end

      if (mode == PPU_MODE_2) begin
        unique case (scan_state)
          T1: begin
            if ((sprites_found_count < 10) &&
                (regs.LY + 16 >= current_sprite.y_pos) &&
                (regs.LY + 16 <  current_sprite.y_pos + 8'(sprite_height))) begin
              sprites_found[sprites_found_count] <= current_sprite;
              sprites_found_count <= sprites_found_count + 1'b1;
              if (current_sprite.y_pos == 8'd56) begin
                // $display("[%0d] DC=%0d OAM idx=%0d -> write sprite[%0d] x=%0d y=%0d", sprite_num,
                //          dot_counter, sprite_idx, sprites_found_count, current_sprite.x_pos,
                //          current_sprite.y_pos);
              end
            end else begin
              // $display("[%0d] DC=%0d OAM idx=%0d -> skip", sprite_num, dot_counter, sprite_idx);
            end
          end

          T2: begin
            //
          end
        endcase
      end
    end
  end
endmodule
