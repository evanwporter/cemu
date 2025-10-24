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