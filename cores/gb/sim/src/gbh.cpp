#include "gbh.hpp"

#include <SDL.h>

#include <VGameboy.h>
#include <VGameboy___024root.h>
#include <verilated.h>
#include <verilated_types.h>

#include "boot.hpp"

#include <filesystem>
#include <fstream>
#include <iomanip>
#include <iostream>

namespace fs = std::filesystem;

bool GB::setup(const std::filesystem::path& rom_path) {
    top = std::make_unique<VGameboy>();
    debugger = std::make_unique<debug::Debugger>(*this, *top, options.enable_debugger);
    gpu.emplace(
        top->rootp->Gameboy__DOT__ppu_inst__DOT__VRAM,
        top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LY,
        top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LYC,
        top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__SCX,
        top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__SCY,
        top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__WX,
        top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__WY,
        top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LCDC,
        top->rootp->Gameboy__DOT__ppu_inst__DOT__framebuffer_inst__DOT__buffer,
        options.gui_enabled);
    cpu.emplace(*top);

    if (!load_rom(rom_path)) {
        return false;
    }

    top->reset = 1;
    top->eval();
    top->reset = 0;
    top->eval();

    set_initial_state();

    for (int i = 0; i < 0x7F; i++) {
        top->rootp->Gameboy__DOT__hram_inst__DOT__mem[i] = 0xFF;
    }

    while (began_instruction()) {
        tick();
    }

    if (options.dump_trace_enabled) {
        static const fs::path trace_log_path = fs::path(SOURCE_DIR) / "trace.log";

        trace.open(trace_log_path, std::ios::trunc);
        if (!trace.is_open()) {
            std::cerr << "[Error] Unable to open trace.log\n";
            return false;
        }
    }

    if (!gpu->setup()) {
        return false;
    }

    if (!debugger->setup()) {
        return false;
    }

    return true;
}

u8 GB::read_memory(u16 addr) const {

    bool boot_rom_active = (top->rootp->Gameboy__DOT__cart_inst__DOT__boot_rom_switch != 1);

    if (addr <= 0x00FF && boot_rom_active) {
        return bootDMG[addr];
    }

    if (addr <= 0x3FFF) {
        u8 val = static_cast<u8>(top->rootp->Gameboy__DOT__cart_inst__DOT__ROM[addr]);
        return val;
    }

    if (addr <= 0x7FFF) {
        u32 address = top->rootp->Gameboy__DOT__cart_inst__DOT__selected_rom_bank * 16 * 1024 + addr - 0x4000;
        u8 val = static_cast<u8>(top->rootp->Gameboy__DOT__cart_inst__DOT__ROM[address]);
        return val;
    }

    // VRAM
    else if (addr <= 0x9FFF) {
        u16 address = addr - 0x8000;
        u8 val = top->rootp->Gameboy__DOT__ppu_inst__DOT__VRAM[address];
        return val;
    }

    else if (addr <= 0xBFFF) {
        u16 address = addr - 0xA000;
        u8 val = top->rootp->Gameboy__DOT__wram_inst__DOT__mem[address];
        return val;
    }

    else if (addr <= 0xDFFF) {
        u16 address = addr - 0xC000;
        u8 val = top->rootp->Gameboy__DOT__wram_inst__DOT__mem[address];
        return val;
    }

    else if (addr <= 0xFDFF) {
        u16 address = addr - 0xC000 - 0x2000;
        u8 val = top->rootp->Gameboy__DOT__wram_inst__DOT__mem[address];
        return val;
    }

    else if (addr <= 0xFE9F) {
        u16 address = addr - 0xFE00;
        u8 val = top->rootp->Gameboy__DOT__ppu_inst__DOT__OAM[address];
        return val;
    }

    else if (addr <= 0xFF7F) {
        // std::cout << "Read from IO address 0x" << std::hex << addr << std::dec << "\n";
        return 0xFF;
    }

    else if (addr <= 0xFFFE) {
        u16 address = addr - 0xFF80;
        u8 val = top->rootp->Gameboy__DOT__hram_inst__DOT__mem[address];
        return val;
    }

    // Unusable memory
    else if (addr <= 0xFFFF) {
        // std::cout << "Read from IE register 0x" << std::hex << addr << std::dec << "\n";
        return 0xFF;
    }

    else {
        std::cerr << "ERROR: Attempted to read from invalid memory address 0x" << std::hex << addr << std::dec << "\n";
        return 0xFF;
    }
}

bool GB::load_rom(const fs::path& filename) {
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

    for (size_t i = 0; i < sizeof(top->rootp->Gameboy__DOT__cart_inst__DOT__ROM); i++) {
        top->rootp->Gameboy__DOT__cart_inst__DOT__ROM[i] = 0;
    }

    for (int i = 0; i < 0x8000; i++) {
        char byte = 0;
        rom.read(&byte, 1);
        if (!rom)
            break;
        top->rootp->Gameboy__DOT__cart_inst__DOT__ROM[i] = (u8)byte;
    }

    u8 rom_size_code = top->rootp->Gameboy__DOT__cart_inst__DOT__ROM[0x0148];

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
        top->rootp->Gameboy__DOT__cart_inst__DOT__ROM[i] = (u8)byte;
    }

    std::cout << "Loaded ROM: " << total_bytes / 1024 << " KiB\n";
    return true;
}

void GB::set_initial_state() {
    auto& regs = top->rootp->Gameboy__DOT__cpu_inst__DOT__regs;
    auto& ppu_regs = top->rootp->Gameboy__DOT__ppu_inst__DOT__regs;
    regs.__PVT__sph = 0xFF;
    regs.__PVT__spl = 0xFE;

    if (options.skip_boot_rom) {
        regs.__PVT__a = 0x01;
        regs.__PVT__flags = 0xB0;
        regs.__PVT__b = 0x00;
        regs.__PVT__c = 0x13;
        regs.__PVT__d = 0x00;
        regs.__PVT__e = 0xD8;
        regs.__PVT__h = 0x01;
        regs.__PVT__l = 0x4D;

        regs.__PVT__pch = 0x01;
        regs.__PVT__pcl = 0x00;

        regs.__PVT__IR = 0x00;

        ppu_regs.__PVT__LCDC = 0x91;
        ppu_regs.__PVT__STAT = 0x81;
        ppu_regs.__PVT__SCX = 0x00;
        ppu_regs.__PVT__SCY = 0x00;
        ppu_regs.__PVT__WX = 0x00;
        ppu_regs.__PVT__WY = 0x00;
        ppu_regs.__PVT__LY = 0xFF;
        ppu_regs.__PVT__LYC = 0x00;
        ppu_regs.__PVT__BGP = 0xFC;

        top->rootp->Gameboy__DOT__cart_inst__DOT__boot_rom_switch = 1;
    }
}

bool GB::began_instruction() const {
    if (top->rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary == 0) {
        return true;
    }

    else {
        top->rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary = 0;
        return false;
    }
};

void GB::dump_gd_trace(std::ostream& os) {
    static int line_count = 0;

    auto& regs = top->rootp->Gameboy__DOT__cpu_inst__DOT__regs;

    u16 PC = cpu->get_PC();
    u16 SP = cpu->get_SP();

    u8 IR = regs.__PVT__IR;

    u8 pcm0 = read_memory(PC - 1);
    u8 pcm1 = read_memory(PC);
    u8 pcm2 = read_memory(PC + 1);
    u8 pcm3 = read_memory(PC + 2);

    u8 spm0 = read_memory(SP);
    u8 spm1 = read_memory(SP + 1);
    u8 spm2 = read_memory(SP + 2);
    u8 spm3 = read_memory(SP + 3);

    // Ensure hex, uppercase, zero-padded
    os << std::uppercase << std::hex << std::setfill('0');

    // clang-format off
    os << "A:"  << std::setw(2) << static_cast<int>(cpu->get_A())
       << " F:" << std::setw(2) << static_cast<int>(cpu->get_F())
       << " B:" << std::setw(2) << static_cast<int>(cpu->get_B())
       << " C:" << std::setw(2) << static_cast<int>(cpu->get_C())
       << " D:" << std::setw(2) << static_cast<int>(cpu->get_D())
       << " E:" << std::setw(2) << static_cast<int>(cpu->get_E())
       << " H:" << std::setw(2) << static_cast<int>(cpu->get_H())
       << " L:" << std::setw(2) << static_cast<int>(cpu->get_L())
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
       << " SCX:" << std::setw(2) << static_cast<int>(top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__SCX)
       << " SCY:" << std::setw(2) << static_cast<int>(top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__SCY)
       << " LY:" << std::setw(2) << static_cast<int>(top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LY)
       << " LYC:" << std::setw(2) << static_cast<int>(top->rootp->Gameboy__DOT__ppu_inst__DOT__regs.__PVT__LYC)
       << "\n";
    // clang-format on

    if (++line_count >= 100) {
        os.flush();
        line_count = 0;
    }

    os.flush();
}

void dump_vram(const VGameboy& top, const std::filesystem::path& path) {
    std::ofstream out(path, std::ios::binary);
    if (!out)
        throw std::runtime_error("Failed to open VRAM dump file");

    const auto& vram = top.rootp->Gameboy__DOT__ppu_inst__DOT__VRAM;

    for (int i = 0; i < 8192; ++i) {
        uint8_t byte = static_cast<uint8_t>(vram[i]);
        out.write(reinterpret_cast<const char*>(&byte), 1);
    }
}

void dump_oam(const VGameboy& top, const std::filesystem::path& path) {
    std::ofstream out(path, std::ios::binary);
    if (!out)
        throw std::runtime_error("Failed to open OAM dump file");

    const auto& oam = top.rootp->Gameboy__DOT__ppu_inst__DOT__OAM;

    for (int i = 0; i < 160; ++i) {
        uint8_t byte = static_cast<uint8_t>(oam[i]);
        out.write(reinterpret_cast<const char*>(&byte), 1);
    }
}

void dump_ppu_regs(const VGameboy& top, const std::filesystem::path& path) {
    std::ofstream out(path);
    if (!out)
        throw std::runtime_error("Failed to open regs dump file");

    const auto& r = top.rootp->Gameboy__DOT__ppu_inst__DOT__regs;

    out << std::hex << std::setfill('0');

    out << "LCDC: 0x" << std::setw(2) << int(r.__PVT__LCDC) << "\n";
    out << "STAT: 0x" << std::setw(2) << int(r.__PVT__STAT) << "\n";
    out << "SCY : 0x" << std::setw(2) << int(r.__PVT__SCY) << "\n";
    out << "SCX : 0x" << std::setw(2) << int(r.__PVT__SCX) << "\n";
    out << "LY  : 0x" << std::setw(2) << int(r.__PVT__LY) << "\n";
    out << "LYC : 0x" << std::setw(2) << int(r.__PVT__LYC) << "\n";
    out << "BGP : 0x" << std::setw(2) << int(r.__PVT__BGP) << "\n";
    out << "OBP0: 0x" << std::setw(2) << int(r.__PVT__OBP0) << "\n";
    out << "OBP1: 0x" << std::setw(2) << int(r.__PVT__OBP1) << "\n";
    out << "WY  : 0x" << std::setw(2) << int(r.__PVT__WY) << "\n";
    out << "WX  : 0x" << std::setw(2) << int(r.__PVT__WX) << "\n";
}

bool GB::tick() {
    top->clk = 0;
    top->eval();
    ctx.timeInc(5);

    top->clk = 1;
    top->eval();
    ctx.timeInc(5);

    cycles++;

    bool print = false;

    if (print) {
        const auto outdir = std::filesystem::path(__FILE__).parent_path() / "artifacts";
        std::filesystem::create_directories(outdir);

        dump_vram(*top, outdir / "vram.bin");
        dump_oam(*top, outdir / "oam.bin");
        dump_ppu_regs(*top, outdir / "ppu_regs.txt");
    }

    if (!gpu->update()) {
        return false;
    }

    return true;
}

bool GB::step() {
    while (began_instruction()) {
        if (!tick())
            return false;
        // debugger->on_tick();
    }
    // debugger->on_step();
    handle_serial_output();
    return true;
}

bool GB::run() {

    using namespace debug;

    bool quit = false;
    while (!quit) {
        const auto cmd = false // options.enable_debugger
            ? debugger->poll_command()
            : DebugCommand::Run;

        switch (cmd) {
        case DebugCommand::Quit:
            quit = true;
            break;

        case DebugCommand::Reset:
            // reset(); // implement: rebuild top, reload rom, re-init state
            break;

        case DebugCommand::Stop:
            // maybe just pause forever until quit/reset?
            break;

        case DebugCommand::Pause:
            // don't vgba emu, but keep drawing debugger UI
            // if (debugger)
            //     debugger->on_idle();
            break;

        case DebugCommand::StepOnce:
            // if (debugger)
            //     debugger->on_step(); // update panels
            break;

        case DebugCommand::Run:
            // if (debugger)
            //     debugger->on_step();
            if (!step()) {
                quit = true;
                break;
            }
            break;

        case DebugCommand::None:
            // treat as Pause or Run depending on preference
            break;
        }
    }

    debugger->exit();
    gpu->exit();

    return true;
}

bool GB::handle_serial_output() {
    static u8 last_SC = 0;

    u8 SB = top->rootp->Gameboy__DOT__serial_inst__DOT__SB;
    u8 SC = top->rootp->Gameboy__DOT__serial_inst__DOT__SC;

    bool printed = false;

    if ((last_SC & 0x80) == 0 && (SC & 0x80)) {
        const char c = static_cast<char>(SB);
        std::cout << c << std::flush;
        serial_buffer.push_back(c);
        top->rootp->Gameboy__DOT__serial_inst__DOT__SC &= 0x7F;
        printed = true;
    }

    last_SC = SC;
    return printed;
}