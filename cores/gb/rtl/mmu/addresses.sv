//============================================================
// Game Boy Memory Map (DMG/CGB)
//============================================================

package gb_mmu_addresses_pkg;
  typedef logic [15:0] address_t;

  //-------------------------------
  // ROM
  //-------------------------------
  localparam address_t ROM_start = 16'h0000;
  localparam address_t ROM_end = 16'h7FFF;
  localparam address_t ROM_len = ROM_end - ROM_start + 1;

  //-------------------------------
  // VRAM
  //-------------------------------
  localparam address_t VRAM_start = 16'h8000;
  localparam address_t VRAM_end = 16'h9FFF;
  localparam address_t VRAM_len = VRAM_end - VRAM_start + 1;

  //-------------------------------
  // External RAM
  //-------------------------------
  localparam address_t ERAM_start = 16'hA000;
  localparam address_t ERAM_end = 16'hBFFF;
  localparam address_t ERAM_len = ERAM_end - ERAM_start + 1;

  //-------------------------------
  // Working RAM
  //-------------------------------
  localparam address_t WRAM_start = 16'hC000;
  localparam address_t WRAM_end = 16'hDFFF;
  localparam address_t WRAM_len = WRAM_end - WRAM_start + 1;

  //-------------------------------
  // Echo RAM (mirror of C000–DDFF)
  //-------------------------------
  localparam address_t Echo_RAM_start = 16'hE000;
  localparam address_t Echo_RAM_end = 16'hFDFF;
  localparam address_t Echo_RAM_len = Echo_RAM_end - Echo_RAM_start + 1;

  //-------------------------------
  // OAM (Object Attribute Memory)
  //-------------------------------
  localparam address_t OAM_start = 16'hFE00;
  localparam address_t OAM_end = 16'hFE9F;
  localparam address_t OAM_len = OAM_end - OAM_start + 1;

  //-------------------------------
  // Unusable memory
  //-------------------------------
  localparam address_t Unusable_start = 16'hFEA0;
  localparam address_t Unusable_end = 16'hFEFF;
  localparam address_t Unusable_len = Unusable_end - Unusable_start + 1;

  //============================================================
  // I/O Registers ($FF00–$FF7F)
  //============================================================

  // Joypad input
  localparam address_t JOYPAD_addr_start = 16'hFF00;
  localparam address_t JOYPAD_addr_end = 16'hFF00;
  localparam address_t JOYPAD_addr_len = 1;

  // Serial transfer
  localparam address_t SERIAL_addr_start = 16'hFF01;
  localparam address_t SERIAL_addr_end = 16'hFF02;
  localparam address_t SERIAL_addr_len = SERIAL_addr_end - SERIAL_addr_start + 1;

  // Timer and divider
  localparam address_t TIMER_addr_start = 16'hFF04;
  localparam address_t TIMER_addr_end = 16'hFF07;
  localparam address_t TIMER_addr_len = TIMER_addr_end - TIMER_addr_start + 1;

  // Interrupt flags
  localparam address_t IF_addr_start = 16'hFF0F;
  localparam address_t IF_addr_end = 16'hFF0F;
  localparam address_t IF_addr_len = IF_addr_end - IF_addr_start + 1;

  // Audio registers
  localparam address_t AUDIO_addr_start = 16'hFF10;
  localparam address_t AUDIO_addr_end = 16'hFF26;
  localparam address_t AUDIO_addr_len = AUDIO_addr_end - AUDIO_addr_start + 1;

  // Wave pattern RAM
  localparam address_t WAVE_addr_start = 16'hFF30;
  localparam address_t WAVE_addr_end = 16'hFF3F;
  localparam address_t WAVE_addr_len = WAVE_addr_end - WAVE_addr_start + 1;

  // LCD Control, Status, Position, Scrolling, Palettes
  localparam address_t PPU_regs_start = 16'hFF40;
  localparam address_t PPU_regs_end = 16'hFF4B;
  localparam address_t PPU_regs_len = PPU_regs_end - PPU_regs_start + 1;

  // DMA OAM Transfer
  localparam address_t DMA_OAM_addr = 16'hFF46;

  // KEY0 and KEY1 (CGB only)
  localparam address_t CGB_KEY_addr_start = 16'hFF4C;
  localparam address_t CGB_KEY_addr_end = 16'hFF4D;
  localparam address_t CGB_KEY_addr_len = CGB_KEY_addr_end - CGB_KEY_addr_start + 1;

  // VRAM Bank Select (CGB)
  localparam address_t VRAM_BANK_addr_start = 16'hFF4F;
  localparam address_t VRAM_BANK_addr_end = 16'hFF4F;
  localparam address_t VRAM_BANK_addr_len = VRAM_BANK_addr_end - VRAM_BANK_addr_start + 1;

  // Boot ROM mapping control
  localparam address_t BOOT_ROM_CTRL_addr_start = 16'hFF50;
  localparam address_t BOOT_ROM_CTRL_addr_end = 16'hFF50;
  localparam address_t BOOT_ROM_CTRL_addr_len = BOOT_ROM_CTRL_addr_end - BOOT_ROM_CTRL_addr_start + 1;

  // VRAM DMA (CGB)
  localparam address_t VRAM_DMA_addr_start = 16'hFF51;
  localparam address_t VRAM_DMA_addr_end = 16'hFF55;
  localparam address_t VRAM_DMA_addr_len = VRAM_DMA_addr_end - VRAM_DMA_addr_start + 1;

  // Infrared port (CGB)
  localparam address_t IR_PORT_addr_start = 16'hFF56;
  localparam address_t IR_PORT_addr_end = 16'hFF56;
  localparam address_t IR_PORT_addr_len = IR_PORT_addr_end - IR_PORT_addr_start + 1;

  // BG / OBJ Palettes (CGB)
  localparam address_t PALETTE_addr_start = 16'hFF68;
  localparam address_t PALETTE_addr_end = 16'hFF6B;
  localparam address_t PALETTE_addr_len = PALETTE_addr_end - PALETTE_addr_start + 1;

  // Object priority mode (CGB)
  localparam address_t OBJ_PRIORITY_addr_start = 16'hFF6C;
  localparam address_t OBJ_PRIORITY_addr_end = 16'hFF6C;
  localparam address_t OBJ_PRIORITY_addr_len = OBJ_PRIORITY_addr_end - OBJ_PRIORITY_addr_start + 1;

  // WRAM Bank Select (CGB)
  localparam address_t WRAM_BANK_addr_start = 16'hFF70;
  localparam address_t WRAM_BANK_addr_end = 16'hFF70;
  localparam address_t WRAM_BANK_addr_len = WRAM_BANK_addr_end - WRAM_BANK_addr_start + 1;

  //-------------------------------
  // High RAM (HRAM)
  //-------------------------------
  localparam address_t HRAM_start = 16'hFF80;
  localparam address_t HRAM_end = 16'hFFFE;
  localparam address_t HRAM_len = HRAM_end - HRAM_start + 1;

  // Interrupt Enable Register
  localparam address_t IE_start = 16'hFFFF;
  localparam address_t IE_end = 16'hFFFF;
  localparam address_t IE_len = IE_end - IE_start + 1;

endpackage : gb_mmu_addresses_pkg
