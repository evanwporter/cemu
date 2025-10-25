#include "cartridge.hpp"
#include "cartridge_info.hpp"

#include "util/log.hpp"

#include <fstream>

u8 Cartridge::read(const Address& address) const {
    switch (type) {
    case CartridgeType::ROMOnly:
        if (address.value() < rom_size)
            return rom[address.value()];
        fatal_error("ROM-only read out of range 0x%x", address.value());
        break;

    case CartridgeType::MBC1: {
        if (address.in_range(0x0000, 0x3FFF)) {
            return rom[address.value()];
        }
        if (address.in_range(0x4000, 0x7FFF)) {
            uint bank_offset = 0x4000 * rom_bank;
            uint address_in_rom = bank_offset + (address.value() - 0x4000);
            if (address_in_rom < rom_size)
                return rom[address_in_rom];
            fatal_error("MBC1 read beyond ROM size");
        }
        if (address.in_range(0xA000, 0xBFFF)) {
            if (!ram_enabled)
                return 0xFF;
            uint offset = (ram_bank * 0x2000) + (address.value() - 0xA000);
            if (offset < ram_size)
                return ram[offset];
            fatal_error("MBC1 read beyond RAM size");
        }
        break;
    }
    default:
        log_unimplemented("Read from unmapped cartridge type");
    }
    return 0xFF;
}

void Cartridge::write(const Address& address, u8 value) {

    switch (type) {
    case CartridgeType::ROMOnly: {
        log_warn("Attempting to write to cartridge ROM without an MBC");
        break;
    }
    case CartridgeType::MBC1: {

        if (address.in_range(0x0000, 0x1FFF)) {
            ram_enabled = (value & 0x0A) != 0;
            return;
        }

        if (address.in_range(0x2000, 0x3FFF)) {
            rom_bank = value & 0x1F;
            if (rom_bank == 0)
                rom_bank = 1;
            return;
        }

        if (address.in_range(0xA000, 0xBFFF) && ram_enabled) {
            uint offset = (ram_bank * 0x2000) + (address.value() - 0xA000);
            if (offset < ram_size)
                ram[offset] = value;
            return;
        }
    }
    case CartridgeType::MBC2:
    case CartridgeType::MBC3:
    case CartridgeType::MBC4:
    case CartridgeType::MBC5:
    case CartridgeType::Unknown:
        break;
    }
}

bool Cartridge::load(const std::string& rom_filename) {
    std::ifstream rom_file(rom_filename, std::ios::binary);
    if (!rom_file.good()) {
        log_error("Failed to open ROM file: %s", rom_filename.c_str());
        return false;
    }

    // Read ROM bytes directly into the array
    rom_file.read(reinterpret_cast<char*>(rom.data()), MAX_ROM_SIZE);
    rom_size = static_cast<size_t>(rom_file.gcount());
    log_info("Loaded %zu KB from %s", rom_size / 1024, rom_filename.c_str());

    if (rom_size > 0x147) {
        type = get_cartridge_type(rom);
        log_info("Detected cartridge type: %s", describe(type).c_str());
    } else {
        type = CartridgeType::Unknown;
        log_warn("ROM too small to contain a header");
    }

    // Try to load matching .sav file (if exists)
    std::string save_filename = rom_filename + ".sav";
    ram_size = 0;

    std::ifstream save_file(save_filename, std::ios::binary);
    if (save_file) {
        save_file.read(reinterpret_cast<char*>(ram.data()), MAX_RAM_SIZE);
        ram_size = static_cast<size_t>(save_file.gcount());
        log_info("Loaded %zu KB from %s", ram_size / 1024, save_filename.c_str());
    } else {
        log_info("No save file found, initializing empty RAM");
        ram.fill(0);
        ram_size = MAX_RAM_SIZE;
    }

    return true;
}