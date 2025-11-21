#pragma once

#include "address.hpp"
#include "cartridge/cartridge.hpp"
#include "options.hpp"

#include <array>
#include <memory>
#include <vector>

class Gameboy;

class MMU {
public:
    MMU(Gameboy& inGb, Options& options);

    u8 read(const Address& address) const;
    void write(const Address& address, u8 byte);

    // TODO move to private
    bool boot_rom_active() const;

private:
    u8 read_io(const Address& address) const;
    void write_io(const Address& address, u8 byte);

    u8 unmapped_io_read(const Address& address) const;
    void unmapped_io_write(const Address& address, u8 byte);

    void dma_transfer(u8 byte);

    Gameboy& gb;
    Options& options;

    std::vector<u8> work_ram;
    std::vector<u8> oam_ram;
    std::vector<u8> high_ram;

    Register8 disable_boot_rom_switch;

    friend class Debugger;
};
