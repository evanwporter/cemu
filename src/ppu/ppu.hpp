#pragma once
#include "types.hpp"

class GameBoy;

class PPU {
public:
    explicit PPU(GameBoy& gb);
    ~PPU() = default;

    void reset();
    void step();

    u8 readVRAM(u16 offset) const { return 0; };
    void writeVRAM(u16 offset, u8 value) { };

    u8 readOAM(u16 offset) const { return 0; };
    void writeOAM(u16 offset, u8 value) { };

private:
    GameBoy& gb;
};
