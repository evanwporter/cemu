#include "Vppu_top_RenderingControl_if.h"
#define SDL_MAIN_HANDLED

#include <cstdint>
#include <filesystem>

#include <gtest/gtest.h>

#include <verilated.h>

#include "Vppu_top.h"
#include "Vppu_top___024root.h"

#include "digits.hpp"
#include "types.hpp"
#include "util/ppm.hpp"
#include "util/test_config.hpp"
#include "util/util.hpp"

#include "gpu.hpp"

namespace fs = std::filesystem;

inline static void tick(Vppu_top& top, VerilatedContext& ctx) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(5);

    top.clk = 1;
    top.eval();
    ctx.timeInc(5);
}

static void write_checker_tile(vram_t& vram, int tile_idx, bool invert) {
    const int base = tile_idx * 16;

    for (int row = 0; row < 8; row++) {
        uint8_t lo = 0;
        uint8_t hi = 0;

        for (int col = 0; col < 8; col++) {
            bool bit = ((row ^ col) & 1);
            if (invert)
                bit = !bit;

            // color 3 (11) vs color 0 (00)
            if (bit) {
                lo |= (1 << (7 - col));
                hi |= (1 << (7 - col));
            }
        }

        vram[base + row * 2 + 0] = lo;
        vram[base + row * 2 + 1] = hi;
    }
}

inline static void run_ppu_frame(
    Vppu_top& top,
    VerilatedContext& ctx,
    const std::function<void(ppu_regs_t&, uint8_t)>& on_scanline,
    GPU& gpu) {
    uint8_t last_ly = 0xFF;

    while (!top.rootp->ppu_top__DOT__ppu__DOT__frame_done) {
        tick(top, ctx);

        auto& regs = top.rootp->ppu_top__DOT__ppu__DOT__regs;
        uint8_t ly = regs.__PVT__LY;

        auto& dot_counter = top.rootp->ppu_top__DOT__ppu__DOT__dot_counter;
        auto& sprite_hit = top.rootp->ppu_top__DOT__ppu__DOT__obj_fetcher_inst__DOT__sprite_hit;
        auto& sprite_valid = top.rootp->ppu_top__DOT__ppu__DOT__obj_fetcher_inst__DOT__sprite_valid;
        auto& sprites_found_count = top.rootp->ppu_top__DOT__ppu__DOT__sprites_found_count;
        auto& sprites_found = top.rootp->ppu_top__DOT__ppu__DOT__sprites_found;
        auto& mode = top.rootp->ppu_top__DOT__ppu__DOT__mode;
        auto& control = top.__PVT__ppu_top__DOT__ppu__DOT__rendering_control_bus;
        auto& x_pos = top.rootp->ppu_top__DOT__ppu__DOT__framebuffer_inst__DOT__x_screen;
        auto& y_pos = top.rootp->ppu_top__DOT__ppu__DOT__framebuffer_inst__DOT__y_screen;

        auto& fifo_bus = top.__PVT__ppu_top__DOT__ppu__DOT__fifo_bus;
        auto& obj_bus = top.__PVT__ppu_top__DOT__ppu__DOT__obj_fifo_bus;

        // auto& pixel_consume = top.rootp->;

        if (dot_counter == 90) {
            dot_counter = dot_counter;
        }

        if (ly != last_ly) {
            on_scanline(regs, ly);

            gpu.draw_scanline(ly);
            last_ly = ly;
        }
    }
}

struct PPUSpriteFrameTestCase {
    std::string name;
    std::function<void(vram_t& vram)> init_vram;
    std::function<void(oam_t& oam)> init_oam;
    std::function<void(ppu_regs_t& regs)> init_regs =
        [](ppu_regs_t&) { };
};

class PPUSpriteFrameTest
    : public ::testing::TestWithParam<PPUSpriteFrameTestCase> { };

TEST_P(PPUSpriteFrameTest, RendersSpriteCorrectly) {
    const auto& param = GetParam();

    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);

    Vppu_top top(&ctx);

    // Reset
    top.reset = 1;
    for (int i = 0; i < 4; ++i)
        tick(top, ctx);
    top.reset = 0;

    // Clear VRAM
    vram_t& vram = top.rootp->ppu_top__DOT__ppu__DOT__VRAM;
    for (int i = 0; i < 8192; ++i)
        vram[i] = 0;

    // Clear OAM
    oam_t& oam = top.rootp->ppu_top__DOT__ppu__DOT__OAM;
    for (int i = 0; i < 160; ++i)
        oam[i] = 0;

    // Init memory
    param.init_vram(vram);
    param.init_oam(oam);

    // Init regs
    ppu_regs_t& regs = top.rootp->ppu_top__DOT__ppu__DOT__regs;
    param.init_regs(regs);

    GPU gpu(
        vram,
        regs.__PVT__LY,
        regs.__PVT__LYC,
        regs.__PVT__SCX,
        regs.__PVT__SCY,
        regs.__PVT__WX,
        regs.__PVT__WY,
        regs.__PVT__LCDC,
        top.rootp->ppu_top__DOT__ppu__DOT__framebuffer_inst__DOT__buffer,
        test_config().gui);

    gpu.setup();

    run_ppu_frame(
        top,
        ctx,
        [](ppu_regs_t&, uint8_t) { },
        gpu);

    uint32_t fb[FB_SIZE];
    for (int i = 0; i < FB_SIZE; ++i)
        fb[i] = gb_color(
            top.rootp->ppu_top__DOT__ppu__DOT__framebuffer_inst__DOT__buffer[i]);

    gpu.render_snapshot();

    while (gpu.poll_events())
        ;
    gpu.exit();

    const fs::path golden = fs::path(__FILE__).parent_path() / "golden" / (param.name + ".ppm");

    if (test_config().update) {
        fs::create_directories(golden.parent_path());
        write_ppm(fb, golden);
        GTEST_SKIP() << "Golden image updated: " << golden;
    }

    std::size_t w, h;
    const auto golden_pixels = read_ppm(golden, w, h);

    ASSERT_EQ(w, GB_WIDTH);
    ASSERT_EQ(h, GB_HEIGHT);

    for (std::size_t i = 0; i < FB_SIZE; ++i) {
        ASSERT_EQ(fb[i], golden_pixels[i])
            << "Pixel mismatch at index " << i;
    }
}

PPUSpriteFrameTestCase single_sprite_number_case {
    .name = "sprite_single_number",

    .init_vram = [](vram_t& vram) {
        write_checker_tile(vram, 0, false);

        write_checker_tile(vram, 1, true);

        constexpr int TILE = 2;
        constexpr int BASE = TILE * 16;

        for (int row = 0; row < 8; row++) {
            vram[BASE + row * 2 + 0] = 0b10101010; // low bits
            vram[BASE + row * 2 + 1] = 0b01010101; // high bits
        }

        const int bg_map = 0x1800; // 0x9800 - 0x8000

        for (int y = 0; y < 32; y++) {
            for (int x = 0; x < 32; x++) {
                vram[bg_map + y * 32 + x] = ((x ^ y) & 1) ? 1 : 0;
            }
        } },

    .init_oam = [](oam_t& oam) {
        // Sprite 0
        // OAM format:
        // [0] Y + 16
        // [1] X + 8
        // [2] tile index
        // [3] attributes

        oam[0 + 4] = 16; // Y
        oam[1 + 4] = 8; // X
        oam[2 + 4] = 2; // tile index
        oam[3 + 4] = 0x00; // no flags
    },

    .init_regs = [](ppu_regs_t& regs) {
        regs.__PVT__SCX = 0;
        regs.__PVT__SCY = 0;

        regs.__PVT__LCDC = 0x80 | // LCD ON
            0x01 | // BG ON
            0x02 | // OBJ ON
            0x00 | // OBJ 8x8
            0x10; // tile data @ 8000
    }
};

INSTANTIATE_TEST_SUITE_P(
    PPUSpriteTests,
    PPUSpriteFrameTest,
    ::testing::Values(
        single_sprite_number_case),
    [](const ::testing::TestParamInfo<PPUSpriteFrameTestCase>& info) {
        return info.param.name;
    });