#include "gameboy.hpp"
#include <SDL3/SDL.h>

constexpr int SCALE = 4;

int main(int argc, char** argv) {
    if (argc < 2) {
        SDL_Log("Usage: %s <rom.gb>", argv[0]);
        return 1;
    }

    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_EVENTS) < 0) {
        SDL_Log("SDL_Init failed: %s", SDL_GetError());
        return 1;
    }

    SDL_Window* window = SDL_CreateWindow(
        "CEMU (Game Boy)",
        160 * SCALE,
        144 * SCALE,
        SDL_WINDOW_RESIZABLE);

    SDL_Renderer* renderer = SDL_CreateRenderer(window, nullptr);
    SDL_Texture* texture = SDL_CreateTexture(
        renderer,
        SDL_PIXELFORMAT_RGB24,
        SDL_TEXTUREACCESS_STREAMING,
        160,
        144);

    GameBoy gb;
    gb.load(argv[1]);
    gb.reset();

    bool running = true;
    auto frameStart = SDL_GetTicks();

    while (running) {
        SDL_Event e;
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_EVENT_QUIT)
                running = false;
        }

        // Step emulator
        for (int i = 0; i < 70224; ++i) { // ~1 frame (456*154 cycles)
            gb.step();
        }

        // Get framebuffer from PPU
        uint8_t* pixels;
        int pitch;
        SDL_LockTexture(texture, nullptr, (void**)&pixels, &pitch);

        // Convert Game Boy palette to RGB
        for (int y = 0; y < LCD_HEIGHT; ++y) {
            for (int x = 0; x < LCD_WIDTH; ++x) {
                GBColors color = gb.ppu->get_pixel(x, y);
                uint8_t r, g, b;
                switch (color) {
                case GBColors::Color1:
                    r = g = b = 0;
                    break;
                case GBColors::Color2:
                    r = g = b = 85;
                    break;
                case GBColors::Color3:
                    r = g = b = 170;
                    break;
                case GBColors::Color4:
                    r = g = b = 255;
                    break;
                }

                uint8_t* dst = &pixels[y * pitch + x * 3];
                dst[0] = r;
                dst[1] = g;
                dst[2] = b;
            }
        }

        SDL_UnlockTexture(texture);

        SDL_RenderClear(renderer);
        SDL_RenderTexture(renderer, texture, nullptr, nullptr);
        SDL_RenderPresent(renderer);

        // Cap to ~60 Hz
        auto frameTime = SDL_GetTicks() - frameStart;
        if (frameTime < 16)
            SDL_Delay(16 - frameTime);
        frameStart = SDL_GetTicks();
    }

    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
