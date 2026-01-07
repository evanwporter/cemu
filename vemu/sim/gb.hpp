#pragma once

#ifndef SDL_MAIN_HANDLED
#define SDL_MAIN_HANDLED
#endif

#include <SDL.h>

#include <VGameboy.h>
#include <VGameboy___024root.h>
#include <verilated.h>

#include <cstdint>
#include <filesystem>
#include <functional>
#include <iostream>

using u8 = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;
using u64 = uint64_t;

struct Delta {
    u16 addr;
    u8 old_value;
    u8 new_value;
};

struct Operation {
    u8 opcode;
    std::vector<Delta> history;
};

class GameboyHarness {
public:
    GameboyHarness(bool gui_enabled = true, bool dump_trace_enabled = false, bool skip_boot_rom = false) :
        gui_enabled(gui_enabled), dump_trace_enabled(dump_trace_enabled), skip_boot_rom(skip_boot_rom) { }

    bool setup(const std::filesystem::path& rom_path);

    using InstructionCallback = std::function<bool(GameboyHarness&, VGameboy&)>;
    using TickCallback = std::function<void(GameboyHarness&, VGameboy&, uint8_t, bool)>;

    void run();
    bool run(const std::filesystem::path& rom_path, InstructionCallback on_instruction = nullptr);

    void step(TickCallback on_tick = nullptr);

    std::string get_serial_buffer() const {
        return serial_buffer;
    }

    u8 read_mem(u16 addr) {
        return read_mem(*top, addr);
    }
    u8 read_mem(VGameboy& top, u16 PC);

    bool running = false;

    std::unique_ptr<VGameboy> top;

private:
    bool gui_enabled;
    bool dump_trace_enabled;
    bool skip_boot_rom;

    static constexpr int GB_WIDTH = 160;
    static constexpr int GB_HEIGHT = 144;
    static constexpr int SCALE = 3;

    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* texture;

    VerilatedContext ctx;

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

    int opcodes_executed = 0;

    u64 cycles = 0;

    u64 ticks_executed = 0;

    u8 last_SC = 0;
    std::string serial_buffer;

    void dump_gd_trace(VGameboy& top, std::ostream& os);

    bool load_rom(VGameboy& top, const std::filesystem::path& filename);
    bool load_rom(const std::filesystem::path& filename);

    bool handle_serial_output(VGameboy& top);

    void tick(VGameboy& top, VerilatedContext& ctx, u64& cycles);

    void set_initial_state(VGameboy& top);

    void draw_from_vram(VGameboy& top);

    void draw_sprites(VGameboy& top);

    void present_frame();
};