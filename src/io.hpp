#pragma once
#include "address.hpp"
#include "types.hpp"

class GameBoy;

class IO {
public:
    explicit IO(GameBoy& gb);
    ~IO() = default;

    u8 read(const Address& address) const { return 0xFF; };
    void write(const Address& address, const u8 value) { };

private:
    GameBoy& gb;
};
