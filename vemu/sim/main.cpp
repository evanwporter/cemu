#ifndef SDL_MAIN_HANDLED
#define SDL_MAIN_HANDLED
#endif

#include <VGameboy.h>
#include <VGameboy___024root.h>
#include <verilated.h>

#include <filesystem>

#include "gb.hpp"

namespace fs = std::filesystem;

vluint64_t main_time = 0;

double sc_time_stamp() {
    return main_time;
}

int main() {
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/cpu_instrs.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/01-special.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/02-interrupts.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/03-op sp,hl.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/04-op r,imm.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/05-op rp.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/06-ld r,r.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/07-jr,jp,call,ret,rst.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/08-misc instrs.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/09-op r,r.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/10-bit ops.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual/11-op a,(hl).gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "tetris.gb";
    static const fs::path rom_path = fs::path(TEST_DIR) / "dmg-acid2.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/cpu_instrs.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/instr_timing/instr_timing.gb";

    GameboyHarness harness(true, false);

    if (!harness.run(rom_path)) {
        return 1;
    }

    return 0;
}
