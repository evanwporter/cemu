#include <SDL.h>

#include "VGameboy_Bus_if.h"
#include <VGameboy.h>
#include <VGameboy___024root.h>
#include <verilated.h>
#include <verilated_types.h>

#include "boot.hpp"

#include <cstdint>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <iostream>

#include "gb.hpp"

namespace fs = std::filesystem;

bool GameboyHarness::run(const fs::path& rom_path, InstructionCallback on_instruction) {

    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);

    std::ofstream trace;

    if (dump_trace_enabled) {
        static const fs::path trace_log_path = fs::path(SOURCE_DIR) / "trace.log";

        trace.open(trace_log_path, std::ios::trunc);
        if (!trace.is_open()) {
            std::cerr << "[Error] Unable to open trace.log\n";
            return false;
        }
    }

    VGameboy top(&ctx);

    if (!load_rom(top, rom_path)) {
        return false;
    }

    if (gui_enabled) {
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
    }

    top.reset = 1;
    top.eval();
    top.reset = 0;
    top.eval();

    set_initial_state(top);

    for (int i = 0; i < 0x7F; i++) {
        top.rootp->Gameboy__DOT__ram_inst__DOT__HRAM[i] = 0xFF;
    }

    const uint64_t max_cycles = 1'000'000'000;

    bool quit = false;
    SDL_Event e;

    u64 cycles = 0;

    while (top.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary == 0) {
        tick(top, ctx, cycles);
    }

    for (int i = 0; i < max_cycles; ++i) {
        if (gui_enabled) {
            while (SDL_PollEvent(&e)) {
                if (e.type == SDL_QUIT)
                    quit = true;
            }
        }

        top.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary = 0;
        while (top.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary == 0) {
            tick(top, ctx, cycles);
        }

        if (gui_enabled) {
            while (SDL_PollEvent(&e)) {
                if (e.type == SDL_QUIT)
                    quit = true;
            }

            if (top.rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LY == 144) {
                draw_from_vram(top);
                present_frame();
            }
        }

        if (dump_trace_enabled)
            dump_gd_trace(top, trace);

        if (handle_serial_output(top)) {
            // if (serial_buffer.find("Passed") != std::string::npos) {
            //     std::cout << "\n[INFO] Test Passed!\n";
            //     break;
            // }
        }

        if (on_instruction) {
            if (!on_instruction(*this, top)) {
                break; // early exit requested
            }
        }
    }

    if (gui_enabled) {
        SDL_DestroyTexture(texture);
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        SDL_Quit();
    }

    return true;
}

u8 GameboyHarness::read_mem(VGameboy& top, u16 PC) {

    bool boot_rom_active = (top.rootp->Gameboy__DOT__cart_inst__DOT__boot_rom_switch != 1);

    if (PC <= 0x00FF && boot_rom_active) {
        return bootDMG[PC];
    }

    if (PC <= 0x3FFF) {
        u8 val = static_cast<u8>(top.rootp->Gameboy__DOT__cart_inst__DOT__ROM[PC]);
        return val;
    }

    if (PC <= 0x7FFF) {
        u32 addr = top.rootp->Gameboy__DOT__cart_inst__DOT__selected_rom_bank * 16 * 1024 + PC - 0x4000;
        u8 val = static_cast<u8>(top.rootp->Gameboy__DOT__cart_inst__DOT__ROM[addr]);
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
        // std::cout << "Read from IE register 0x" << std::hex << PC << std::dec << "\n";
        return 0xFF;
    }

    else {
        std::cerr << "ERROR: Attempted to read from invalid memory address 0x" << std::hex << PC << std::dec << "\n";
        return 0xFF;
    }
}

void GameboyHarness::dump_gd_trace(VGameboy& top, std::ostream& os) {
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

    u8 spm0 = read_mem(top, SP);
    u8 spm1 = read_mem(top, SP + 1);
    u8 spm2 = read_mem(top, SP + 2);
    u8 spm3 = read_mem(top, SP + 3);

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
       << " SPMEM:"
       << std::setw(2) << static_cast<int>(spm0) << ","
       << std::setw(2) << static_cast<int>(spm1) << ","
       << std::setw(2) << static_cast<int>(spm2) << ","
       << std::setw(2) << static_cast<int>(spm3)
       << "\n";
    // clang-format on

    if (++line_count >= 100) {
        os.flush();
        line_count = 0;
    }

    os.flush();
}

bool GameboyHarness::load_rom(VGameboy& top, const fs::path& filename) {
    std::ifstream rom(filename, std::ios::binary);
    if (!rom) {
        std::cerr << "Cannot open ROM!\n";
        return false;
    }

    size_t file_size = 0;
    char tmp;
    while (rom.read(&tmp, 1))
        file_size++;

    rom.clear();
    rom.seekg(0);

    for (size_t i = 0; i < sizeof(top.rootp->Gameboy__DOT__cart_inst__DOT__ROM); i++) {
        top.rootp->Gameboy__DOT__cart_inst__DOT__ROM[i] = 0;
    }

    for (int i = 0; i < 0x8000; i++) {
        char byte = 0;
        rom.read(&byte, 1);
        if (!rom)
            break;
        top.rootp->Gameboy__DOT__cart_inst__DOT__ROM[i] = (u8)byte;
    }

    u8 rom_size_code = top.rootp->Gameboy__DOT__cart_inst__DOT__ROM[0x0148];

    static const int banks[9] = {
        2, // 0x00
        4, // 0x01
        8, // 0x02
        16, // 0x03
        32, // 0x04
        64, // 0x05
        128, // 0x06
        256, // 0x07
        512 // 0x08
    };

    if (rom_size_code > 8) {
        std::cerr << "Invalid ROM size code\n";
        return false;
    }

    size_t expected_size = banks[rom_size_code] * 16 * 1024;

    if (file_size != expected_size) {
        std::cerr
            << "ROM size mismatch:\n"
            << "  Header says : " << expected_size << " bytes\n"
            << "  File size   : " << file_size << " bytes\n";
        return false; // or warn + continue
    }

    const int total_bytes = banks[rom_size_code] * 16 * 1024;

    for (int i = 0x8000; i < total_bytes; i++) {
        char byte = 0;
        rom.read(&byte, 1);
        if (!rom)
            break;
        top.rootp->Gameboy__DOT__cart_inst__DOT__ROM[i] = (u8)byte;
    }

    std::cout << "Loaded ROM: " << total_bytes / 1024 << " KiB\n";
    return true;
}

bool GameboyHarness::handle_serial_output(VGameboy& top) {
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

void GameboyHarness::tick(VGameboy& top, VerilatedContext& ctx, u64& cycles) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(5);

    top.clk = 1;
    top.eval();
    ctx.timeInc(5);

    cycles++;
}

void GameboyHarness::set_initial_state(VGameboy& top) {
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

void GameboyHarness::present_frame() {
    SDL_UpdateTexture(
        texture,
        nullptr,
        framebuffer,
        GB_WIDTH * sizeof(u32));
    SDL_RenderCopy(renderer, texture, nullptr, nullptr);
    SDL_RenderPresent(renderer);
}

void GameboyHarness::draw_from_vram(VGameboy& top) {
    auto& vram = top.rootp->Gameboy__DOT__ppu_inst__DOT__VRAM;
    const auto& regs = top.rootp->Gameboy__DOT__ppu_inst__DOT__regs;

    const u8 LCDC = regs.__PVT__LCDC;
    const u8 SCX = regs.__PVT__SCX;
    const u8 SCY = regs.__PVT__SCY;

    bool signed_index = !(LCDC & 0b00010000); // tile data at 0x8800 or 0x8000
    u16 tilemap_base = (LCDC & 0b00001000) ? 0x1C00 : 0x1800; // 9800 or 9C00

    u16 tile_data_base = (LCDC & 0x10) ? 0x0000 : 0x0800;

    bool window_enable = LCDC & 0b00100000;
    assert(!window_enable); // Not implemented

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

            framebuffer[y * GB_WIDTH + x] = gb_color(color);
        }
    }
}