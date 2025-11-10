`ifndef PPU_TYPES_SV
`define PPU_TYPES_SV 

typedef enum logic [1:0] {
  PPU_MODE_0,
  PPU_MODE_1,
  PPU_MODE_2,
  PPU_MODE_3
} ppu_mode_t;

typedef struct packed {
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
  logic [7:0] DMA;

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

typedef enum logic [3:0] {
  PPU_REG_NONE,
  PPU_REG_LCDC,  // 0xFF40
  PPU_REG_STAT,  // 0xFF41
  PPU_REG_SCY,  // 0xFF42
  PPU_REG_SCX,  // 0xFF43
  PPU_REG_LY,  // 0xFF44
  PPU_REG_LYC,  // 0xFF45
  PPU_REG_DMA,  // 0xFF46
  PPU_REG_BGP,  // 0xFF47
  PPU_REG_OBP0,  // 0xFF48
  PPU_REG_OBP1,  // 0xFF49
  PPU_REG_WY,  // 0xFF4A
  PPU_REG_WX  // 0xFF4B
} ppu_reg_id_t;

`endif  // PPU_TYPES_SV
