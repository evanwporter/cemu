#include "mmu/mmu.hpp"
#include "address.hpp"
#include "cartridge/cartridge.hpp"
#include "defines.hpp"
#include "gameboy.hpp"

MMU::MMU(GameBoy& gb) :
    gb(gb) { }

static std::array<u8, 0x10000> flatMemory {};

u8 MMU::read(const u16 addr) const {
    return read(Address(addr));
}

u8 MMU::read(const Address& addr) const {

    // return flatMemory[addr];

    // FFFF: Interrupt enable register
    if (addr == INTERRUPT_ENABLE)
        return gb.cpu->interrupt_enabled.get();

    // FFFF: Interrupt enable register
    else if (addr == INTERRUPT_FLAG)
        return gb.cpu->interrupt_flag.get();

    // FF4B: Window X register
    else if (addr == 0xFF4B)
        return gb.ppu->WX.get();

    // FF4A: Window Y register
    else if (addr == 0xFF4A)
        return gb.ppu->WY.get();

    // FF43: Scroll X register
    else if (addr == 0xFF43)
        return gb.ppu->SCX.get();

    // FF42: Scroll Y register
    else if (addr == 0xFF42)
        return gb.ppu->SCY.get();

    // FF40: LCD control register
    else if (addr == 0xFF40)
        return gb.ppu->lcd_control.get();

    // FF41: LCD status register
    else if (addr == 0xFF41)
        return gb.ppu->lcd_status.get();

    // FF44: LY register
    else if (addr == 0xFF44)
        return gb.ppu->LY;

    // FF45 LY compare register
    else if (addr == LY_COMPARE)
        return gb.ppu->LY_compare;

    // 0000–3FFF: ROM bank 0
    else if (addr <= 0x3FFF)
        return gb.cartridge->read_rom(addr);

    // 4000–7FFF: switchable ROM bank
    else if (addr <= 0x7FFF)
        return gb.cartridge->read_rom(addr);

    // 8000–9FFF: VRAM
    else if (addr <= 0x9FFF)
        return gb.ppu->readVRAM(addr);

    // A000–BFFF: External RAM
    else if (addr <= 0xBFFF)
        return gb.cartridge->read_ram(addr);

    // C000–CFFF: Work RAM bank 0
    else if (addr <= 0xCFFF)
        return wram[addr.value(0xC000)];

    // D000–DFFF: Work RAM bank 1 (CGB only)
    else if (addr <= 0xDFFF)
        return wram[addr.value(0xC000)]; // mirror same region for now

    // E000–FDFF: Echo RAM (mirror of C000–DDFF)
    else if (addr <= 0xFDFF)
        // TODO: add warning for using echo RAM
        return wram[addr.value(0xE000)];

    // FE00–FE9F: Sprite attribute table (OAM)
    else if (addr <= 0xFE9F)
        return gb.ppu->readOAM(addr);

    // FEA0–FEFF: Not usable
    else if (addr <= 0xFEFF)
        // turn on only for test cases that need it
        return unusable_ram[addr.value() - 0xFEA0];

    // FF00–FF7F: I/O registers
    else if (addr <= 0xFF7F)
        return gb.io->read(addr);

    // FF80–FFFE: High RAM
    else if (addr <= 0xFFFE)
        return hram[addr - 0xFF80];

    // fallback for invalid address
    return 0xFF;
}

void MMU::write(const u16 addr, const u8 val) {
    write(Address(addr), val);
}

void MMU::write(const Address& addr, const u8 val) {
    // flatMemory[addr] = val;
    // return;

    // FFFF: Interrupt enable register
    if (addr == 0xFFFF) {
        gb.cpu->interrupt_enabled.set(val);
        return;
    }

    // FF0F: Interrupt flag register
    else if (addr == 0xFF0F) {
        gb.cpu->interrupt_flag.set(val);
        return;
    }

    // FF4B: Window X register
    else if (addr == 0xFF4B) {
        gb.ppu->WX.set(val);
        return;
    }

    // FF4A: Window Y register
    else if (addr == 0xFF4A) {
        gb.ppu->WY.set(val);
        return;
    }

    // FF40: LCD control register
    else if (addr == 0xFF40) {
        gb.ppu->lcd_control.set(val);
        return;
    }

    // FF41: LCD status register
    else if (addr == 0xFF41) {
        gb.ppu->lcd_status.set(val);
        return;
    }

    // FF42: Scroll Y register
    else if (addr == 0xFF42) {
        gb.ppu->SCY.set(val);
        return;
    }

    // FF43: Scroll X register
    else if (addr == 0xFF43) {
        gb.ppu->SCX.set(val);
        return;
    }

    // FF44: LY register
    else if (addr == 0xFF44) {
        gb.ppu->LY = val;
        return;
    }

    // FF45 LY compare register
    else if (addr == LY_COMPARE) {
        gb.ppu->LY_compare = val;
        return;
    }

    // 0000–3FFF: ROM bank 0 (control writes go to MBC)
    else if (addr <= 0x3FFF)
        gb.cartridge->write_rom(addr, val);

    // 4000–7FFF: switchable ROM bank
    else if (addr <= 0x7FFF)
        gb.cartridge->write_rom(addr, val);

    // 8000–9FFF: VRAM
    else if (addr <= 0x9FFF)
        gb.ppu->writeVRAM(addr, val);

    // A000–BFFF: External RAM
    else if (addr <= 0xBFFF)
        gb.cartridge->write_ram(addr, val);

    // C000–CFFF: Work RAM bank 0
    else if (addr <= 0xCFFF)
        wram[addr.value(0xC000)]
            = val;

    // D000–DFFF: Work RAM bank 1
    else if (addr <= 0xDFFF)
        wram[addr.value(0xC000)]
            = val;

    // E000–FDFF: Echo RAM (mirror of C000–DDFF)
    else if (addr <= 0xFDFF)
        wram[addr.value(0xE000)]
            = val;

    // FE00–FE9F: Sprite attribute table (OAM)
    else if (addr <= 0xFE9F)
        gb.ppu->writeOAM(addr, val);

    // FEA0–FEFF: Not usable
    else if (addr <= 0xFEFF)
        unusable_ram[addr.value() - 0xFEA0] = val;

    // FF00–FF7F: I/O Registers
    else if (addr <= 0xFF7F)
        gb.io->write(addr, val);

    // FF80–FFFE: High RAM
    else if (addr <= 0xFFFE)
        hram[addr.value(0xFF80)] = val;
}
