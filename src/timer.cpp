#include "timer.hpp"

#include "cpu/cpu.hpp"
#include "definitions.hpp"
#include "gameboy.hpp"
#include "util/bitops.hpp"

const uint CLOCKS_PER_CYCLE = 4;

Timer::Timer(Gameboy& _gb) :
    gb(_gb) { }

void Timer::tick(uint cycles) {
    u8 new_divider = static_cast<u8>(divider.value() + cycles);
    divider.set(new_divider);

    clocks += cycles * CLOCKS_PER_CYCLE;

    auto timer_is_on = check_bit(timer_control.value(), 2);
    if (timer_is_on == 0) {
        return;
    }

    auto clock_limit = clocks_needed_to_increment();

    if (clocks >= clock_limit) {
        clocks = clocks % clock_limit;

        u8 old_timer_counter = timer_counter.value();
        timer_counter.increment();

        if (timer_counter.value() < old_timer_counter) {
            gb.cpu->interrupt_flag.set_bit_to(2, true);
            timer_counter.set(timer_modulo.value());
        }
    }
}

u8 Timer::get_divider() const { return divider.value(); }

u8 Timer::get_timer() const { return timer_counter.value(); }

u8 Timer::get_timer_modulo() const { return timer_modulo.value(); }

// Only the bottom three bits of this register are usable
u8 Timer::get_timer_control() const { return timer_control.value() & 0x3; }

void Timer::reset_divider() {
    divider.set(0x0);
}

void Timer::set_timer(u8 value) {
    timer_counter.set(value);
}

void Timer::set_timer_modulo(u8 value) {
    timer_modulo.set(value);
}

void Timer::set_timer_control(u8 value) {
    timer_control.set(value);
}

uint Timer::clocks_needed_to_increment() {

    switch (get_timer_control()) {
    case 0:
        return CLOCK_RATE / 4096;
    case 1:
        return CLOCK_RATE / 262144;
    case 2:
        return CLOCK_RATE / 65536;
    case 3:
        return CLOCK_RATE / 16384;
    default:
        fatal_error("Invalid calculation in timer");
    }
}
