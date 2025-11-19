#include <VGameboy.h>
#include <VGameboy___024root.h>
#include <cstdint>
#include <iomanip>
#include <verilated.h>

#include <filesystem>
#include <fstream>
#include <iostream>

namespace fs = std::filesystem;

static int opcodes_executed = 0;

vluint64_t main_time = 0;

using u8 = uint8_t;
using u16 = uint16_t;

double sc_time_stamp() {
    return main_time;
}

u8 read_mem(VGameboy& top, u16 PC) {
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

    // clang-format off
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
    //    << " IR:" << std::setw(2) << static_cast<int>(IR)
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
        top.rootp->Gameboy__DOT__cart_inst__DOT__ROM[i] = (uint8_t)byte;
    }
    return true;
}

static uint8_t last_SC = 0;

static void handle_serial_output(VGameboy& top) {
    u8 SB = top.rootp->Gameboy__DOT__serial_inst__DOT__SB;
    u8 SC = top.rootp->Gameboy__DOT__serial_inst__DOT__SC;

    if ((last_SC & 0x80) == 0 && (SC & 0x80)) {
        const char c = static_cast<char>(SB);
        std::cout << c << std::flush;
        top.rootp->Gameboy__DOT__serial_inst__DOT__SC &= 0x7F;
    }

    last_SC = SC;
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

    regs.__PVT__a = 0x01;
    regs.__PVT__flags = 0xB0;
    regs.__PVT__b = 0x00;
    regs.__PVT__c = 0x13;
    regs.__PVT__d = 0x00;
    regs.__PVT__e = 0xD8;
    regs.__PVT__h = 0x01;
    regs.__PVT__l = 0x4D;

    regs.__PVT__sph = 0xFF;
    regs.__PVT__spl = 0xFE;

    regs.__PVT__pch = 0x01;
    regs.__PVT__pcl = 0x00;

    regs.__PVT__IR = 0x00;
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

    static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/01-special.gb";

    VGameboy top(&ctx);

    if (!load_rom(top, rom_path)) {
        return 1;
    }

    top.reset = 1;
    top.eval();
    top.reset = 0;
    top.eval();

    set_initial_state(top);

    for (int i = 0; i < 0x7F; i++) {
        top.rootp->Gameboy__DOT__ram_inst__DOT__HRAM[i] = 0xFF;
    }

    const uint64_t max_cycles = 200'000;

    while (top.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary == 0) {
        tick(top, ctx);
    }

    for (int i = 0; i < max_cycles; ++i) {
        top.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary = 0;
        while (top.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary == 0) {
            tick(top, ctx);
        }
        dump_gd_trace(top, trace);
        handle_serial_output(top);
    }

    return 0;
}
