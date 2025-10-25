#pragma once

#include "cpu/register.hpp"
#include "definitions.hpp"

class Gameboy;

class Timer {
public:
    Timer(Gameboy& inGb);

    void tick(uint cycles);

    u8 get_divider() const;
    u8 get_timer() const;
    u8 get_timer_modulo() const;
    u8 get_timer_control() const;

    void reset_divider();
    void set_timer(u8 value);
    void set_timer_modulo(u8 value);
    void set_timer_control(u8 value);

private:
    uint clocks_needed_to_increment();

    uint clocks = 0;

    Gameboy& gb;

    Register8 divider;
    Register8 timer_counter;

    Register8 timer_modulo;
    Register8 timer_control;
};
