#include <VFIFO.h>
#include <verilated.h>

#include <gtest/gtest.h>

#include "util.hpp"

vluint64_t global_timestamp = 0;

TEST(FIFOTest, IsEmpty) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);
    VFIFO top(&ctx);

    reset_dut(top, ctx);

    EXPECT_TRUE(top.empty);
    EXPECT_EQ(top.count, 0);

    u16 px = top.top_px;

    u8 color, palette, spr_idx;
    bool bg_prio, valid;

    unpack_px(px, color, palette, spr_idx, bg_prio, valid);

    EXPECT_EQ(color, 0);
    EXPECT_EQ(palette, 0);
    EXPECT_EQ(spr_idx, 0);
    EXPECT_EQ(bg_prio, 0);
    EXPECT_EQ(valid, 0);
}

TEST(FIFOTest, IsEmptyOnReset) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);
    VFIFO top(&ctx);

    reset_dut(top, ctx);

    ASSERT_TRUE(top.empty);
    ASSERT_EQ(top.count, 0);

    // Push a pixel
    u16 px = pack_px(2, 3, 17, 1, 1);

    top.push_px = px;
    top.push_en = 1;
    tick(top, ctx);
    top.push_en = 0;

    ASSERT_FALSE(top.empty);
    ASSERT_EQ(top.count, 1);

    reset_dut(top, ctx);

    EXPECT_TRUE(top.empty);
    EXPECT_EQ(top.count, 0);

    px = top.top_px;

    u8 color, palette, spr_idx;
    bool bg_prio, valid;

    unpack_px(px, color, palette, spr_idx, bg_prio, valid);

    EXPECT_EQ(color, 0);
    EXPECT_EQ(palette, 0);
    EXPECT_EQ(spr_idx, 0);
    EXPECT_EQ(bg_prio, 0);
    EXPECT_EQ(valid, 0);
}

TEST(FIFOTest, PushAndPop) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);
    VFIFO top(&ctx);

    reset_dut(top, ctx);

    ASSERT_TRUE(top.empty);
    ASSERT_EQ(top.count, 0);

    // Push a pixel
    u16 px = pack_px(2, 3, 17, 1, 1);

    top.push_px = px;
    top.push_en = 1;
    tick(top, ctx);
    top.push_en = 0;

    ASSERT_FALSE(top.empty);
    ASSERT_EQ(top.count, 1);

    // Verify pixel data
    u8 c, p, s;
    bool bp, v;
    unpack_px(top.top_px, c, p, s, bp, v);

    EXPECT_EQ(c, 2);
    EXPECT_EQ(p, 3);
    EXPECT_EQ(s, 17);
    EXPECT_EQ(bp, 1);
    EXPECT_EQ(v, 1);

    // Pop the pixel
    top.pop_en = 1;
    tick(top, ctx);
    top.pop_en = 0;

    // Verify that the top pixel is empty again
    unpack_px(top.top_px, c, p, s, bp, v);

    EXPECT_EQ(c, 0);
    EXPECT_EQ(p, 0);
    EXPECT_EQ(s, 0);
    EXPECT_EQ(bp, 0);
    EXPECT_EQ(v, 0);

    ASSERT_TRUE(top.empty);
    ASSERT_EQ(top.count, 0);
}