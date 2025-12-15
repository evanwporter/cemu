`ifndef PPU_FETCHER_SV
`define PPU_FETCHER_SV 

`include "ppu/types.svh"

`include "util/logger.svh"

module Fetcher (
    input logic clk,
    input logic reset,

    // timing
    input logic dot_en,  // literally just checks if the PPU is in mode 3

    // regs/scroll
    input ppu_regs_t regs,

    /// time position inside the current scanline
    input logic [8:0] x_clock,  // 0..455 dot counter

    /// Indicates whether the window is currently active.
    /// True when x >= WX-7 and LY >= WY
    input logic window_active,

    /// LY / current scanline
    input logic [7:0] y_screen,

    // VRAM access
    output logic vram_read_req,
    output logic [15:0] vram_addr,
    input logic [7:0] vram_rdata,

    // BG FIFO to push into
    input logic bg_fifo_full,
    input logic bg_fifo_empty,
    output logic bg_push_en,
    output ppu_pixel_t bg_push_px,
    output logic [4:0] pushed_count,  // TODO: how many pixels of the current row have been pushed (0..8)

    // control
    input logic flush,  // clear internal state (e.g., on window start)
    output logic [2:0] f_state_dbg
);
  typedef enum logic [2:0] {
    S_GET_TILE,
    S_GET_LOW,
    S_GET_HIGH,
    S_SLEEP,
    S_PUSH
  } fstate_t;

  fstate_t state;

  /// the visible X position on screen (0..159)
  wire [7:0] x_screen = x_clock[7:0];

  /// tile column index (0–31) of the tile currently being
  /// fetched from the 32x32 background/window map.
  /// Increments by 1 every time 8 pixels are pushed to the FIFO.
  logic [4:0] fetcher_x;

  /// tilemap column index (0..31) in the tile map
  /// Which 8-pixel tile column am I currently fetching pixels for?
  logic [4:0] tile_x;

  /// tilemap row index (0..31) in the tile map
  /// Which 8-pixel tile row of the map corresponds to the current scanline?
  logic [4:0] tile_y;

  /// absolute background X position on screen (0..255)
  wire [7:0] bg_x = regs.SCX + x_screen;

  /// absolute background Y position on screen (0..255)
  wire [7:0] bg_y = regs.SCY + y_screen;

  /// compute window screen X position (0..159)
  wire [7:0] win_x = x_screen - regs.WX;

  /// compute window screen Y position (0..255)
  wire [7:0] win_y = y_screen - regs.WY;

  /// which column inside the tile
  wire [2:0] tile_x_offset = window_active ? win_x[2:0] : bg_x[2:0];

  /// which row inside the tile
  wire [2:0] tile_y_offset = window_active ? win_y[2:0] : bg_y[2:0];

  always_comb begin
    if (window_active) begin
      tile_x = fetcher_x;
      tile_y = win_y[7:3];
    end else begin
      tile_x = ((regs.SCX[7:3] + fetcher_x) & 5'h1F);
      tile_y = bg_y[7:3];
    end
  end

  typedef enum logic {
    DOT_PHASE_0,
    DOT_PHASE_1
  } dot_phase_t;

  dot_phase_t dot_phase;

  /// 0..7 index of pixel being pushed inside tile
  logic [2:0] push_i;

  /// pixel index inside tile byte (bit 7 first unless HFLIP)
  wire [2:0] bits_to_push = 7 - push_i;

  /// compute tilemap address
  wire [15:0] tilemap_addr = tilemap_base(
      window_active
  ) + {3'b0, tile_y, 8'b0} + {8'b0, tile_x, 3'b0};

  /// Get tilemap base address (LCDC.3 for BG map; LCDC.6 for window map)
  function automatic [15:0] tilemap_base(input logic window_active);
    if (window_active) tilemap_base = (regs.LCDC[6]) ? 16'h9C00 : 16'h9800;
    else tilemap_base = (regs.LCDC[3]) ? 16'h9C00 : 16'h9800;
  endfunction

  /// tile index
  logic [7:0] tile_index;

  // low and high bytes of tile data
  // together they correspond to one row of 8 pixels
  logic [7:0] tile_low_byte, tile_high_byte;

  function automatic [15:0] tile_row_addr_fn(input logic lcdc4, input logic [7:0] tid,
                                             input logic [2:0] row);
    if (lcdc4) tile_row_addr_fn = 16'h8000 + {4'b0, tid, 4'b0} + {12'b0, row, 1'b0};
    else tile_row_addr_fn = 16'h9000 + ($signed({{8{tid[7]}}, tid}) <<< 4) + {12'b0, row, 1'b0};
  endfunction

  // reset on flush/window start
  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      state          <= S_GET_TILE;
      dot_phase      <= DOT_PHASE_0;
      fetcher_x      <= 5'd0;
      vram_read_req  <= 1'b0;
      vram_addr      <= 16'h0000;
      tile_index     <= 8'h00;
      tile_low_byte  <= 8'h00;
      tile_high_byte <= 8'h00;
      // tile_row_addr  <= 16'h0000;
      bg_push_en     <= 1'b0;
      push_i         <= 3'd0;
    end else if (dot_en) begin
      // default outputs
      vram_read_req <= 1'b0;
      bg_push_en    <= 1'b0;

      unique case (state)
        // Determine which tile to fetch and the location in VRAM
        S_GET_TILE: begin

          unique case (dot_phase)
            DOT_PHASE_0: begin
              vram_addr <= tilemap_addr;
              vram_read_req <= 1'b1;
              dot_phase <= DOT_PHASE_1;

              `LOG_TRACE(
                  ("S_GET_TILE PH0: addr=%h (tilemap_base=%h tile_x=%0d tile_y=%0d)",
                   tilemap_addr, tilemap_base(
                  window_active), tile_x, tile_y));
            end

            DOT_PHASE_1: begin
              tile_index <= vram_rdata;
              vram_read_req <= 1'b0;
              state <= S_GET_LOW;
              dot_phase <= DOT_PHASE_0;

              `LOG_TRACE(("S_GET_TILE PH1: tile_index=%0d", vram_rdata));
            end
          endcase
        end

        S_GET_LOW: begin
          // compute tiledata address based on LCDC.4 and signedness
          unique case (dot_phase)
            DOT_PHASE_0: begin
              vram_addr <= tile_row_addr_fn(regs.LCDC[4], tile_index, tile_y_offset);

              vram_read_req <= 1'b1;

              dot_phase <= DOT_PHASE_1;

              `LOG_TRACE(
                  ("S_GET_LOW  PH0: addr=%h (tile_index=%02h row=%0d lcdc4=%0b)", 
                       vram_addr, tile_index, tile_y_offset, regs.LCDC[4]));
            end

            DOT_PHASE_1: begin
              tile_low_byte <= vram_rdata;
              vram_read_req <= 1'b0;
              state <= S_GET_HIGH;
              dot_phase <= DOT_PHASE_0;

              `LOG_TRACE(("S_GET_LOW  PH1: tile_low_byte<=%02h", vram_rdata));
            end
          endcase
        end

        S_GET_HIGH: begin
          // compute tiledata address based on LCDC.4 and signedness
          unique case (dot_phase)
            DOT_PHASE_0: begin
              vram_addr <= tile_row_addr_fn(regs.LCDC[4], tile_index, tile_y_offset) + 16'd1;
              vram_read_req <= 1'b1;
              dot_phase <= DOT_PHASE_1;

              `LOG_TRACE(("S_GET_HIGH PH0: addr=%h", vram_addr));
            end

            DOT_PHASE_1: begin
              tile_high_byte <= vram_rdata;
              vram_read_req <= 1'b0;
              state <= S_SLEEP;
              dot_phase <= DOT_PHASE_0;

              `LOG_TRACE(("S_GET_HIGH PH1: tile_high_byte<=%02h", vram_rdata));
            end
          endcase
        end

        S_SLEEP: begin
          unique case (dot_phase)
            DOT_PHASE_0: begin
              dot_phase <= DOT_PHASE_1;
              `LOG_TRACE(("S_SLEEP   PH0"));
            end

            DOT_PHASE_1: begin
              dot_phase <= DOT_PHASE_0;
              state <= S_PUSH;
              `LOG_TRACE(("S_SLEEP   PH1 -> S_PUSH"));
            end
          endcase
        end

        S_PUSH: begin
          // try every dot until success (BG FIFO must be empty)
          if (bg_fifo_empty) begin
            // push 8 pixels (MSB first unless hflip)

            ppu_pixel_t px;
            px.color   <= gb_color_t'({tile_high_byte[bits_to_push], tile_low_byte[bits_to_push]});
            px.palette <= 3'd0;
            px.spr_idx <= 6'd0;
            px.bg_prio <= 1'b0;
            px.valid   <= 1'b1;

            bg_push_px <= px;
            bg_push_en <= 1'b1;
            push_i     <= push_i + 1;

            `LOG_TRACE(
                ("S_PUSH: push_i=%0d bit=%0d color=%0d push_en=1 fifo_empty=1",
                     push_i, bits_to_push, {
                tile_high_byte[bits_to_push], tile_low_byte[bits_to_push]}));

            if (push_i == 3'd7) begin
              // finished 8 pixels; advance to next tile column
              fetcher_x <= fetcher_x + 1;
              state    <= S_GET_TILE;
            end
          end else begin
            // can’t push yet; keep trying each dot
            bg_push_en <= 1'b0;

            `LOG_TRACE(("S_PUSH: finished tile, fetcher_x->%0d, state->S_GET_TILE", fetcher_x + 1));
          end
        end
      endcase
    end
  end
endmodule

`endif  // PPU_FETCHER_SV
