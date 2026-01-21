`ifndef PPU_TYPES_SVH
`define PPU_TYPES_SVH

package ppu_types_pkg;

typedef enum logic [1:0] {
  /// HBlank
  // Waiting until the end of the scanline
  PPU_MODE_0,

  /// VBlank
  // PPU is waiting until the next frame
  PPU_MODE_1,

  /// OAM Scan
  // PPU is searching for OBJs which overlap this line
  PPU_MODE_2,

  /// Drawing Pixels
  // PPU is sending pixels to the LCD
  PPU_MODE_3
} ppu_mode_t;

`ifndef VERILATOR
`define PACK_REG packed
`define PACK_PX packed
`else
`define PACK_REG 
`ifdef FETCHER_TESTBENCH
`define PACK_PX
`else
`define PACK_PX packed
`endif
`endif

typedef struct `PACK_REG {
  /// 0xFF40: LCD Control Register
  logic [7:0] LCDC;

  /// 0xFF41: LCD Status Register
  logic [7:0] STAT;

  /// 0xFF42: Scroll Y
  logic [7:0] SCY;

  /// 0xFF43: Scroll X
  logic [7:0] SCX;

  /// 0xFF44: LCD Y Coordinate
  logic [7:0] LY;

  /// 0xFF45: LY Compare
  logic [7:0] LYC;

  /// 0xFF46: DMA Transfer and Start Address
  // Handled in DMA module

  /// 0xFF47: BG Palette Data
  logic [7:0] BGP;

  /// 0xFF48: Object Palette 0 Data
  logic [7:0] OBP0;

  /// 0xFF49: Object Palette 1 Data
  logic [7:0] OBP1;

  /// 0xFF4A: Window Y Position
  logic [7:0] WY;

  /// 0xFF4B: Window X Position
  logic [7:0] WX;

} ppu_regs_t;

typedef enum logic [1:0] {
  GB_COLOR_TRANSPARENT,
  GB_COLOR_LIGHT_GRAY,
  GB_COLOR_DARK_GRAY,
  GB_COLOR_BLACK
} gb_color_t;

/// A pixel in FIFO (BG or OBJ)
typedef struct `PACK_PX {
  gb_color_t  color;
  logic [2:0] palette;  // CGB: 0..7 ; DMG: only for OBJ select (0/1). Store here.
  logic [5:0] spr_idx;  // OBJ priority (OAM index). DMG can leave 0.
  logic       bg_prio;  // OBJ-to-BG priority bit (1 = BG over OBJ).
  logic       valid;    // for FIFO empty slots
} pixel_t;

pixel_t OBJ_TRANSPARENT = '{
  color   : GB_COLOR_TRANSPARENT,
  palette : 3'd0,
  spr_idx : 6'd63,
  bg_prio : 1'b0,
  valid   : 1'b0
};

typedef struct {
  logic valid;
  logic [7:0] y_pos;
  logic [7:0] x_pos;
  logic [7:0] tile_idx;
  logic [7:0] attr;
} object_t;

typedef struct packed {
  logic valid;
  logic [5:0] oam_idx;
} object_buffer_entry_t;

endpackage : ppu_types_pkg

`endif  // PPU_TYPES_SVH
