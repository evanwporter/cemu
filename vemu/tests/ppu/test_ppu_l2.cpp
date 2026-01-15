// Layer 2 of PPU tests (FIFO, Framebuffer, Fetcher)

#define SDL_MAIN_HANDLED

#include "VMockPPU.h"
#include "VMockPPU_MockPPU.h"
#include "VMockPPU___024root.h"

#include "util/util.hpp"

#include "gpu.hpp"

#include <SDL.h>

static constexpr int GB_WIDTH = 160;
static constexpr int GB_HEIGHT = 144;

static uint32_t framebuffer[GB_WIDTH * GB_HEIGHT];

static inline uint32_t gb_color(uint8_t c) {
    switch (c & 3) {
    case 0:
        return 0xFFFFFFFF; // white
    case 1:
        return 0xFFAAAAAA;
    case 2:
        return 0xFF555555;
    case 3:
        return 0xFF000000;
    }
    return 0xFFFFFFFF;
}

static void tick(VMockPPU& top, VerilatedContext& ctx) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(5);

    top.clk = 1;
    top.eval();
    ctx.timeInc(5);
}

int main() {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);

    VMockPPU top(&ctx);

    top.reset = 1;
    for (int i = 0; i < 4; ++i)
        tick(top, ctx);
    top.reset = 0;

    auto& vram = top.MockPPU->VRAM;

    constexpr int tile0 = 0x0000;
    for (int row = 0; row < 8; ++row) {
        vram[tile0 + row * 2 + 0] = (row & 1) ? 0x55 : 0xAA;
        vram[tile0 + row * 2 + 1] = 0x00;
    }

    constexpr int DOTS_PER_LINE = 456;
    constexpr int LINES_PER_FRAME = 154;

    constexpr int DOTS_PER_FRAME = DOTS_PER_LINE * LINES_PER_FRAME;

    for (int i = 0; i < DOTS_PER_FRAME; i++) {
        tick(top, ctx);
    }

    GPU gpu(
        vram,
        144,
        top.MockPPU->__PVT__regs.__PVT__LYC,
        top.MockPPU->__PVT__regs.__PVT__SCX,
        top.MockPPU->__PVT__regs.__PVT__SCY,
        top.MockPPU->__PVT__regs.__PVT__WX,
        top.MockPPU->__PVT__regs.__PVT__WY,
        top.MockPPU->__PVT__regs.__PVT__LCDC,
        top.MockPPU->__PVT__fb_inst__DOT__buffer,
        true);

    gpu.setup();

    bool quit = false;

    gpu.render_snapshot();

    while (gpu.poll_events()) {
        SDL_Delay(16); // ~60 Hz idle
    }

    gpu.exit();

    return 0;
};
