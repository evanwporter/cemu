import ppu_types_pkg::*;
import ppu_util_pkg::*;

`include "util/logger.svh"

module Fetcher (
    input logic clk,
    input logic reset,

    Fetcher_if.Fetcher_side bus,
    FIFO_if.Fetcher_side fifo_bus,

    // control
    input logic flush  // clear internal state (e.g., on window start)
);
  typedef enum logic [2:0] {
    FETCHER_GET_TILE,
    FETCHER_GET_LOW,
    FETCHER_GET_HIGH,
    FETCHER_PUSH
  } fetcher_state_t;

  fetcher_state_t state;

  /// Tile column index (0–31) of the tile currently being
  /// fetched from the 32x32 background/window map.
  /// Increments by 1 every time 8 pixels are pushed to the FIFO.
  logic [4:0] fetcher_x;

  /// Which tilemap to use (either `0x9800` or `0x9C00`)
  wire [15:0] tilemap_base = bus.regs.LCDC[6] ? 16'h1C00 : 16'h1800;

  /// The X coordinate of the pixel being fetched in the tilemap.
  /// Effectively: `((SCX / 8) + fetcher_x) % 32`
  wire [4:0] tilemap_x = (bus.regs.SCX[7:3] + fetcher_x) & 5'd31;

  /// The exact Y position (row) that we want to fetch from the tile.
  /// Effectively: `(SCY + LY) % 256`
  wire [7:0] tilemap_y = (bus.regs.SCY + bus.regs.LY) & 8'd255;

  /// Compute the tilemap address (the address to the index of exact tile to fetch).
  /// Effectively: `tilemap_base + (tile_y * 32) + tile_x`
  wire [15:0] tilemap_addr = tilemap_base + {8'b0, tilemap_y} + {11'b0, tilemap_x};

  /// The index of the tile to fetch from the tile data area. We get this from the tilemap.
  logic [7:0] tile_index;

  /// Which pixel row inside the tile.
  /// Effectively: `tilemap_y % 8`
  wire [2:0] tile_y = tilemap_y[2:0];

  enum logic {
    DOT_PHASE_0,
    DOT_PHASE_1
  } dot_phase;

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
    if (reset || flush) begin
      state             <= FETCHER_GET_TILE;
      dot_phase         <= DOT_PHASE_0;
      tile_index        <= 8'h00;
      tile_low_byte     <= 8'h00;
      tile_high_byte    <= 8'h00;
      fifo_bus.write_en <= 1'b0;
    end else if (bus.mode == PPU_MODE_2 && bus.dot_counter == MODE2_LEN) begin
      // Check if we are starting mode 3 this dot

      // We start off by fetching the tile at (SCX / 8)
      fetcher_x <= 5'(bus.regs.SCX >> 3);

    end else if (bus.mode == PPU_MODE_3) begin
      // Only operate in MODE 3 (drawing pixels)

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
              px.color   = gb_color_t'({tile_high_byte[7-i], tile_low_byte[7-i]});
              px.palette = 3'd0;
              px.spr_idx = 6'd0;
              px.bg_prio = 1'b0;
              px.valid   = 1'b1;

              fifo_bus.write_data[i] <= px;
            end

            fifo_bus.write_en <= 1'b1;

            // Advance to next tile
            fetcher_x         <= fetcher_x + 1;
            state             <= FETCHER_GET_TILE;

            `LOG_TRACE(("FETCHER_PUSH: burst push tile_x=%0d fifo_empty=1", fetcher_x))

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
