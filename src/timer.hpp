#pragma once
#include "types.hpp"

class GameBoy;

class Timer {
public:
    explicit Timer(GameBoy& gb);
    ~Timer() = default;

    void reset();
    void step();

private:
    GameBoy& gb;
};
