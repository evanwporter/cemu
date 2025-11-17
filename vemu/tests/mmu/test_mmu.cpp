#include <gtest/gtest.h>
#include <verilated.h>

#include "util.hpp"
#include <Vtop.h>
#include <Vtop___024root.h>

vluint64_t global_timestamp = 0;

constexpr u16 VRAM_ADDR = 0x8000; // PPU VRAM
constexpr u16 OAM_ADDR = 0xFE00; // PPU OAM

static void cpu_idle(Vtop& top) {
    top.cpu_addr = 0;
    top.cpu_wdata = 0;
    top.cpu_read_en = 0;
    top.cpu_write_en = 0;
}

TEST(MMUTest, Reset) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);
    Vtop top(&ctx);

    reset_dut(top, ctx);

    cpu_idle(top);
    tick(top, ctx);

    EXPECT_EQ(top.cpu_rdata, 0x00);
}

TEST(MMUTest, VRAMReadWrite) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);
    Vtop top(&ctx);

    reset_dut(top, ctx);
    cpu_idle(top);

    top.cpu_addr = VRAM_ADDR;
    top.cpu_wdata = 0x3C;
    top.cpu_read_en = 0;
    top.cpu_write_en = 1;

    tick(top, ctx);

    EXPECT_EQ(top.rootp->top__DOT__ppu__DOT__VRAM[0x0000], 0x3C);

    top.cpu_write_en = 0;
    tick(top, ctx); // settle

    top.cpu_addr = VRAM_ADDR;
    top.cpu_wdata = 0;
    top.cpu_read_en = 1;
    top.cpu_write_en = 0;

    tick(top, ctx);

    u8 read_back = top.cpu_rdata;
    EXPECT_EQ(read_back, 0x3C); // PPU VRAM should now contain our value

    top.cpu_read_en = 0;
    tick(top, ctx); // settle
}

TEST(MMUTest, OAMReadWrite) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);
    Vtop top(&ctx);

    reset_dut(top, ctx);
    cpu_idle(top);

    // we need to wait for it to reach a mode where OAM is writable
    u8& mode = top.rootp->top__DOT__ppu__DOT__mode;
    while (mode == 2 || mode == 3) {
        cpu_idle(top);
        tick(top, ctx);
    }

    top.cpu_addr = OAM_ADDR;
    top.cpu_wdata = 0x3C;
    top.cpu_read_en = 0;
    top.cpu_write_en = 1;

    tick(top, ctx);

    EXPECT_EQ(top.rootp->top__DOT__ppu__DOT__OAM[0x0000], 0x3C);

    top.cpu_write_en = 0;
    tick(top, ctx); // settle

    top.cpu_addr = OAM_ADDR;
    top.cpu_wdata = 0;
    top.cpu_read_en = 1;
    top.cpu_write_en = 0;

    tick(top, ctx);

    u8 read_back = top.cpu_rdata;
    EXPECT_EQ(read_back, 0x3C);

    top.cpu_read_en = 0;
    tick(top, ctx);
}

TEST(MMUTest, PPURegistersReadWrite) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);
    Vtop top(&ctx);

    reset_dut(top, ctx);
    cpu_idle(top);

    auto check_reg = [&](u16 addr, u8 value, u8* field) {
        // write
        top.cpu_addr = addr;
        top.cpu_wdata = value;
        top.cpu_read_en = 0;
        top.cpu_write_en = 1;
        tick(top, ctx);
        EXPECT_EQ(*field, value);

        top.cpu_write_en = 0;
        tick(top, ctx);

        // read
        top.cpu_addr = addr;
        top.cpu_wdata = 0;
        top.cpu_read_en = 1;
        top.cpu_write_en = 0;
        tick(top, ctx);
        EXPECT_EQ(top.cpu_rdata, value);

        top.cpu_read_en = 0;
        tick(top, ctx);
    };

    auto& regs = top.rootp->top__DOT__ppu__DOT__regs;

    check_reg(0xFF42, 0x12, &regs.__PVT__SCY);
    check_reg(0xFF43, 0x34, &regs.__PVT__SCX);
    check_reg(0xFF45, 0x56, &regs.__PVT__LYC);
    check_reg(0xFF47, 0x78, &regs.__PVT__BGP);
}

TEST(MMUTest, OAMWriteBlockedInModes2and3) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);
    Vtop top(&ctx);

    reset_dut(top, ctx);
    cpu_idle(top);

    ASSERT_EQ(top.rootp->top__DOT__ppu__DOT__mode, 2);

    top.cpu_addr = OAM_ADDR;
    top.cpu_wdata = 0xAA;
    top.cpu_read_en = 0;
    top.cpu_write_en = 1;

    tick(top, ctx);

    // OAM must not change
    EXPECT_NE(top.rootp->top__DOT__ppu__DOT__OAM[0], 0xAA);

    top.cpu_write_en = 0;
    tick(top, ctx);

    u8& mode = top.rootp->top__DOT__ppu__DOT__mode;
    while (mode != 3) {
        cpu_idle(top);
        tick(top, ctx);
    }

    ASSERT_EQ(top.rootp->top__DOT__ppu__DOT__mode, 3);

    top.cpu_addr = OAM_ADDR;
    top.cpu_wdata = 0xBB;
    top.cpu_read_en = 0;
    top.cpu_write_en = 1;

    tick(top, ctx);

    EXPECT_NE(top.rootp->top__DOT__ppu__DOT__OAM[0], 0xBB);

    top.cpu_write_en = 0;
    tick(top, ctx);
}
