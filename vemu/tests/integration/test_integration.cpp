#include <VGameboy.h>
#include <VGameboy___024root.h>
#include <verilated.h>

#include "boot.hpp"
#include "gameboy.hpp"
#include "options.hpp"

#include <filesystem>
#include <fstream>
#include <gtest/gtest.h>

vluint64_t global_timestamp = 0;

inline double sc_time_stamp() { return global_timestamp; }

namespace fs = std::filesystem;

static inline std::string color_red(const std::string& s) { return "\033[31m" + s + "\033[0m"; }
static inline std::string color_green(const std::string& s) { return "\033[32m" + s + "\033[0m"; }

static inline std::string byte_hex(uint8_t v) {
    std::ostringstream oss;
    oss << std::uppercase << std::hex << std::setw(2) << std::setfill('0') << int(v);
    return oss.str();
}

static inline std::string word_hex(uint16_t v) {
    std::ostringstream oss;
    oss << std::uppercase << std::hex << std::setw(4) << std::setfill('0') << v;
    return oss.str();
}

static inline std::string color_c(u8 vreg, u8 creg) {
    return (vreg == creg) ? byte_hex(creg) : color_green(byte_hex(creg));
}

static inline std::string color_v(u8 vreg, u8 creg) {
    return (vreg == creg) ? byte_hex(vreg) : color_red(byte_hex(vreg));
}

static inline std::string color_v16(u16 vreg, u16 creg) {
    return (vreg == creg) ? word_hex(vreg) : color_red(word_hex(vreg));
}

static inline std::string color_c16(u16 vreg, u16 creg) {
    return (vreg == creg) ? word_hex(creg) : color_green(word_hex(creg));
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

    else if (PC == 0xFF00) {
        return top.rootp->Gameboy__DOT__input_inst__DOT__JOYPAD_reg;
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

    else if (PC <= 0xFFFF) {
        std::cout << "Read from IE register 0x" << std::hex << PC << std::dec << "\n";
        return 0xFF;
    }

    else {
        std::cerr << "error: Attempted to read from invalid memory address 0x" << std::hex << PC << std::dec << "\n";
        return 0xFF;
    }
}

struct CPUState {
    u8 A, F;
    u8 B, C, D, E, H, L;
    u16 PC, SP;
    u8 PCMEM[4];
};

static CPUState get_vemu_state(VGameboy& top) {
    auto& r = top.rootp->Gameboy__DOT__cpu_inst__DOT__regs;

    CPUState s;
    s.A = r.__PVT__a;
    s.F = r.__PVT__flags;
    s.B = r.__PVT__b;
    s.C = r.__PVT__c;
    s.D = r.__PVT__d;
    s.E = r.__PVT__e;
    s.H = r.__PVT__h;
    s.L = r.__PVT__l;

    s.PC = ((r.__PVT__pch << 8) | r.__PVT__pcl) - 1;
    s.SP = (r.__PVT__sph << 8) | r.__PVT__spl;

    for (int i = 0; i < 4; ++i)
        s.PCMEM[i] = read_mem(top, s.PC + i);

    return s;
}

static CPUState get_cemu_state(Gameboy& gb) {
    CPUState s;

    s.A = gb.cpu->A.value();
    s.F = gb.cpu->F.value();
    s.B = gb.cpu->B.value();
    s.C = gb.cpu->C.value();
    s.D = gb.cpu->D.value();
    s.E = gb.cpu->E.value();
    s.H = gb.cpu->H.value();
    s.L = gb.cpu->L.value();

    s.PC = gb.cpu->PC.value();
    s.SP = gb.cpu->SP.value();

    for (int i = 0; i < 4; ++i)
        s.PCMEM[i] = gb.mmu->read(s.PC + i);

    return s;
}

struct PPUState {
    u8 LCDC;
    u8 SCY, SCX;
    u8 LY;
    u8 LYC;
    u8 BGP;
    u8 STAT;
};

static PPUState get_vemu_ppu_state(VGameboy& top) {
    auto& r = top.rootp->Gameboy__DOT__ppu_inst__DOT__regs;

    PPUState s;
    s.LCDC = r.__PVT__LCDC;
    s.SCY = r.__PVT__SCY;
    s.SCX = r.__PVT__SCX;
    s.LY = r.__PVT__LY;
    s.LYC = r.__PVT__LYC;
    s.BGP = r.__PVT__BGP;
    // s.STAT = r.__PVT__STAT;
    return s;
}

static PPUState get_cemu_ppu_state(Gameboy& gb) {
    PPUState s;

    s.BGP = gb.ppu->bg_palette.value();
    s.LCDC = gb.ppu->control_byte;
    s.SCY = gb.ppu->scroll_y.value();
    s.SCX = gb.ppu->scroll_x.value();
    s.LY = gb.ppu->line.value();
    s.LYC = gb.ppu->ly_compare.value();
    // s.STAT = gb.ppu->lcd_status.value();

    return s;
}

::testing::AssertionResult cpu_states_equal(const CPUState& v, const CPUState& c, int instr) {
    if (!memcmp(&v, &c, sizeof(CPUState)))
        return ::testing::AssertionSuccess();

    std::ostringstream msg;

    msg << "\n\033[1mMismatch after instruction " << instr << "\033[0m\n\n";

    msg << "VEMU: "
        << "A:" << color_v(v.A, c.A) << " "
        << "F:" << color_v(v.F, c.F) << " "
        << "B:" << color_v(v.B, c.B) << " "
        << "C:" << color_v(v.C, c.C) << " "
        << "D:" << color_v(v.D, c.D) << " "
        << "E:" << color_v(v.E, c.E) << " "
        << "H:" << color_v(v.H, c.H) << " "
        << "L:" << color_v(v.L, c.L) << " "
        << "PC:" << color_v16(v.PC, c.PC) << " "
        << "SP:" << color_v16(v.SP, c.SP) << " "
        << "PCMEM: " << color_v(v.PCMEM[0], c.PCMEM[0]) << " "
        << color_v(v.PCMEM[1], c.PCMEM[1]) << " "
        << color_v(v.PCMEM[2], c.PCMEM[2]) << " "
        << color_v(v.PCMEM[3], c.PCMEM[3]) << "\n";

    msg << "CEMU: "
        << "A:" << color_c(v.A, c.A) << " "
        << "F:" << color_c(v.F, c.F) << " "
        << "B:" << color_c(v.B, c.B) << " "
        << "C:" << color_c(v.C, c.C) << " "
        << "D:" << color_c(v.D, c.D) << " "
        << "E:" << color_c(v.E, c.E) << " "
        << "H:" << color_c(v.H, c.H) << " "
        << "L:" << color_c(v.L, c.L) << " "
        << "PC:" << color_c16(v.PC, c.PC) << " "
        << "SP:" << color_c16(v.SP, c.SP) << " "
        << "PCMEM: " << color_c(v.PCMEM[0], c.PCMEM[0]) << " "
        << color_c(v.PCMEM[1], c.PCMEM[1]) << " "
        << color_c(v.PCMEM[2], c.PCMEM[2]) << " "
        << color_c(v.PCMEM[3], c.PCMEM[3]) << "\n";

    return ::testing::AssertionFailure() << msg.str();
}

::testing::AssertionResult ppu_states_equal(const PPUState& v, const PPUState& c, int instr) {
    if (!memcmp(&v, &c, sizeof(PPUState)))
        return ::testing::AssertionSuccess();

    std::ostringstream msg;

    msg << "\n\033[1mMismatch after instruction " << instr << "\033[0m\n\n";

    msg << "VEMU: "
        << "BGP:" << color_v(v.BGP, c.BGP) << " "
        << "LCDC:" << color_v(v.LCDC, c.LCDC) << " "
        << "LY:" << color_v(v.LY, c.LY) << " "
        << "LYC:" << color_v(v.LYC, c.LYC) << " "
        << "STAT:" << color_v(v.STAT, c.STAT) << " "
        << "SCX:" << color_v(v.SCX, c.SCX) << " "
        << "SCY:" << color_v(v.SCY, c.SCY) << "\n";

    msg << "CEMU: "
        << "BGP:" << color_c(v.BGP, c.BGP) << " "
        << "LCDC:" << color_c(v.LCDC, c.LCDC) << " "
        << "LY:" << color_c(v.LY, c.LY) << " "
        << "LYC:" << color_c(v.LYC, c.LYC) << " "
        << "STAT:" << color_c(v.STAT, c.STAT) << " "
        << "SCX:" << color_c(v.SCX, c.SCX) << " "
        << "SCY:" << color_c(v.SCY, c.SCY) << "\n";

    return ::testing::AssertionFailure() << msg.str();
}

static std::string format_cpu_state(const CPUState& s) {
    std::ostringstream oss;
    oss << "A:" << byte_hex(s.A)
        << " F:" << byte_hex(s.F)
        << " BC:" << byte_hex(s.B) << byte_hex(s.C)
        << " DE:" << byte_hex(s.D) << byte_hex(s.E)
        << " HL:" << byte_hex(s.H) << byte_hex(s.L)
        << " SP:" << word_hex(s.SP)
        << " PC:" << word_hex(s.PC)
        << " MEM:" << byte_hex(s.PCMEM[0]) << " "
        << byte_hex(s.PCMEM[1]) << " "
        << byte_hex(s.PCMEM[2]) << " "
        << byte_hex(s.PCMEM[3]) << " ";
    return oss.str();
}

static std::string format_ppu_state(const PPUState& s) {
    std::ostringstream oss;
    oss << "BGP:" << byte_hex(s.BGP)
        << " LCDC:" << byte_hex(s.LCDC)
        << " LY:" << byte_hex(s.LY)
        << " LYC:" << byte_hex(s.LYC)
        << " STAT:" << byte_hex(s.STAT)
        << " SCX:" << byte_hex(s.SCX)
        << " SCY:" << byte_hex(s.SCY) << " ";
    return oss.str();
}

static ::testing::AssertionResult assert_vram_equal(VGameboy& top, Gameboy& gb, int instr) {
    auto& v_vram = top.rootp->Gameboy__DOT__ppu_inst__DOT__VRAM;
    // CEMU support: single VRAM bank only (DMG)
    for (int i = 0; i < 0x2000; i++) {
        u8 v = v_vram[i];
        u8 c = gb.mmu->read(0x8000 + i);
        if (v != c) {
            std::ostringstream oss;
            oss << "VRAM mismatch at 0x"
                << std::hex << (0x8000 + i)
                << " after instruction " << std::dec << instr << "\n"
                << std::hex
                << " VEMU=" << byte_hex(v)
                << " CEMU=" << byte_hex(c);
            return ::testing::AssertionFailure() << oss.str();
        }
    }
    return ::testing::AssertionSuccess();
}

static ::testing::AssertionResult assert_oam_equal(VGameboy& top, Gameboy& gb, int instr) {
    auto& v_oam = top.rootp->Gameboy__DOT__ppu_inst__DOT__OAM;

    for (int i = 0; i < 0xA0; i++) {
        u8 v = v_oam[i];
        u8 c = gb.mmu->read(0xFE00 + i);
        if (v != c) {
            std::ostringstream oss;
            oss << "OAM mismatch at 0x"
                << std::hex << (0xFE00 + i)
                << " after instruction " << std::dec << instr << "\n"
                << std::hex
                << " VEMU=" << byte_hex(v)
                << " CEMU=" << byte_hex(c);
            return ::testing::AssertionFailure() << oss.str();
        }
    }
    return ::testing::AssertionSuccess();
}

static ::testing::AssertionResult assert_rom_equal(VGameboy& top, Gameboy& gb, int instr) {
    for (int i = 0; i < 0x8000; i++) {
        u8 v = read_mem(top, i);
        u8 c = gb.mmu->read(i);

        if (v != c) {
            std::ostringstream oss;
            oss << "ROM mismatch at address 0x"
                << std::hex << i << " after instruction " << std::dec << instr << "\n"
                << std::hex
                << "VEMU=" << std::setw(2) << std::setfill('0') << int(v) << ", "
                << "CEMU=" << std::setw(2) << std::setfill('0') << int(c);
            return ::testing::AssertionFailure() << oss.str();
        }
    }
    return ::testing::AssertionSuccess();
}

static ::testing::AssertionResult assert_io_equal(VGameboy& top, Gameboy& gb, int instr) {
    for (int i = 0xFF00; i < 0xFF7F; i++) {
        u8 v = read_mem(top, i);
        u8 c = gb.mmu->read(i);

        if (v != c) {
            std::ostringstream oss;
            oss << "IO mismatch at address 0x"
                << std::hex << i << " after instruction " << std::dec << instr << "\n"
                << std::hex
                << "VEMU=" << std::setw(2) << std::setfill('0') << int(v) << ", "
                << "CEMU=" << std::setw(2) << std::setfill('0') << int(c);
            return ::testing::AssertionFailure() << oss.str();
        }
    }
    return ::testing::AssertionSuccess();
}

static ::testing::AssertionResult assert_ram_equal(VGameboy& top, Gameboy& gb, int instr) {
    auto& v_wram = top.rootp->Gameboy__DOT__ram_inst__DOT__WRAM;
    auto& v_hram = top.rootp->Gameboy__DOT__ram_inst__DOT__HRAM;

    // WRAM: 8 KB at 0xC000–0xDFFF
    for (int i = 0; i < 0x2000; i++) {
        u16 addr = 0xC000 + i;
        u8 v = v_wram[i];
        u8 c = gb.mmu->read(addr);
        if (v != c) {
            std::ostringstream oss;
            oss << "WRAM mismatch at 0x"
                << std::hex << addr
                << " after instruction " << std::dec << instr << "\n"
                << std::hex
                << " VEMU=" << byte_hex(v)
                << " CEMU=" << byte_hex(c);
            return ::testing::AssertionFailure() << oss.str();
        }
    }

    // HRAM: 0xFF80–0xFFFE (127 bytes)
    for (int i = 0; i < 0x7F; i++) {
        u16 addr = 0xFF80 + i;
        u8 v = v_hram[i];
        u8 c = gb.mmu->read(addr);
        if (v != c) {
            std::ostringstream oss;
            oss << "HRAM mismatch at 0x"
                << std::hex << addr
                << " after instruction " << std::dec << instr << "\n"
                << std::hex
                << " VEMU=" << byte_hex(v)
                << " CEMU=" << byte_hex(c);
            return ::testing::AssertionFailure() << oss.str();
        }
    }

    return ::testing::AssertionSuccess();
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

class GameboyCoSimTest : public ::testing::Test {
protected:
    const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/01-special.gb";
    VerilatedContext ctx;
    VGameboy vemu;
    Gameboy cemu;
    Options options;
    std::ofstream cemu_log;
    std::ofstream vemu_log;

    GameboyCoSimTest() :
        vemu(&ctx),
        cemu(rom_path.string(), options) {
        ctx.time(0);
    }

    void SetUp() override {
        cemu_log.open("cemu_log.txt");
        vemu_log.open("vemu_log.txt");

        load_rom(vemu, rom_path);

        vemu.reset = 1;
        vemu.eval();
        tick_vemu();

        vemu.reset = 0;
        vemu.eval();
        tick_vemu();

        cemu.cpu->SP.set(0xFFFE);

        for (int i = 0; i < 0x7F; ++i)
            vemu.rootp->Gameboy__DOT__ram_inst__DOT__HRAM[i] = 0x00;

        while (vemu.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary == 0)
            tick_vemu();
    }

    void TearDown() override {
        if (cemu_log.is_open())
            cemu_log.close();
        if (vemu_log.is_open())
            vemu_log.close();
    }

    void tick_vemu() {
        vemu.clk = 0;
        vemu.eval();
        ctx.timeInc(1);

        vemu.clk = 1;
        vemu.eval();
        ctx.timeInc(1);
    }
};

TEST_F(GameboyCoSimTest, CPU_Instruction_Compatibility) {

    const int MAX_INSTRUCTIONS = 200000;

    CPUState v_cpu_state = get_vemu_state(vemu);
    CPUState c_cpu_state = get_cemu_state(cemu);
    PPUState v_ppu_state = get_vemu_ppu_state(vemu);
    PPUState c_ppu_state = get_cemu_ppu_state(cemu);

    cemu_log << format_cpu_state(c_cpu_state) << format_ppu_state(c_ppu_state) << "\n";
    vemu_log << format_cpu_state(v_cpu_state) << format_ppu_state(v_ppu_state) << "\n";

    ASSERT_TRUE(cpu_states_equal(v_cpu_state, c_cpu_state, 0));
    ASSERT_TRUE(ppu_states_equal(v_ppu_state, c_ppu_state, 0));
    ASSERT_TRUE(assert_rom_equal(vemu, cemu, 0));
    ASSERT_TRUE(assert_vram_equal(vemu, cemu, 0));
    ASSERT_TRUE(assert_oam_equal(vemu, cemu, 0));
    ASSERT_TRUE(assert_ram_equal(vemu, cemu, 0));
    // ASSERT_TRUE(assert_io_equal(vemu, cemu, 0));

    for (int instr = 1; instr < MAX_INSTRUCTIONS; ++instr) {

        // cemu.tick();

        vemu.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary = 0;

        while (vemu.rootp->Gameboy__DOT__cpu_inst__DOT__instr_boundary == 0) {
            tick_vemu();
        }

        v_cpu_state = get_vemu_state(vemu);
        c_cpu_state = get_cemu_state(cemu);

        v_ppu_state = get_vemu_ppu_state(vemu);
        c_ppu_state = get_cemu_ppu_state(cemu);

        cemu_log << format_cpu_state(c_cpu_state) << format_ppu_state(c_ppu_state) << "\n";
        vemu_log << format_cpu_state(v_cpu_state) << format_ppu_state(v_ppu_state) << "\n";

        // ASSERT_TRUE(cpu_states_equal(v_cpu_state, c_cpu_state, instr));
        // ASSERT_TRUE(ppu_states_equal(v_ppu_state, c_ppu_state, instr));
        // ASSERT_TRUE(assert_vram_equal(vemu, cemu, instr));
        // ASSERT_TRUE(assert_oam_equal(vemu, cemu, instr));
        // ASSERT_TRUE(assert_ram_equal(vemu, cemu, instr));
        // ASSERT_TRUE(assert_io_equal(vemu, cemu, instr));

        if (!cemu.mmu->boot_rom_active()) {
            std::cout << "Boot ROM finished at instruction " << instr << "\n";
            break;
        }
    }
}
