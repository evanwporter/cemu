#include "gpu.hpp"

#include <SDL.h>

#include "types.hpp"
#include <iostream>

void GPU::draw_scanline(const u8 LY) {
    if (LY >= GB_HEIGHT)
        return;

    const u8 LCDC = regs.LCDC;
    const u8 SCX = regs.SCX;
    const u8 SCY = regs.SCY;

    // BG disabled?
    if (!(LCDC & 0x01))
        return;

    bool signed_index = !(LCDC & 0b00010000); // tile data at 0x8800 or 0x8000
    u16 tilemap_base = (LCDC & 0b00001000) ? 0x1C00 : 0x1800; // 9800 or 9C00

    u16 tile_data_base = (LCDC & 0x10) ? 0x0000 : 0x0800;

    int bg_y = (LY + SCY) % 256;
    int tile_y = bg_y % 8;
    int tile_row = (bg_y / 8) * 32;

    for (int x = 0; x < GB_WIDTH; ++x) {
        int bg_x = (x + SCX) & 255;
        int tile_col = bg_x / 8;

        // tile index in tilemap
        u8 tile_index = vram[tilemap_base + tile_row + tile_col];

        int tile = signed_index ? (int8_t)tile_index + 256 : tile_index;

        int tile_x = 7 - (bg_x % 8);

        const u8* td = &vram[tile * 16 + tile_y * 2];
        u8 lo = td[0];
        u8 hi = td[1];

        u8 color = ((hi >> tile_x) & 1) * 2 + ((lo >> tile_x) & 1);
        dbg_framebuffer[LY * GB_WIDTH + x] = gb_color(color);
    }

    static constexpr u32 green[4] = {
        0xFF9BBC0F, // lightest
        0xFF8BAC0F, // light
        0xFF306230, // dark
        0xFF0F380F, // darkest
    };

    const u8 WX = regs.WX;
    const u8 WY = regs.WY;

    static u8 window_line = 0;

    if (LY == 0)
        window_line = 0;

    const bool window_enable = LCDC & 0b00100000;
    const bool window_visible = window_enable && (LY >= WY) && ((WX - 7) < GB_WIDTH);
    const u16 window_tilemap_base = (LCDC & 0b01000000) ? 0x1C00 : 0x1800;

    if (window_visible) {
        const int window_y = window_line; // LY - WY;
        const int tile_y = window_y & 7;
        const int tile_row = ((window_y >> 3) & 31) * 32;

        const int win_x_start = WX - 7;
        const int x_start = std::max(0, win_x_start);

        for (int x = x_start; x < GB_WIDTH; ++x) {
            const int window_x = x - win_x_start;
            const int tile_col = (window_x >> 3) & 31;

            const u8 tile_index = vram[window_tilemap_base + tile_row + tile_col];

            const int tile = signed_index ? (int8_t)tile_index + 256 : tile_index;

            const int tile_x = 7 - (window_x & 7);

            const u8* td = &vram[tile * 16 + tile_y * 2];
            const u8 lo = td[0];
            const u8 hi = td[1];

            const u8 color = ((hi >> tile_x) & 1) << 1 | ((lo >> tile_x) & 1);

            dbg_framebuffer[LY * GB_WIDTH + x] = green[color];
        }

        window_line++;
    }
}

bool GPU::update() {
    if (!enabled)
        return true;

    static u8 LY_prev = regs.LY;
    static SDL_Event e;

    while (SDL_PollEvent(&e)) {
        if (e.type == SDL_QUIT)
            return false;
    }

    if (LY_prev != regs.LY) {
        draw_scanline(LY_prev);

        const int offset = LY_prev * GB_WIDTH;
        for (int x = 0; x < GB_WIDTH; ++x) {
            if (LY_prev >= GB_HEIGHT)
                continue;

            u32 expected = gb_color(buffer[offset + x]);
            u32 actual = dbg_framebuffer[offset + x];

            if (expected != actual) {
                // Mark mismatch visually (magenta)
                dbg_framebuffer[offset + x] = 0xFFFF00FF;
            }
        }

        LY_prev = regs.LY;

        if (regs.LY == 144) {
            // The Gameboy has finished drawing the frame, so we update the screen
            for (int i = 0; i < GB_WIDTH * GB_HEIGHT; ++i) {
                framebuffer[i] = gb_color(buffer[i]);
            }

            SDL_UpdateTexture(
                texture,
                nullptr,
                framebuffer,
                GB_WIDTH * sizeof(u32));
            SDL_RenderCopy(renderer, texture, nullptr, nullptr);
            SDL_RenderPresent(renderer);

            SDL_UpdateTexture(
                dbg_texture,
                nullptr,
                dbg_framebuffer,
                GB_WIDTH * sizeof(u32));
            SDL_RenderCopy(dbg_renderer, dbg_texture, nullptr, nullptr);
            SDL_RenderPresent(dbg_renderer);
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

    dbg_window = SDL_CreateWindow(
        "Verilog Game Boy (Debug)",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        GB_WIDTH * SCALE,
        GB_HEIGHT * SCALE,
        0);
    dbg_renderer = SDL_CreateRenderer(dbg_window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    dbg_texture = SDL_CreateTexture(dbg_renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, GB_WIDTH, GB_HEIGHT);

    return true;
}

void GPU::exit() {
    if (!enabled)
        return;

    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);

    SDL_DestroyTexture(dbg_texture);
    SDL_DestroyRenderer(dbg_renderer);
    SDL_DestroyWindow(dbg_window);
    SDL_Quit();
}

bool GPU::render_snapshot() {
    if (!enabled)
        return true;

    for (int i = 0; i < GB_WIDTH * GB_HEIGHT; ++i)
        framebuffer[i] = gb_color(buffer[i]);

    for (int ly = 0; ly < GB_HEIGHT; ++ly)
        draw_scanline((u8)ly);

    // for (int i = 0; i < 23040; ++i) {
    //     if (framebuffer[i] != dbg_framebuffer[i]) {
    //         framebuffer[i] = 0xFFFF00FF;
    //     }
    // }

    SDL_UpdateTexture(texture, nullptr, framebuffer, GB_WIDTH * sizeof(u32));
    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, texture, nullptr, nullptr);
    SDL_RenderPresent(renderer);

    SDL_UpdateTexture(dbg_texture, nullptr, dbg_framebuffer, GB_WIDTH * sizeof(u32));
    SDL_RenderClear(dbg_renderer);
    SDL_RenderCopy(dbg_renderer, dbg_texture, nullptr, nullptr);
    SDL_RenderPresent(dbg_renderer);

    return true;
}

bool GPU::poll_events() {
    SDL_Event e;
    while (SDL_PollEvent(&e)) {
        switch (e.type) {
        case SDL_QUIT:
            return false;

        case SDL_WINDOWEVENT:
            if (e.window.event == SDL_WINDOWEVENT_CLOSE)
                return false;
            break;
        }
    }
    return true;
}