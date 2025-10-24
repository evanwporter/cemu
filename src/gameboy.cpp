#include "gameboy.hpp"
#include "cartridge/cartridge.hpp"

void GameBoy::load(const std::string& path) {
    cartridge->load(path);
}

void GameBoy::step() {
    const u8 cycles = cpu->step();

    ppu->step(cycles);
}