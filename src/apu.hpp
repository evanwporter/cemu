#pragma once
#include "types.hpp"

class GameBoy;

class APU {
public:
    explicit APU(GameBoy& gb);
    ~APU() = default;

    void reset();
    void step();

private:
    GameBoy& gb;
};
