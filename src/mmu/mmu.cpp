#include "mmu/mmu.hpp"
#include "gameboy.hpp"

MMU::MMU(GameBoy& gb) :
    gb(gb) { }

static std::array<u8, 0x10000> flatMemory {};

u8 MMU::read(u16 addr) const {

    if (!gb.cartridge && !gb.ppu && !gb.io)
        return flatMemory[addr];

    // 0000–3FFF: ROM bank 0
    if (addr <= 0x3FFF)
        return gb.cartridge->read(addr);

    // 4000–7FFF: switchable ROM bank
    else if (addr <= 0x7FFF)
        return gb.cartridge->read(addr);

    // 8000–9FFF: VRAM
    else if (addr <= 0x9FFF)
        return gb.ppu->readVRAM(addr - 0x8000);

    // A000–BFFF: External RAM
    else if (addr <= 0xBFFF)
        return gb.cartridge->read(addr);

    // C000–CFFF: Work RAM bank 0
    else if (addr <= 0xCFFF)
        return wram[addr - 0xC000];

    // D000–DFFF: Work RAM bank 1 (CGB only)
    else if (addr <= 0xDFFF)
        return wram[addr - 0xC000]; // mirror same region for now

    // E000–FDFF: Echo RAM (mirror of C000–DDFF)
    else if (addr <= 0xFDFF)
        return wram[addr - 0xE000];

    // FE00–FE9F: Sprite attribute table (OAM)
    else if (addr <= 0xFE9F)
        return gb.ppu->readOAM(addr - 0xFE00);

    // FEA0–FEFF: Not usable
    else if (addr <= 0xFEFF)
        return 0xFF;

    // FF00–FF7F: I/O registers
    else if (addr <= 0xFF7F)
        return gb.io->read(addr);

    // FF80–FFFE: High RAM
    else if (addr <= 0xFFFE)
        return hram[addr - 0xFF80];

    // FFFF: Interrupt enable register
    else if (addr == 0xFFFF)
        return interruptEnable;

    // fallback for invalid address
    return 0xFF;
}

// ---------------------
//   WRITE
// ---------------------
void MMU::write(u16 addr, u8 val) {
    if (!gb.cartridge && !gb.ppu && !gb.io) {
        flatMemory[addr] = val;
        return;
    }

    // 0000–3FFF: ROM bank 0 (control writes go to MBC)
    if (addr <= 0x3FFF)
        gb.cartridge->write(addr, val);

    // 4000–7FFF: switchable ROM bank
    else if (addr <= 0x7FFF)
        gb.cartridge->write(addr, val);

    // 8000–9FFF: VRAM
    else if (addr <= 0x9FFF)
        gb.ppu->writeVRAM(addr - 0x8000, val);

    // A000–BFFF: External RAM
    else if (addr <= 0xBFFF)
        gb.cartridge->write(addr, val);

    // C000–CFFF: Work RAM bank 0
    else if (addr <= 0xCFFF)
        wram[addr - 0xC000] = val;

    // D000–DFFF: Work RAM bank 1
    else if (addr <= 0xDFFF)
        wram[addr - 0xC000] = val;

    // E000–FDFF: Echo RAM (mirror of C000–DDFF)
    else if (addr <= 0xFDFF)
        wram[addr - 0xE000] = val;

    // FE00–FE9F: Sprite attribute table (OAM)
    else if (addr <= 0xFE9F)
        gb.ppu->writeOAM(addr - 0xFE00, val);

    // FEA0–FEFF: Not usable
    else if (addr <= 0xFEFF)
        return; // ignored

    // FF00–FF7F: I/O Registers
    else if (addr <= 0xFF7F)
        gb.io->write(addr, val);

    // FF80–FFFE: High RAM
    else if (addr <= 0xFFFE)
        hram[addr - 0xFF80] = val;

    // FFFF: Interrupt enable register
    else if (addr == 0xFFFF)
        interruptEnable = val;
}
