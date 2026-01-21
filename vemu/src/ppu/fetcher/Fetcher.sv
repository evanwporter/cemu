`ifndef PPU_FETCHER
`define PPU_FETCHER 

import ppu_types_pkg::*;
import ppu_util_pkg::*;
import ppu_fetcher_types_pkg::*;

`include "util/logger.svh"

module Fetcher (
    input logic clk,
    input logic reset,

    Fetcher_if.Fetcher_side bus,
    FIFO_if.Fetcher_side fifo_bus,
    RenderingControl_if.Fetcher_side control_bus,

    // control
    input logic flush  // clear internal state (e.g., on window start)
);

  enum logic [2:0] {
    FETCHER_GET_TILE,
    FETCHER_GET_LOW,
    FETCHER_GET_HIGH,
    FETCHER_PUSH
  } state;

  dot_phase_t dot_phase;

  /// Current window line.
  /// Increments each time a new line is drawn while window is active.
  /// This overrides the normal tilemap Y coordinate.
  logic [7:0] window_line;

  /// Is the window currently enabled.
  wire window_enable = bus.regs.LCDC[5];

  /// Signed X coordinate where window starts (WX - 7).
  /// Intermidiate value for computing window visibility and tile column.
  wire signed [8:0] s_window_x_start = $signed({1'b0, bus.regs.WX}) - 9'sd7;

  /// Exact X coordinate where window starts (assuming it is visible).
  /// Effectively: max(0, `WX - 7`)
  wire [7:0] window_x_start = (s_window_x_start < 0) ? 8'd0 : s_window_x_start[7:0];

  /// Tile column index (0–31) where the window starts.
  /// Effectively: `ceil(window_x_start / 8)`
  wire [4:0] window_start_tile = 5'(((window_x_start + 8'd7) >> 3));

  /// Is the window visible on the current scanline.
  wire window_visible = window_enable && (bus.regs.LY >= bus.regs.WY) && (s_window_x_start < $signed(
      9'(GB_SCREEN_WIDTH)
  ));

  /// Tile column index (0–31) of the tile currently being
  /// fetched from the 32x32 background/window map.
  /// Increments by 1 every time 8 pixels are pushed to the FIFO.
  logic [4:0] fetcher_x;

  /// Is the window currently being drawn.
  wire window_active = window_visible && ((fetcher_x << 3) >= window_x_start);

  /// Which tilemap to use for the background (either `0x9800` or `0x9C00`).
  wire [15:0] bg_tilemap_base = bus.regs.LCDC[3] ? 16'h9C00 : 16'h9800;

  /// Which tilemap to use for the window (either `0x9800` or `0x9C00`).
  wire [15:0] win_tilemap_base = bus.regs.LCDC[6] ? 16'h9C00 : 16'h9800;

  /// The base address of the tilemap we are currently using.
  wire [15:0] tilemap_base = window_active ? win_tilemap_base : bg_tilemap_base;

  /// The X coordinate of the pixel being fetched in the tilemap.
  /// Effectively: `((SCX / 8) + fetcher_x) % 32`
  wire [4:0] tilemap_x = window_active ? (fetcher_x - window_start_tile) : ((bus.regs.SCX[7:3] + fetcher_x) & 5'd31);

  /// The exact Y position (row) that we want to fetch from the tile.
  /// Effectively: `(SCY + LY) % 256`
  wire [7:0] tilemap_y = window_active ? window_line : (bus.regs.SCY + bus.regs.LY) & 8'd255;

  /// Compute the tilemap address (the address to the index of exact tile to fetch).
  /// Effectively: `tilemap_base + ((tilemap_y / 8) * 32) + tile_x`
  wire [15:0] tilemap_addr = tilemap_base + {6'b0, tilemap_y[7:3], 5'b0} + {11'b0, tilemap_x};

  /// The index of the tile to fetch from the tile data area. We get this from the tilemap.
  logic [7:0] tile_index;

  /// Which pixel row inside the tile.
  /// Effectively: `tilemap_y % 8`
  wire [2:0] tile_y = tilemap_y[2:0];

  logic window_drew_this_line;

  /// Low and high bytes of tile data.
  /// Together they correspond to one row of 8 pixels
  logic [7:0] tile_low_byte, tile_high_byte;

  function automatic [15:0] tile_row_addr_fn(input logic lcdc4, input logic [7:0] tid,
                                             input logic [2:0] row);
    if (lcdc4) begin
      // 0x8000 + (tid * 16) + (row * 2)
      tile_row_addr_fn = 16'h8000 + 16'(tid << 4) + 16'(row << 1);
    end else begin
      // 0x9000 + (signed(tid) * 16) + (row * 2)
      tile_row_addr_fn = 16'h9000 + 16'($signed(tid) << 4) + 16'(row << 1);
    end
  endfunction

  // Reset on flush/window start
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      state             <= FETCHER_GET_TILE;
      dot_phase         <= DOT_PHASE_0;
      tile_index        <= 8'h00;
      tile_low_byte     <= 8'h00;
      tile_high_byte    <= 8'h00;
      fifo_bus.write_en <= 1'b0;
      fetcher_x         <= 0;
      window_line       <= 8'd0;

    end else if (flush) begin
      // Flush goes high right at the start of MODE 3.
      state             <= FETCHER_GET_TILE;
      dot_phase         <= DOT_PHASE_0;
      tile_index        <= 8'h00;
      tile_low_byte     <= 8'h00;
      tile_high_byte    <= 8'h00;
      fifo_bus.write_en <= 1'b0;
      fetcher_x         <= 5'd0;

    end else if (bus.regs.LY == 8'd0 && bus.mode == PPU_MODE_2 && bus.dot_counter == 0) begin
      // Start of new frame
      window_line <= 8'd0;

    end else if (bus.mode == PPU_MODE_2 && bus.dot_counter == MODE2_LEN - 1) begin
      // Check if we are starting mode 3 next dot

      if (window_visible) begin
        window_drew_this_line <= 1'b1;
      end

      // We start off by fetching the tile at (SCX / 8)
      fetcher_x <= '0;  //5'(bus.regs.SCX >> 3);

    end else if (bus.mode == PPU_MODE_0 && window_drew_this_line) begin
      // We've reached the end of the line.
      window_line <= window_line + 1;
      window_drew_this_line <= 1'b0;

    end else if (bus.mode == PPU_MODE_3 && !control_bus.stall) begin
      // Only operate in MODE 3 (drawing pixels)

      fetcher_x <= fetcher_x;

      // default outputs
      fifo_bus.write_en <= 1'b0;

      unique case (state)
        // Determine which tile to fetch and the location in VRAM (from the tile map)
        FETCHER_GET_TILE: begin

          unique case (dot_phase)
            DOT_PHASE_0: begin
              bus.addr <= tilemap_addr;
              bus.read_req <= 1'b1;
              dot_phase <= DOT_PHASE_1;

              `LOG_TRACE(
                  ("FETCHER_GET_TILE PH0: addr=%h (tilemap_base=%h tile_x=%0d tile_y=%0d)",
                   tilemap_addr, tilemap_base(
                  window_active), tile_x, tile_y))
            end

            DOT_PHASE_1: begin
              // In this cycle, the PPU has recieved our tilemap read request and updated vram_rdata

              // Latch the tile index from the tilemap
              tile_index <= bus.rdata;
              bus.read_req <= 1'b0;
              state <= FETCHER_GET_LOW;
              dot_phase <= DOT_PHASE_0;

              `LOG_TRACE(("FETCHER_GET_TILE PH1: tile_index=%0d", bus.rdata))
            end
          endcase
        end

        FETCHER_GET_LOW: begin
          // Compute tiledata address based on LCDC.4 and signedness
          unique case (dot_phase)
            DOT_PHASE_0: begin
              bus.addr <= tile_row_addr_fn(bus.regs.LCDC[4], tile_index, tile_y);

              bus.read_req <= 1'b1;

              dot_phase <= DOT_PHASE_1;

              `LOG_TRACE(
                  ("FETCHER_GET_LOW  PH0: addr=%h (tile_index=%02h row=%0d lcdc4=%0b)", 
                       bus.addr, tile_index, tile_y, bus.regs.LCDC[4]))
            end

            DOT_PHASE_1: begin
              tile_low_byte <= bus.rdata;
              bus.read_req <= 1'b0;
              state <= FETCHER_GET_HIGH;
              dot_phase <= DOT_PHASE_0;

              `LOG_TRACE(("FETCHER_GET_LOW  PH1: tile_low_byte=%02h", bus.rdata))
            end
          endcase
        end

        FETCHER_GET_HIGH: begin
          // Compute tiledata address based on LCDC.4 and signedness
          unique case (dot_phase)
            DOT_PHASE_0: begin
              bus.addr <= tile_row_addr_fn(bus.regs.LCDC[4], tile_index, tile_y) + 16'd1;

              bus.read_req <= 1'b1;

              dot_phase <= DOT_PHASE_1;

              `LOG_TRACE(("FETCHER_GET_HIGH PH0: addr=%h", bus.addr))
            end

            DOT_PHASE_1: begin
              tile_high_byte <= bus.rdata;
              bus.read_req <= 1'b0;
              state <= FETCHER_PUSH;
              dot_phase <= DOT_PHASE_0;

              `LOG_TRACE(("FETCHER_GET_HIGH PH1: tile_high_byte=%02h", bus.rdata))
            end
          endcase
        end

        FETCHER_PUSH: begin
          // Try every dot until success (BG FIFO must be empty)
          if (fifo_bus.empty) begin
            // Push 8 pixels (MSB first unless hflip)

            pixel_t px;

            // Build all 8 pixels in parallel
            for (int i = 0; i < 8; i++) begin
              px.color = color_id_t'({tile_high_byte[7-i], tile_low_byte[7-i]});
              px.dmg_palette = 1'd0;
              px.spr_idx = 6'd0;
              px.bg_prio = 1'b0;
              px.valid = 1'b1;

              fifo_bus.write_data[i] <= px;
            end

            fifo_bus.write_en <= 1'b1;

            // Advance to next tile
            fetcher_x         <= fetcher_x + 1;
            state             <= FETCHER_GET_TILE;

            // $display("FETCHER_PUSH: push fetcher_x=%0d, tile_index=%0d tilemap_addr=%h", fetcher_x,
            //          tile_index, tilemap_addr);
            // $fflush();

          end else begin
            // Can’t push yet; keep trying each dot
            fifo_bus.write_en <= 1'b0;

            // $display("FETCHER_PUSH: finished tile, fetcher_x->%0d, state->FETCHER_GET_TILE",
            //          fetcher_x + 1);
          end
        end
      endcase
    end
  end
endmodule

`endif  // PPU_FETCHER
