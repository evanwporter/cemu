// TODO rename file something else

package Cartridge_pkg;
  //============================================================
  // Cartridge Constants
  //============================================================

  /// 16KiB per ROM bank
  localparam int unsigned ROM_BANK_SIZE = 16 * 1024;

  /// Maximum number of ROM banks supported
  localparam int unsigned MAX_ROM_BANKS = 512;

  /// Maximum ROM Size is 8 MiB.
  /// However only 32 KiB can be addressed at a time.
  localparam int unsigned MAX_ROM_SIZE = MAX_ROM_BANKS * ROM_BANK_SIZE;

  /// 8KiB per RAM bank
  localparam int unsigned RAM_BANK_SIZE = 8 * 1024;

  /// Maximum number of RAM banks supported
  localparam int unsigned MAX_RAM_BANKS = 16;

  /// Maximum RAM Size is 128 KiB.
  /// However only 8 KiB can be addressed at a time.
  localparam int unsigned MAX_RAM_SIZE = MAX_RAM_BANKS * RAM_BANK_SIZE;
endpackage : Cartridge_pkg
