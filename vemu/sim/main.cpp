#define SDL_MAIN_HANDLED
#include <SDL.h>

#include <VGameboy.h>
#include <VGameboy___024root.h>
#include <verilated.h>

#include "boot.hpp"

#include <cstdint>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <iostream>

static const int GB_WIDTH = 160;
static const int GB_HEIGHT = 144;
static const int SCALE = 3;

using u8 = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;

static SDL_Window* window;
static SDL_Renderer* renderer;
static SDL_Texture* texture;

static inline u32 gb_color(u8 c) {
    switch (c & 0x3) {
    case 0:
        return 0xFFFFFFFF; // white
    case 1:
        return 0xAAAAAAFF; // light gray
    case 2:
        return 0x555555FF; // dark gray
    case 3:
        return 0x000000FF; // black
    default:
        return 0xFFFFFFFF;
    }
}

static void draw_frame(VGameboy& top) {
    void* pixels;
    int pitch;
    SDL_LockTexture(texture, nullptr, &pixels, &pitch);
    u32* buf = static_cast<u32*>(pixels);

    for (int y = 0; y < GB_HEIGHT; ++y) {
        for (int x = 0; x < GB_WIDTH; ++x) {
            int idx = y * GB_WIDTH + x;
            u8 col = top.rootp->Gameboy__DOT__ppu_inst__DOT__framebuffer__DOT__buffer[idx];
            buf[y * GB_WIDTH + x] = gb_color(col);
        }
    }

    SDL_UnlockTexture(texture);
    SDL_RenderCopy(renderer, texture, nullptr, nullptr);
    SDL_RenderPresent(renderer);
}

namespace fs = std::filesystem;

static int opcodes_executed = 0;

vluint64_t main_time = 0;

double sc_time_stamp() {
    return main_time;
}

static u8 read_mem(VGameboy& top, u16 PC) {

    bool boot_rom_active = (top.rootp->Gameboy__DOT__cart_inst__DOT__boot_rom_switch != 1);

    if (PC <= 0x00FF && boot_rom_active) {
        return bootDMG[PC];
    }

    if (PC <= 0x7FFF) {
        u8 val = top.rootp->Gameboy__DOT__cart_inst__DOT__ROM[PC];
        return val;
    }

    // VRAM
    else if (PC <= 0x9FFF) {
        u16 addr = PC - 0x8000;
        u8 val = top.rootp->Gameboy__DOT__ppu_inst__DOT__VRAM[addr];
        return val;
    }

    else if (PC <= 0xBFFF) {
        u16 addr = PC - 0xA000;
        u8 val = top.rootp->Gameboy__DOT__ram_inst__DOT__WRAM[addr];
        return val;
    }

    else if (PC <= 0xDFFF) {
        u16 addr = PC - 0xC000;
        u8 val = top.rootp->Gameboy__DOT__ram_inst__DOT__WRAM[addr];
        return val;
    }

    else if (PC <= 0xFDFF) {
        u16 addr = PC - 0xC000 - 0x2000;
        u8 val = top.rootp->Gameboy__DOT__ram_inst__DOT__WRAM[addr];
        return val;
    }

    else if (PC <= 0xFE9F) {
        u16 addr = PC - 0xFE00;
        u8 val = top.rootp->Gameboy__DOT__ppu_inst__DOT__OAM[addr];
        return val;
    }

    else if (PC <= 0xFF7F) {
        std::cout << "Read from IO address 0x" << std::hex << PC << std::dec << "\n";
        return 0xFF;
    }

    else if (PC <= 0xFFFE) {
        u16 addr = PC - 0xFF80;
        u8 val = top.rootp->Gameboy__DOT__ram_inst__DOT__HRAM[addr];
        return val;
    }

    // Unusable memory
    else if (PC <= 0xFFFF) {
        std::cout << "Read from IE register 0x" << std::hex << PC << std::dec << "\n";
        return 0xFF;
    }

    else {
        std::cerr << "ERROR: Attempted to read from invalid memory address 0x" << std::hex << PC << std::dec << "\n";
        return 0xFF;
    }
}

static void dump_gd_trace(VGameboy& top, std::ostream& os) {
    static int line_count = 0;

    auto& regs = top.rootp->Gameboy__DOT__cpu_inst__DOT__regs;

    u8 A = regs.__PVT__a;
    u8 F = regs.__PVT__flags;
    u8 B = regs.__PVT__b;
    u8 C = regs.__PVT__c;
    u8 D = regs.__PVT__d;
    u8 E = regs.__PVT__e;
    u8 H = regs.__PVT__h;
    u8 L = regs.__PVT__l;

    u16 PC = (regs.__PVT__pch << 8) | regs.__PVT__pcl;
    u16 SP = (regs.__PVT__sph << 8) | regs.__PVT__spl;

    u8 IR = regs.__PVT__IR;

    u8 pcm0 = read_mem(top, PC - 1);
    u8 pcm1 = read_mem(top, PC);
    u8 pcm2 = read_mem(top, PC + 1);
    u8 pcm3 = read_mem(top, PC + 2);

    // Ensure hex, uppercase, zero-padded
    os << std::uppercase << std::hex << std::setfill('0');

    // clang-format off
    os << "A:"  << std::setw(2) << static_cast<int>(A)
       << " F:" << std::setw(2) << static_cast<int>(F)
       << " B:" << std::setw(2) << static_cast<int>(B)
       << " C:" << std::setw(2) << static_cast<int>(C)
       << " D:" << std::setw(2) << static_cast<int>(D)
       << " E:" << std::setw(2) << static_cast<int>(E)
       << " H:" << std::setw(2) << static_cast<int>(H)
       << " L:" << std::setw(2) << static_cast<int>(L)
       << " SP:" << std::setw(4) << static_cast<int>(SP)
       << " PC:" << std::setw(4) << static_cast<int>(PC - 1)
       << " PCMEM:"
       << std::setw(2) << static_cast<int>(pcm0) << ","
       << std::setw(2) << static_cast<int>(pcm1) << ","
       << std::setw(2) << static_cast<int>(pcm2) << ","
       << std::setw(2) << static_cast<int>(pcm3)
       << "\n";
    // clang-format on

    if (++line_count >= 100) {
        os.flush();
        line_count = 0;
    }
}

static bool load_rom(VGameboy& top, const fs::path& filename) {
    std::ifstream rom(filename, std::ios::binary);
    if (!rom.good()) {
        printf("Cannot open ROM!\n");
        return false;
    }

    for (int i = 0; i < 0x8000; i++) {
        char byte;
        rom.read(&byte, 1);
        top.rootp->Gameboy__DOT__cart_inst__DOT__ROM[i] = (u8)byte;
    }
    return true;
}

static u8 last_SC = 0;
static std::string serial_buffer;

static bool handle_serial_output(VGameboy& top) {
    u8 SB = top.rootp->Gameboy__DOT__serial_inst__DOT__SB;
    u8 SC = top.rootp->Gameboy__DOT__serial_inst__DOT__SC;

    bool printed = false;

    if ((last_SC & 0x80) == 0 && (SC & 0x80)) {
        const char c = static_cast<char>(SB);
        std::cout << c << std::flush;
        serial_buffer.push_back(c);
        top.rootp->Gameboy__DOT__serial_inst__DOT__SC &= 0x7F;
        printed = true;
    }

    last_SC = SC;
    return printed;
}

static void tick(VGameboy& top, VerilatedContext& ctx) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(5);

    top.clk = 1;
    top.eval();
    ctx.timeInc(5);
}

static void set_initial_state(VGameboy& top) {
    auto& regs = top.rootp->Gameboy__DOT__cpu_inst__DOT__regs;

    // regs.__PVT__a = 0x01;
    // regs.__PVT__flags = 0xB0;
    // regs.__PVT__b = 0x00;
    // regs.__PVT__c = 0x13;
    // regs.__PVT__d = 0x00;
    // regs.__PVT__e = 0xD8;
    // regs.__PVT__h = 0x01;
    // regs.__PVT__l = 0x4D;

    regs.__PVT__sph = 0xFF;
    regs.__PVT__spl = 0xFE;

    // regs.__PVT__pch = 0x01;
    // regs.__PVT__pcl = 0x00;

    // regs.__PVT__IR = 0x00;
}

static void draw_from_vram(VGameboy& top) {
    void* pixels;
    int pitch;
    SDL_LockTexture(texture, nullptr, &pixels, &pitch);
    u32* out = (u32*)pixels;

    auto& vram = top.rootp->Gameboy__DOT__ppu_inst__DOT__VRAM;

    u8 LCDC = top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LCDC;
    u8 SCX = top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__SCX;
    u8 SCY = top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__SCY;

    bool signed_index = !(LCDC & 0x10); // tile data at 0x8800 or 0x8000
    u16 tilemap_base = (LCDC & 0x08) ? 0x1C00 : 0x1800; // 9800 or 9C00

    for (int y = 0; y < GB_HEIGHT; ++y) {
        int map_y = (y + SCY) & 255;
        int tile_row = (map_y / 8) * 32;

        for (int x = 0; x < GB_WIDTH; ++x) {
            int map_x = (x + SCX) & 255;

            int tile_col = map_x / 8;
            u8 tile_index = vram[tilemap_base + tile_row + tile_col];

            int tile = signed_index ? (int8_t)tile_index + 256 : tile_index;

            int tile_y = map_y % 8;
            int tile_x = 7 - (map_x % 8);

            u8* td = &vram[tile * 16 + tile_y * 2];
            u8 lo = td[0];
            u8 hi = td[1];
            u8 color = ((hi >> tile_x) & 1) * 2 + ((lo >> tile_x) & 1);

            out[y * GB_WIDTH + x] = gb_color(color);
        }
    }

    SDL_UnlockTexture(texture);
    SDL_RenderCopy(renderer, texture, nullptr, nullptr);
    SDL_RenderPresent(renderer);
}

int main() {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);

    static const fs::path trace_log_path = fs::path(SOURCE_DIR) / "trace.txt";

    std::ofstream trace(trace_log_path, std::ios::trunc);
    if (!trace.is_open()) {
        std::cerr << "[Error] Unable to open trace.txt\n";
        return 1;
    }

    static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/cpu_instrs.gb";

    VGameboy top(&ctx);

    if (!load_rom(top, rom_path)) {
        return 1;
    }

    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        std::cerr << "SDL init failed: " << SDL_GetError() << "\n";
        return 1;
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

    top.reset = 1;
    top.eval();
    top.reset = 0;
    top.eval();

    set_initial_state(top);

    for (int i = 0; i < 0x7F; i++) {
        top.rootp->Gameboy__DOT__ram_inst__DOT__HRAM[i] = 0xFF;
    }

    const uint64_t max_cycles = 200'000;

    bool quit = false;
    SDL_Event e;

    while (top.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary == 0) {
        tick(top, ctx);
    }

    for (int i = 0; i < max_cycles; ++i) {
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT)
                quit = true;
        }

        top.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary = 0;
        while (top.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary == 0) {
            tick(top, ctx);
        }

        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT)
                quit = true;
        }

        if (top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LY == 144) {
            draw_from_vram(top);
        }

        // dump_gd_trace(top, trace);

        if (handle_serial_output(top)) {
            // if (serial_buffer.find("Passed") != std::string::npos) {
            //     std::cout << "\n[INFO] Test Passed!\n";
            //     break;
            // }
        }
    }

    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    return 1;
}
