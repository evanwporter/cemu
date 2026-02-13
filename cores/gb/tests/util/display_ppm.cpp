#define SDL_MAIN_HANDLED

#include <cstdint>
#include <filesystem>
#include <iostream>

#include "ppm.hpp"

#include <SDL.h>

namespace fs = std::filesystem;

bool poll_events() {
    SDL_Event e;
    while (SDL_PollEvent(&e)) {
        if (e.type == SDL_QUIT)
            return false;
    }
    return true;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "No PPM file argument provided\n";
        return 1;
    }

    const auto ppm = fs::path(argv[1]);

    if (!fs::exists(ppm)) {
        std::cerr << "PPM file does not exist: " << ppm << "\n";
        return 1;
    }

    std::size_t w, h;
    auto pixels = read_ppm(ppm, w, h);

    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* texture;

    constexpr int SCALE = 3;

    window = SDL_CreateWindow(
        "Verilog Game Boy",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        w * SCALE,
        h * SCALE,
        0);
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, w, h);

    SDL_UpdateTexture(texture, nullptr, pixels.data(), w * sizeof(uint32_t));
    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, texture, nullptr, nullptr);
    SDL_RenderPresent(renderer);

    while (poll_events()) {
        SDL_Delay(16);
    }

    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
}