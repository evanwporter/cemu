#include "ppu/ppu.hpp"
#include "gameboy.hpp"
#include "mmu/mmu.hpp"

PPU::PPU(GameBoy& gb) :
    gb(gb), mmu(*gb.mmu) { }

void PPU::requestVBlankInterrupt() {
    constexpr u8 VBLANK_BIT = 1 << 0;
    u8 ifReg = mmu.read(0xFF0F);
    mmu.write(0xFF0F, ifReg | VBLANK_BIT);
}

GBColors PPU::get_pixel(int x, int y) const {
    return framebuffer[y][x];
}

void PPU::reset() {
    // Control registers
    LCDC.set(0x91); // LCD on, BG on, window off, etc. (typical boot value)
    SCX.set(0x00);
    SCY.set(0x00);
    WX.set(0x00);
    WY.set(0x00);

    std::fill(vram.begin(), vram.end(), 0);
    std::fill(oam.begin(), oam.end(), 0);

    // Internal counters
    LY = 0;
    cycle_count = 0;
    mode = PPU_MODES::OAM_SCAN;

    // Clear framebuffer
    for (auto& row : framebuffer)
        row.fill(GBColors::Color1);

    // Fill VRAM with a visible pattern for testing
    for (int i = 0; i < 0x2000; ++i)
        vram[i] = static_cast<u8>(i & 0xFF);

    // Fill background tile map with tile IDs
    for (int i = 0; i < 32 * 32; ++i)
        vram[0x1800 + i] = i % 256; // 0x9800 - 0x8000 = 0x1800
}