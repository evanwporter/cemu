// Layer 2 of PPU tests (FIFO, Framebuffer, Fetcher)

#define SDL_MAIN_HANDLED

#include "VMockPPU.h"
#include "VMockPPU_MockPPU.h"
#include "VMockPPU___024root.h"

#include "util/ppm.hpp"
#include "util/util.hpp"

#include "gpu.hpp"

#include <SDL.h>

static uint32_t framebuffer[FB_SIZE];

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
    top.MockPPU->__PVT__fifo_reset = 1;
    for (int i = 0; i < 4; ++i)
        tick(top, ctx);
    top.reset = 0;
    top.MockPPU->__PVT__fifo_reset = 0;
    auto& vram = top.MockPPU->VRAM;

    constexpr int tile0 = 0x0000;
    for (int row = 0; row < 8; ++row) {
        vram[tile0 + row * 2 + 0] = (row & 1) ? 0x55 : 0xAA;
        vram[tile0 + row * 2 + 1] = 0x00;

        // vram[tile0 + row * 2 + 0] = 0x55;
        // vram[tile0 + row * 2 + 1] = 0x33;
    }

    top.MockPPU->__PVT__fetcher_inst__DOT__fetcher_x = 0;

    constexpr int DOTS_PER_LINE = 172;
    constexpr int LINES_PER_FRAME = 154;

    const int LY = 0;

    for (int i = 0; i < LINES_PER_FRAME; i++) {
        top.MockPPU->__PVT__fetcher_inst__DOT__fetcher_x = 0;
        top.MockPPU->__PVT__dot_counter = 80;

        for (int j = 0; j < DOTS_PER_LINE; j++) {
            top.MockPPU->__PVT__dot_counter = top.MockPPU->__PVT__dot_counter + 1;
            tick(top, ctx);

            if (top.MockPPU->__PVT__fb_inst__DOT__line_done) {
                // End of line
                break;
            }
        }

        top.MockPPU->__PVT__fetcher_inst__DOT__fetcher_x = 0;
        top.MockPPU->__PVT__regs.__PVT__LY = top.MockPPU->__PVT__regs.__PVT__LY;
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
