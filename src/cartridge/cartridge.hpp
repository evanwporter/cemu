#pragma once
#include <array>
#include <cstdint>
#include <fstream>
#include <stdexcept>
#include <string>
#include <vector>

#include "address.hpp"
#include "types.hpp"

class Cartridge {
public:
    bool load(const std::string& path) {
        std::ifstream file(path, std::ios::binary | std::ios::ate);
        if (!file)
            return false;

        const std::streamsize size = file.tellg();
        file.seekg(0, std::ios::beg);

        if (!file.read(reinterpret_cast<char*>(rom.data()), size))
            return false;

        if (rom.size() > 0x8000)
            throw std::runtime_error("ROM too large for ROM-only cartridge");

        return true;
    }

    uint8_t read_rom(const Address& addr) const {
        return rom[addr.value()];
    }

    void write_rom(const Address& addr, u8 value) {
        // can't write to ROM-only cartridge
        // (void)addr;
        // (void)value;
        // TODO: add warning
        rom[addr.value()] = value;
    }

    uint8_t read_ram(const Address& addr) const {
        return ram[addr.value() - 0xA000];
    }

    void write_ram(const Address& addr, u8 value) {
        // can't write to ROM-only cartridge
        // (void)addr;
        // (void)value;
        // TODO: add warning
        ram[addr.value() - 0xA000] = value;
    }

private:
    std::array<u8, 0x8000> rom {};
    std::array<u8, 0x2000> ram {};
};
