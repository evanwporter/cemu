#pragma once
#include <cstdint>
#include <verilated.h>

using u8 = uint8_t;
using u16 = uint16_t;

extern vluint64_t global_timestamp;

inline double sc_time_stamp() { return global_timestamp; }

template <typename T>
inline void tick(T& top, VerilatedContext& ctx) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(1);

    top.clk = 1;
    top.eval();
    ctx.timeInc(1);
}

template <typename T>
inline void reset_dut(T& top, VerilatedContext& ctx) {
    top.reset = 1;
    tick(top, ctx);
    tick(top, ctx);
    top.reset = 0;
    tick(top, ctx);
}
