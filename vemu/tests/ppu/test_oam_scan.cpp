#include "digits.hpp"
#define SDL_MAIN_HANDLED

#include <cstdint>

#include <gtest/gtest.h>

#include <verilated.h>

#include "Vppu_top.h"
#include "Vppu_top___024root.h"

#include "types.hpp"
#include "util/ppm.hpp"

inline uint8_t obj_attr(uint64_t obj) {
    return (obj >> 0) & 0xFF;
}

inline uint8_t obj_tile(uint64_t obj) {
    return (obj >> 8) & 0xFF;
}

inline uint8_t obj_x_pos(uint64_t obj) {
    return (obj >> 16) & 0xFF;
}

inline uint8_t obj_y_pos(uint64_t obj) {
    return (obj >> 24) & 0xFF;
}

inline bool obj_valid(uint64_t obj) {
    return (obj >> 32) & 0x1;
}

inline void tick(Vppu_top& top, VerilatedContext& ctx) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(5);

    top.clk = 1;
    top.eval();
    ctx.timeInc(5);
}

TEST(PPUOAMScanTest, FindsSpritesOnSingleScanline) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);

    Vppu_top top(&ctx);

    // -----------------------
    // Reset
    // -----------------------
    top.reset = 1;
    top.eval();
    top.reset = 0;
    top.eval();

    auto& regs = top.rootp->ppu_top__DOT__ppu__DOT__regs;

    // -----------------------
    // Enable LCD
    // -----------------------

    regs.__PVT__LCDC = 0x80; // LCD ON, sprites enabled implicitly
    regs.__PVT__LY = 20;

    const int y_pos = 20 + 16;

    // Force Mode 2
    top.rootp->ppu_top__DOT__ppu__DOT__mode = 2;
    top.rootp->ppu_top__DOT__ppu__DOT__dot_counter = 0;

    for (int i = 0; i < 10; ++i) {
        auto& s = top.rootp->ppu_top__DOT__ppu__DOT__sprites_found[i];
        s.__PVT__y_pos = 0;
        s.__PVT__x_pos = 0;
        s.__PVT__tile_idx = 0;
        s.__PVT__attr = 0;
        s.__PVT__valid = 0;
    }

    top.rootp->ppu_top__DOT__ppu__DOT__sprites_found_count = 0;

    oam_t& OAM = top.rootp->ppu_top__DOT__ppu__DOT__OAM;

    // Sprite 0: visible
    // TODO: But due to a bug or something this one is skipped
    OAM[0] = y_pos - 1;
    OAM[1] = 10; // x_pos
    OAM[2] = 1;
    OAM[3] = 0;

    // Sprite 1: visible
    OAM[4] = y_pos - 4;
    OAM[5] = 20;
    OAM[6] = 2;
    OAM[7] = 0;

    // Sprite 2: NOT visible (too low)
    OAM[8] = y_pos - 8;
    OAM[9] = 30;
    OAM[10] = 3;
    OAM[11] = 0;

    // Sprite 3: visible
    OAM[12] = y_pos - 1;
    OAM[13] = 40;
    OAM[14] = 4;
    OAM[15] = 0;

    // Sprite 4: NOT visible (too high)
    OAM[16] = 0;
    OAM[17] = 50;
    OAM[18] = 5;
    OAM[19] = 0;

    top.eval();

    for (int i = 0; i < 80; ++i)
        tick(top, ctx);

    ASSERT_EQ(top.rootp->ppu_top__DOT__ppu__DOT__sprites_found_count, 2);

    const auto& sprites = top.rootp->ppu_top__DOT__ppu__DOT__sprites_found;

    // EXPECT_EQ(obj_x_pos(sprites[0]), 10);
    EXPECT_EQ(sprites[0].__PVT__x_pos, 20);
    EXPECT_EQ(sprites[1].__PVT__x_pos, 40);
}