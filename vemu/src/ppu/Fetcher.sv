import ppu_types_pkg::*;

`include "util/logger.svh"

module Fetcher (
    input logic clk,
    input logic reset,

    Fetcher_if.Fetcher_side bus,
    FIFO_if.Fetcher_side fifo_bus,

    // timing
    input logic dot_en,  // literally just checks if the PPU is in mode 3

    // regs/scroll
    input ppu_regs_t regs,

    // control
    input logic flush  // clear internal state (e.g., on window start)
);
  typedef enum logic [2:0] {
    FETCHER_GET_TILE,
    FETCHER_GET_LOW,
    FETCHER_GET_HIGH,
    FETCHER_SLEEP,
    FETCHER_PUSH
  } fetcher_state_t;

  fetcher_state_t state;

  /// Tile column index (0–31) of the tile currently being
  /// fetched from the 32x32 background/window map.
  /// Increments by 1 every time 8 pixels are pushed to the FIFO.
  logic [4:0] fetcher_x;

  /// Which tilemap to use (either 0x9800 or 0x9C00)
  wire [15:0] tilemap_base = regs.LCDC[6] ? 16'h1C00 : 16'h1800;

  /// The X coordinate of the pixel being fetched in the tilemap
  /// Effectively: ((SCX / 3) + fetcher_x) % 32
  wire [4:0] tilemap_x = (regs.SCX[7:3] + fetcher_x) & 5'd31;

  /// The exact Y position (row) that we want to fetch from the tile
  /// Effectively: (SCY + LY) % 256
  wire [7:0] tilemax_y = (regs.SCY + regs.LY) & 8'd255;

  /// Compute the tilemap address (the address to the index of exact tile to fetch)
  /// Effectively: tilemap_base + (tile_y * 32) + tile_x
  wire [15:0] tilemap_addr = tilemap_base + {8'b0, tilemax_y} + {11'b0, tilemap_x};

  /// The index of the tile to fetch from the tile data area. We get this from the tilemap.
  logic [7:0] tile_index;

  /// Which pixel row inside the tile.
  /// Effectively: tilemax_y % 8
  wire [2:0] tile_y = tilemax_y[2:0];

  enum logic {
    DOT_PHASE_0,
    DOT_PHASE_1
  } dot_phase;

  /// 0..7 index of pixel being pushed inside tile
  logic [2:0] push_i;

  /// pixel index inside tile byte (bit 7 first unless HFLIP)
  wire [2:0] bits_to_push = 7 - push_i;

  /// Low and high bytes of tile data.
  /// Together they correspond to one row of 8 pixels
  logic [7:0] tile_low_byte, tile_high_byte;

  function automatic [15:0] tile_row_addr_fn(input logic lcdc4, input logic [7:0] tid,
                                             input logic [2:0] row);
    if (lcdc4) tile_row_addr_fn = 16'h8000 + {4'b0, tid, 4'b0} + {12'b0, row, 1'b0};
    else tile_row_addr_fn = 16'h9000 + ($signed({{8{tid[7]}}, tid}) <<< 4) + {12'b0, row, 1'b0};
  endfunction

  // reset on flush/window start
  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      state             <= FETCHER_GET_TILE;
      dot_phase         <= DOT_PHASE_0;
      fetcher_x         <= 5'd0;
      tile_index        <= 8'h00;
      tile_low_byte     <= 8'h00;
      tile_high_byte    <= 8'h00;
      fifo_bus.write_en <= 1'b0;
      push_i            <= 3'd0;
    end else if (dot_en) begin
      // default outputs
      fifo_bus.write_en <= 1'b0;

      unique case (state)
        // Determine which tile to fetch and the location in VRAM (from the tile map)
        FETCHER_GET_TILE: begin

          unique case (dot_phase)
            DOT_PHASE_0: begin
              bus.vram_addr <= tilemap_addr;
              bus.vram_read_req <= 1'b1;
              dot_phase <= DOT_PHASE_1;

              `LOG_TRACE(
                  ("FETCHER_GET_TILE PH0: addr=%h (tilemap_base=%h tile_x=%0d tile_y=%0d)",
                   tilemap_addr, tilemap_base(
                  window_active), tile_x, tile_y))
            end

            DOT_PHASE_1: begin
              // In this cycle, the PPU has recieved our tilemap read request and updated vram_rdata

              // Latch the tile index from the tilemap
              tile_index <= bus.vram_rdata;
              bus.vram_read_req <= 1'b0;
              state <= FETCHER_GET_LOW;
              dot_phase <= DOT_PHASE_0;

              `LOG_TRACE(("FETCHER_GET_TILE PH1: tile_index=%0d", bus.vram_rdata))
            end
          endcase
        end

        FETCHER_GET_LOW: begin
          // Compute tiledata address based on LCDC.4 and signedness
          unique case (dot_phase)
            DOT_PHASE_0: begin
              bus.vram_addr <= tile_row_addr_fn(regs.LCDC[4], tile_index, tile_y);

              bus.vram_read_req <= 1'b1;

              dot_phase <= DOT_PHASE_1;

              `LOG_TRACE(
                  ("FETCHER_GET_LOW  PH0: addr=%h (tile_index=%02h row=%0d lcdc4=%0b)", 
                       bus.vram_addr, tile_index, tile_y, regs.LCDC[4]))
            end

            DOT_PHASE_1: begin
              tile_low_byte <= bus.vram_rdata;
              bus.vram_read_req <= 1'b0;
              state <= FETCHER_GET_HIGH;
              dot_phase <= DOT_PHASE_0;

              `LOG_TRACE(("FETCHER_GET_LOW  PH1: tile_low_byte=%02h", bus.vram_rdata))
            end
          endcase
        end

        FETCHER_GET_HIGH: begin
          // Compute tiledata address based on LCDC.4 and signedness
          unique case (dot_phase)
            DOT_PHASE_0: begin
              bus.vram_addr <= tile_row_addr_fn(regs.LCDC[4], tile_index, tile_y) + 16'd1;
              bus.vram_read_req <= 1'b1;
              dot_phase <= DOT_PHASE_1;

              `LOG_TRACE(("FETCHER_GET_HIGH PH0: addr=%h", bus.vram_addr))
            end

            DOT_PHASE_1: begin
              tile_high_byte <= bus.vram_rdata;
              bus.vram_read_req <= 1'b0;
              state <= FETCHER_SLEEP;
              dot_phase <= DOT_PHASE_0;

              `LOG_TRACE(("FETCHER_GET_HIGH PH1: tile_high_byte=%02h", bus.vram_rdata))
            end
          endcase
        end

        FETCHER_SLEEP: begin
          unique case (dot_phase)
            DOT_PHASE_0: begin
              dot_phase <= DOT_PHASE_1;
              `LOG_TRACE(("FETCHER_SLEEP   PH0"))
            end

            DOT_PHASE_1: begin
              dot_phase <= DOT_PHASE_0;
              state <= FETCHER_PUSH;
              `LOG_TRACE(("FETCHER_SLEEP   PH1 -> FETCHER_PUSH"))
            end
          endcase
        end

        FETCHER_PUSH: begin
          // Try every dot until success (BG FIFO must be empty)
          if (fifo_bus.empty) begin
            // Push 8 pixels (MSB first unless hflip)

            pixel_t px;
            px.color   = gb_color_t'({tile_high_byte[bits_to_push], tile_low_byte[bits_to_push]});
            px.palette = 3'd0;
            px.spr_idx = 6'd0;
            px.bg_prio = 1'b0;
            px.valid   = 1'b1;

            fifo_bus.write_data <= px;
            fifo_bus.write_en <= 1'b1;
            push_i <= push_i + 1;

            `LOG_TRACE(
                ("FETCHER_PUSH: push_i=%0d bit=%0d color=%0d push_en=1 fifo_empty=1", push_i, bits_to_push, {
                  tile_high_byte[bits_to_push], tile_low_byte[bits_to_push]}))

            if (push_i == 3'd7) begin
              // Finished 8 pixels; advance to next tile column
              fetcher_x <= fetcher_x + 1;
              state    <= FETCHER_GET_TILE;
            end
          end else begin
            // Can’t push yet; keep trying each dot
            fifo_bus.write_en <= 1'b0;

            `LOG_TRACE(
                ("FETCHER_PUSH: finished tile, fetcher_x->%0d, state->FETCHER_GET_TILE", fetcher_x + 1))
          end
        end
      endcase
    end
  end
endmodule
