#pragma once

#include "VGameboy.h"
#include "VGameboy___024root.h"
#include "types.hpp"

#include <SDL.h>

/// Graphics Processing Unit
class GPU {
private:
    bool enabled = true;

    static constexpr int GB_WIDTH = 160;
    static constexpr int GB_HEIGHT = 144;
    static constexpr int SCALE = 3;

    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* texture;

    const VlUnpacked<CData, 8192>& vram;
    const VGameboy_ppu_regs_t__struct__0& regs;

    u32 framebuffer[GB_WIDTH * GB_HEIGHT];

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

    inline u8 LY() const {
        return regs.__PVT__LY;
    }

public:
    GPU(VGameboy& top, bool enabled = true) :
        vram(top.rootp->Gameboy__DOT__ppu_inst__DOT__VRAM),
        regs(top.rootp->Gameboy__DOT__ppu_inst__DOT__regs),
        enabled(enabled) { };

    bool setup();

    bool update();

    void exit();
};