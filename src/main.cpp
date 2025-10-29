#pragma once

#include "definitions.hpp"
#include "gameboy.hpp"
#include "io/io.hpp"
#include "options.hpp"
#include "util/log.hpp"

#include <SDL.h>
#include <argparse/argparse.hpp>

#include <fstream>
#include <optional>
#include <string>

static uint pixel_size = 2;

static uint width = GAMEBOY_WIDTH * pixel_size;
static uint height = GAMEBOY_HEIGHT * pixel_size;

static SDL_Window* window;
static SDL_Renderer* renderer;
static SDL_Texture* gb_screen_texture;

static std::unique_ptr<Gameboy> gameboy;

struct {
    Options options;
    std::string filename;
} cli_options;

static bool should_exit = false;

static std::optional<GbButton> get_gb_button(int keyCode) {
    switch (keyCode) {
    case SDLK_UP:
        return GbButton::Up;
    case SDLK_DOWN:
        return GbButton::Down;
    case SDLK_LEFT:
        return GbButton::Left;
    case SDLK_RIGHT:
        return GbButton::Right;
    case SDLK_x:
        return GbButton::A;
    case SDLK_z:
        return GbButton::B;
    case SDLK_BACKSPACE:
        return GbButton::Select;
    case SDLK_RETURN:
        return GbButton::Start;
    case SDLK_b:
        gameboy->debug_toggle_background();
        return {};
    case SDLK_s:
        gameboy->debug_toggle_sprites();
        return {};
    case SDLK_w:
        gameboy->debug_toggle_window();
        return {};
    default:
        return {};
    }
}

static uint32_t get_real_color(Color color) {
    uint8_t r;
    uint8_t g;
    uint8_t b;

    switch (color) {
    case Color::White:
        r = g = b = 255;
        break;
    case Color::LightGray:
        r = g = b = 170;
        break;
    case Color::DarkGray:
        r = g = b = 85;
        break;
    case Color::Black:
        r = g = b = 0;
        break;
    }

    return (r << 16) | (g << 8) | (b << 0);
}

static void set_pixel(uint32_t* pixels, uint x, uint y, uint32_t pixel_argb) {
    pixels[width * y + x] = pixel_argb;
}

static void set_large_pixel(uint32_t* pixels, uint x, uint y, uint32_t pixel_argb) {
    for (uint w = 0; w < pixel_size; w++) {
        for (uint h = 0; h < pixel_size; h++) {
            set_pixel(pixels, x * pixel_size + w, y * pixel_size + h, pixel_argb);
        }
    }
}

static void set_pixels(uint32_t* pixels, const FrameBuffer& buffer) {
    for (uint y = 0; y < GAMEBOY_HEIGHT; y++) {
        for (uint x = 0; x < GAMEBOY_WIDTH; x++) {
            Color color = buffer.get_pixel(x, y);
            uint32_t pixel_argb = get_real_color(color);
            set_large_pixel(pixels, x, y, pixel_argb);
        }
    }
}

static std::string get_save_filename() {
    return cli_options.filename + ".sav";
}

static void save_state() {
    const u8* ram_data = gameboy->cartridge->get_ram_data();
    size_t ram_size = gameboy->cartridge->get_ram_size();

    if (ram_data == nullptr || ram_size == 0) {
        log_info("No cartridge RAM to save");
        return;
    }

    auto filename = get_save_filename();
    std::ofstream output_file(filename, std::ios::binary);
    if (!output_file) {
        log_error("Failed to open save file: %s", filename.c_str());
        return;
    }

    output_file.write(reinterpret_cast<const char*>(ram_data), static_cast<std::streamsize>(ram_size));
    log_info("Wrote %zu KB to %s", ram_size / 1024, filename.c_str());
}

static void process_events() {
    SDL_Event event;

    while (SDL_PollEvent(&event)) {
        switch (event.type) {
        case SDL_KEYDOWN:
            if (static_cast<bool>(event.key.repeat)) {
                break;
            }
            if (auto button_pressed = get_gb_button(event.key.keysym.sym); button_pressed) {
                gameboy->button_pressed(*button_pressed);
            }
            break;
        case SDL_KEYUP:
            if (static_cast<bool>(event.key.repeat)) {
                break;
            }
            if (auto button_released = get_gb_button(event.key.keysym.sym); button_released) {
                gameboy->button_released(*button_released);
            }
            break;
        case SDL_WINDOWEVENT:
            if (event.window.event == SDL_WINDOWEVENT_CLOSE) {
                should_exit = true;
            }
            break;
        case SDL_QUIT:
            should_exit = true;
            break;
        }
    }
}

static void draw(const FrameBuffer& buffer) {
    process_events();

    SDL_RenderClear(renderer);

    void* pixels_ptr;
    int pitch;
    SDL_LockTexture(gb_screen_texture, nullptr, &pixels_ptr, &pitch);

    uint32_t* pixels = static_cast<uint32_t*>(pixels_ptr);
    set_pixels(pixels, buffer);
    SDL_UnlockTexture(gb_screen_texture);

    SDL_RenderCopy(renderer, gb_screen_texture, nullptr, nullptr);
    SDL_RenderPresent(renderer);
}

static bool is_closed() {
    return should_exit;
}

int main(int argc, char* argv[]) {
    argparse::ArgumentParser program("cemu");

    program.add_description("A Game Boy emulator");

    // ROM file
    program.add_argument("rom")
        .help("Path to the ROM file to run");

    // Optional flags
    program.add_argument("--trace")
        .help("Enable instruction trace")
        .default_value(false)
        .implicit_value(true);

    program.add_argument("--silent")
        .help("Disable all logs")
        .default_value(false)
        .implicit_value(true);

    program.add_argument("--headless")
        .help("Run without a display window")
        .default_value(false)
        .implicit_value(true);

    program.add_argument("--full-framebuffer")
        .help("Show the full framebuffer instead of the visible window")
        .default_value(false)
        .implicit_value(true);

    program.add_argument("--exit-on-infinite-jr")
        .help("Exit on infinite JR loops")
        .default_value(false)
        .implicit_value(true);

    program.add_argument("--print-serial-output")
        .help("Print serial port output")
        .default_value(false)
        .implicit_value(true);

    try {
        program.parse_args(argc, argv);
    } catch (const std::exception& err) {
        fatal_error(err.what());
        std::exit(EXIT_FAILURE);
    }

    cli_options.filename = program.get<std::string>("rom");

    cli_options.options.trace = program.get<bool>("--trace");
    cli_options.options.disable_logs = program.get<bool>("--silent");
    cli_options.options.headless = program.get<bool>("--headless");
    cli_options.options.show_full_framebuffer = program.get<bool>("--full-framebuffer");
    cli_options.options.exit_on_infinite_jr = program.get<bool>("--exit-on-infinite-jr");
    cli_options.options.print_serial = program.get<bool>("--print-serial-output");

    SDL_Init(SDL_INIT_VIDEO);

    window = SDL_CreateWindow(
        "cemu",
        SDL_WINDOWPOS_UNDEFINED,
        SDL_WINDOWPOS_UNDEFINED,
        width,
        height,
        SDL_WINDOW_OPENGL);

    if (window == nullptr) {
        fatal_error("Failed to initialise SDL");
    }

    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

    gb_screen_texture = SDL_CreateTexture(
        renderer,
        SDL_PIXELFORMAT_ARGB8888,
        SDL_TEXTUREACCESS_STREAMING,
        width,
        height);

    gameboy = std::make_unique<Gameboy>(cli_options.filename, cli_options.options);
    gameboy->run(&is_closed, &draw);

    save_state();
    SDL_DestroyTexture(gb_screen_texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
