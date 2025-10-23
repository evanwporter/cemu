#pragma once
#include "types.hpp"

class GameBoy;

class IO {
public:
    explicit IO(GameBoy& gb);
    ~IO() = default;

    u8 read(u16 address) const { return 0; };
    void write(u16 address, u8 value) { };

private:
    GameBoy& gb;
};
