// test_ppu_background.cpp
#include <cstdint>
#include <filesystem>
#include <gtest/gtest.h>

#include "VMockPPU.h"
#include "VMockPPU_MockPPU.h"
#include "VMockPPU___024root.h"

#include <verilated.h>

#include "util/ppm.hpp"
#include "util/test_config.hpp" // --update flag
#include "util/util.hpp"

namespace fs = std::filesystem;

inline void tick(VMockPPU& top, VerilatedContext& ctx) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(5);

    top.clk = 1;
    top.eval();
    ctx.timeInc(5);
}

inline void run_ppu_frame(VMockPPU& top, VerilatedContext& ctx) {
    constexpr int DOTS_PER_LINE = 172;
    constexpr int LINES_PER_FRAME = 154;

    for (int line = 0; line < LINES_PER_FRAME; ++line) {
        top.MockPPU->__PVT__fetcher_inst__DOT__fetcher_x = 0;
        top.MockPPU->__PVT__dot_counter = 80;

        for (int dot = 0; dot < DOTS_PER_LINE; ++dot) {
            top.MockPPU->__PVT__dot_counter++;
            tick(top, ctx);

            if (top.MockPPU->__PVT__fb_inst__DOT__line_done)
                break;
        }
    }
}

TEST(PPU, BackgroundDisplay) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);

    VMockPPU top(&ctx);

    top.reset = 1;
    top.MockPPU->__PVT__fifo_reset = 1;
    for (int i = 0; i < 4; ++i)
        tick(top, ctx);

    top.reset = 0;
    top.MockPPU->__PVT__fifo_reset = 0;

    auto& vram = top.MockPPU->VRAM;

    // Checkered pattern
    constexpr int tile0 = 0x0000;
    for (int row = 0; row < 8; ++row) {
        vram[tile0 + row * 2 + 0] = (row & 1) ? 0b01010101 : 0b10101010;
        vram[tile0 + row * 2 + 1] = 0x00;
    }

    run_ppu_frame(top, ctx);

    uint32_t fb[FB_SIZE];

    for (int i = 0; i < FB_SIZE; ++i)
        fb[i] = gb_color(top.MockPPU->__PVT__fb_inst__DOT__buffer[i]);

    const fs::path golden = std::filesystem::path(__FILE__).parent_path() / "golden/bg_display.ppm";

    if (test_config().update) {
        fs::create_directories(golden.parent_path());
        write_ppm(fb, golden);
        GTEST_SKIP() << "Golden image updated: " << golden;
    }

    std::size_t w, h;
    auto golden_pixels = read_ppm(golden, w, h);

    ASSERT_EQ(w, GB_WIDTH);
    ASSERT_EQ(h, GB_HEIGHT);

    for (std::size_t i = 0; i < FB_SIZE; ++i) {
        ASSERT_EQ(fb[i], golden_pixels[i])
            << "Pixel mismatch at index " << i;
    }
}
