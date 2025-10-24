#pragma once
#include "types.hpp"

class GameBoy;

class Timer {
public:
    Timer(GameBoy& gb);

    void reset();
    void step();

private:
    GameBoy& gb;
};
