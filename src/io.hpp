#pragma once
#include "address.hpp"
#include "types.hpp"
#include <array>

class GameBoy;

class IO {
public:
    explicit IO(GameBoy& gb) :
        gb(gb) { }

    u8 read(const Address& address) const {
        const u16 offset = address - 0xFF00;
        return io_regs[offset];
    }

    void write(const Address& address, const u8 value) {
        const u16 offset = address - 0xFF00;
        io_regs[offset] = value;
    }

private:
    GameBoy& gb;
    std::array<u8, 0x80> io_regs {}; // 0xFF00–0xFF7F
};
