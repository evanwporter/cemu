#pragma once

#include <array>
#include <string>

#include "address.hpp"
#include "cartridge_info.hpp"

class Cartridge {
public:
    u8 read(const Address& address) const;
    void write(const Address& address, u8 value);
    bool load(const std::string& rom_filename);

    const u8* get_ram_data() const { return ram.data(); }
    uint get_ram_size() const { return ram_size; }

private:
    std::array<u8, MAX_ROM_SIZE> rom = {};
    std::array<u8, MAX_RAM_SIZE> ram = {};

    uint rom_size = 0;
    uint ram_size = 0;

    CartridgeType type;

    // MBC1-specific
    bool ram_enabled = false;
    u16 rom_bank = 1;
    u16 ram_bank = 0;
};