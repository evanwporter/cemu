#pragma once
#include <cstdint>
#include <verilated.h>

using u8 = uint8_t;
using u16 = uint16_t;

using s8 = int8_t;
using s16 = int16_t;

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

u16 pack_px(u8 color, u8 palette, u8 spr_idx, bool bg_prio, bool valid) {
    u16 v = 0;
    v |= (color & 0x3) << 11; // 2 bits
    v |= (palette & 0x7) << 8; // 3 bits
    v |= (spr_idx & 0x3F) << 2; // 6 bits
    v |= (bg_prio & 0x1) << 1; // 1 bit
    v |= (valid & 0x1); // 1 bit
    return v;
}

void unpack_px(u16 v, u8& color, u8& palette, u8& spr_idx, bool& bg_prio, bool& valid) {
    color = (v >> 11) & 0x3;
    palette = (v >> 8) & 0x7;
    spr_idx = (v >> 2) & 0x3F;
    bg_prio = (v >> 1) & 0x1;
    valid = (v >> 0) & 0x1;
}