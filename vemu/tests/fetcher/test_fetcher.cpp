#include <gtest/gtest.h>
#include <verilated.h>

#include "Vfetcher_top_fetcher_top.h"
#include "util.hpp"
#include <Vfetcher_top.h>
#include <Vfetcher_top___024root.h>

#include <fstream>
#include <string>

vluint64_t global_timestamp = 0;

static u8 VRAM[0x2000] = { 0 };

static void init_fetcher(Vfetcher_top& top, VerilatedContext& ctx) {
    memset(VRAM, 0, sizeof(VRAM));

    reset_dut(top, ctx);

    top.dot_en = 0;
    top.bg_fifo_empty = 1;
    top.bg_fifo_full = 0;

    top.window_active = 0;
    top.x_clock = 0;
    top.y_screen = 0;

    top.regs.__PVT__LCDC = 0;
    top.regs.__PVT__SCX = 0;
    top.regs.__PVT__SCY = 0;
    top.regs.__PVT__WX = 0;
    top.regs.__PVT__WY = 0;
}

bool load_vram_dump(const std::string& filename) {
    std::ifstream f(filename, std::ios::binary);
    if (!f.is_open())
        return false;

    f.read(reinterpret_cast<char*>(VRAM), sizeof(VRAM));
    return true;
}

struct TilemapParam {
    bool window_active;
    u8 lcdc;
    uint16_t expected_addr;
    const char* name;
};

class FetcherTilemapTest : public ::testing::TestWithParam<TilemapParam> { };

TEST_P(FetcherTilemapTest, TilemapAddress) {
    auto p = GetParam();

    VerilatedContext ctx;
    ctx.time(0);
    Vfetcher_top top(&ctx);

    const auto& root = top.rootp;

    init_fetcher(top, ctx);

    top.window_active = p.window_active;
    top.regs.__PVT__LCDC = p.lcdc;

    top.x_clock = 0;
    top.y_screen = 0;
    top.regs.__PVT__SCX = 0;
    top.regs.__PVT__SCY = 0;

    top.eval();

    EXPECT_EQ(root->fetcher_top->__PVT__dut__DOT__tilemap_addr, p.expected_addr)
        << "Case: " << p.name;
}

INSTANTIATE_TEST_SUITE_P(
    TilemapTests,
    FetcherTilemapTest,
    ::testing::Values(
        TilemapParam { false, 0b00000000, 0x9800, "BG_9800" },
        TilemapParam { false, 0b00001000, 0x9C00, "BG_9C00" },
        TilemapParam { true, 0b00000000, 0x9800, "WIN_9800" },
        TilemapParam { true, 0b01000000, 0x9C00, "WIN_9C00" }),
    [](const testing::TestParamInfo<FetcherTilemapTest::ParamType>& info) {
        return info.param.name;
    });

struct FetcherPixelParam {
    u8 tile_index;
    u8 low_byte;
    u8 high_byte;
    u8 lcdc;
    const char* name;
};

static std::vector<u8> compute_expected(u8 low, u8 high) {
    std::vector<u8> out(8);

    for (int i = 0; i < 8; i++) {
        const int bit = 7 - i;

        const u8 lo = (low >> bit) & 1;
        const u8 hi = (high >> bit) & 1;

        out[i] = (hi << 1) | lo;
    }

    return out;
}

class FetcherPixelTest : public ::testing::TestWithParam<FetcherPixelParam> { };

TEST_P(FetcherPixelTest, PixelPatterns) {
    const auto& p = GetParam();

    VerilatedContext ctx;
    ctx.time(0);

    Vfetcher_top top(&ctx);
    auto* root = top.rootp;

    init_fetcher(top, ctx);

    top.dot_en = 1;

    top.regs.__PVT__LCDC = p.lcdc; // LCDC[4] = 1

    // VRAM contents:
    VRAM[0x1800] = p.tile_index; // tilemap[0]

    uint16_t base;
    if (p.lcdc & 0b00010000) {
        // unsigned mode (0x8000 tileset)
        base = p.tile_index * 16;
    } else {
        // signed mode (0x9000 tileset)
        // VRAM[] starts at 0x8000 +- 0x1000 offset
        s16 signed_tid = s8(p.tile_index);
        base = 0x1000 + (signed_tid * 16);
    }

    VRAM[base + 0x00] = p.low_byte;
    VRAM[base + 0x01] = p.high_byte;

    std::vector<u8> got_colors;

    bool first_valid = false;

    for (int i = 0; i < 200; i++) {

        if (top.vram_read_req) {
            uint16_t va = top.vram_addr - 0x8000;
            top.vram_rdata = VRAM[va];
        }

        tick(top, ctx);

        if (top.bg_push_en) {
            // we skip the first pixel since its zero for some reason
            if (!first_valid) {
                first_valid = true;
                continue;
            }
            const auto px = top.bg_push_px;
            got_colors.push_back(px.__PVT__color);
        }

        if (got_colors.size() == 8)
            break;
    }

    ASSERT_EQ(got_colors.size(), 8);

    const auto expected = compute_expected(p.low_byte, p.high_byte);

    EXPECT_EQ(got_colors, std::vector<u8>(expected.begin(), expected.end()));
}

INSTANTIATE_TEST_SUITE_P(
    PixelPatterns,
    FetcherPixelTest,
    ::testing::Values(
        FetcherPixelParam {
            0x05,
            0xAA, // low byte (10101010) // 2, 2, 2, 2
            0x55, // high byte (01010101)
            0b00010000,
            "AA55_unsigned" },

        FetcherPixelParam {
            0x05,
            0xAA,
            0x55,
            0b00000000, // signed indexing
            "AA55_signed" }),
    [](const testing::TestParamInfo<FetcherPixelTest::ParamType>& info) {
        return info.param.name;
    });
