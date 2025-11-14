#include <VFIFO.h>
#include <verilated.h>

#include <gtest/gtest.h>

static vluint64_t timestamp = 0;
double sc_time_stamp() { return timestamp; }

using u8 = uint8_t;
using u16 = uint16_t;

void tick(VFIFO& top, VerilatedContext& ctx) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(1);

    top.clk = 1;
    top.eval();
    ctx.timeInc(1);
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

TEST(FIFOTest, IsEmpty) {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);

    VFIFO top(&ctx);

    top.reset = 1;
    tick(top, ctx);
    tick(top, ctx);
    top.reset = 0;

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

    top.reset = 1;
    tick(top, ctx);
    tick(top, ctx);
    top.reset = 0;

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

    // Reset FIFO
    top.reset = 1;
    tick(top, ctx);
    tick(top, ctx);
    top.reset = 0;

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

    // Reset FIFO
    top.reset = 1;
    tick(top, ctx);
    tick(top, ctx);
    top.reset = 0;

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