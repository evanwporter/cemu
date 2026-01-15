#pragma once

#include "VGameboy.h"
#include "VGameboy___024root.h"
#include "types.hpp"
#include "verilated.h"

#include <SDL.h>

/// Graphics Processing Unit
class GPU {
private:
    bool enabled = true;

    static constexpr int GB_WIDTH = 160;
    static constexpr int GB_HEIGHT = 144;
    static constexpr int SCALE = 3;

    SDL_Window* dbg_window;
    SDL_Renderer* dbg_renderer;
    SDL_Texture* dbg_texture;

    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* texture;

    const VlUnpacked<CData, 8192>& vram;

    struct {
        const CData& LY;
        const CData& LYC;
        const CData& SCX;
        const CData& SCY;
        const CData& WX;
        const CData& WY;
        const CData& LCDC;
    } regs;

    const VlUnpacked<CData, 23040>& buffer;

    u32 framebuffer[GB_WIDTH * GB_HEIGHT];

    u32 dbg_framebuffer[GB_WIDTH * GB_HEIGHT];

    static inline u32 gb_color(u8 c) {
        switch (c & 0x3) {
        case 0:
            return 0xFFFFFFFF; // white
        case 1:
            return 0xFFAAAAAA; // light gray
        case 2:
            return 0xFF555555; // dark gray
        case 3:
            return 0xFF000000; // black
        default:
            return 0xFFFFFFFF;
        }
    }

    void draw_scanline(const u8 LY);

public:
    GPU(VGameboy& top, bool enabled = true) :
        vram(top.rootp->Gameboy__DOT__ppu_inst__DOT__VRAM),
        regs(top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LY, top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LYC, top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__SCX, top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__SCY, top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__WX, top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__WY, top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LCDC),
        buffer(top.rootp->Gameboy__DOT__ppu_inst__DOT__framebuffer_inst__DOT__buffer),
        enabled(enabled) { };

    GPU(const VlUnpacked<CData, 8192>& vram, const CData& LY, const CData& LYC, const CData& SCX, const CData& SCY, const CData& WX, const CData& WY, const CData& LCDC, const VlUnpacked<CData, 23040>& buffer, bool enabled = true) :
        vram(vram),
        regs(LY, LYC, SCX, SCY, WX, WY, LCDC),
        buffer(buffer),
        enabled(enabled) { };

    bool setup();

    bool update();

    bool render_snapshot();

    bool poll_events();

    void exit();
};