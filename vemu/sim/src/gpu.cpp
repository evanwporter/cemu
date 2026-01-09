#include "gpu.hpp"

#include "gbh.hpp"
#include "types.hpp"
#include <iostream>

void GPU::draw_scanline(const u8 LY) {
    if (LY >= GB_HEIGHT)
        return;

    const u8 LCDC = regs.__PVT__LCDC;
    const u8 SCX = regs.__PVT__SCX;
    const u8 SCY = regs.__PVT__SCY;

    // BG disabled?
    if (!(LCDC & 0x01))
        return;

    bool signed_index = !(LCDC & 0b00010000); // tile data at 0x8800 or 0x8000
    u16 tilemap_base = (LCDC & 0b00001000) ? 0x1C00 : 0x1800; // 9800 or 9C00

    u16 tile_data_base = (LCDC & 0x10) ? 0x0000 : 0x0800;

    int bg_y = (LY + SCY) % 256;
    int tile_y = bg_y % 8;
    int tile_row = (bg_y >> 3) * 32;

    for (int x = 0; x < GB_WIDTH; ++x) {
        int bg_x = (x + SCX) & 255;
        int tile_col = bg_x / 8;
        u8 tile_index = vram[tilemap_base + tile_row + tile_col];

        int tile = signed_index ? (int8_t)tile_index + 256 : tile_index;

        int tile_x = 7 - (bg_x % 8);

        const u8* td = &vram[tile * 16 + tile_y * 2];
        u8 lo = td[0];
        u8 hi = td[1];

        u8 color = ((hi >> tile_x) & 1) * 2 + ((lo >> tile_x) & 1);
        framebuffer[LY * GB_WIDTH + x] = gb_color(color);
    }

    // TODO: Window

    const u8 WX = regs.__PVT__WX;
    const u8 WY = regs.__PVT__WY;

    const bool window_enable = LCDC & 0b00100000;
    const bool window_visible = window_enable && (LY >= WY) && ((WX - 7) < GB_WIDTH);
    const u16 window_tilemap_base = (LCDC & 0b01000000) ? 0x1C00 : 0x1800;

    if (window_visible) {
        int window_y = LY - WY;
        int tile_y = window_y & 7;
        int tile_row = ((window_y >> 3) & 31) * 32;

        int win_x_start = WX - 7;
        int x_start = std::max(0, win_x_start);

        for (int x = x_start; x < GB_WIDTH; ++x) {
            int window_x = x - win_x_start;
            int tile_col = (window_x >> 3) & 31;

            u8 tile_index = vram[window_tilemap_base + tile_row + tile_col];

            int tile;
            if (signed_index)
                tile = (int8_t)tile_index + 128;
            else
                tile = tile_index;

            int tile_x = 7 - (window_x & 7);

            const u8* td = &vram[tile * 16 + tile_y * 2];
            u8 lo = td[0];
            u8 hi = td[1];

            u8 color = ((hi >> tile_x) & 1) << 1 | ((lo >> tile_x) & 1);

            framebuffer[LY * GB_WIDTH + x] = gb_color(color);
        }
    }
}

bool GPU::update() {
    if (!enabled)
        return true;

    static u8 LY_prev = LY();
    static SDL_Event e;

    while (SDL_PollEvent(&e)) {
        if (e.type == SDL_QUIT)
            return false;
    }

    if (LY_prev != LY()) {
        draw_scanline(LY_prev);
        LY_prev = LY();

        if (LY() == 144) {
            // The Gameboy has finished drawing the frame, so we update the screen
            SDL_UpdateTexture(
                texture,
                nullptr,
                framebuffer,
                GB_WIDTH * sizeof(u32));
            SDL_RenderCopy(renderer, texture, nullptr, nullptr);
            SDL_RenderPresent(renderer);
        }
    }

    return true;
}

bool GPU::setup() {
    if (!enabled)
        return true;

    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        std::cerr << "SDL init failed: " << SDL_GetError() << "\n";
        return false;
    }

    window = SDL_CreateWindow(
        "Verilog Game Boy",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        GB_WIDTH * SCALE,
        GB_HEIGHT * SCALE,
        0);

    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

    texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, GB_WIDTH, GB_HEIGHT);

    return true;
}

void GPU::exit() {
    if (!enabled)
        return;

    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
}