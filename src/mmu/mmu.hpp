#pragma once
#include <array>

#include "cartridge.hpp"
#include "types.hpp"

class GameBoy;

class MMU {
public:
    MMU(GameBoy& gb);

    u8 read(u16 addr) const;

    void write(u16 addr, u8 value);

private:
    GameBoy& gb;

    /// 8 KB internal working RAM (C000–DFFF)
    std::array<u8, 0x2000> wram {};

    /// 127 bytes of high RAM (FF80–FFFE)
    std::array<u8, 0x7F> hram {};

    /// Interrupt enable register
    u8 interruptEnable = 0;
};
