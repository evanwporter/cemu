#include "gameboy.hpp"
#include "cartridge/cartridge.hpp"

void GameBoy::load(const std::string& path) {
    cartridge->load(path);
}