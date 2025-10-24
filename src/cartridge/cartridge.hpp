#pragma once
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

        rom.resize(size);
        if (!file.read(reinterpret_cast<char*>(rom.data()), size))
            return false;

        if (rom.size() > 0x8000)
            throw std::runtime_error("ROM too large for ROM-only cartridge");

        return true;
    }

    uint8_t read(const Address& addr) const {
        return rom[addr.value()];
    }

    void write(const Address& addr, u8 value) {
        // can't write to ROM-only cartridge
        (void)addr;
        (void)value;
    }

private:
    std::vector<uint8_t> rom;
};
