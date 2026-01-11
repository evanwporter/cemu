#ifndef SDL_MAIN_HANDLED
#define SDL_MAIN_HANDLED
#endif

#include "include/gbh.hpp"

#include <VGameboy.h>
#include <VGameboy___024root.h>
#include <verilated.h>

#include <filesystem>

#include <argparse/argparse.hpp>

#include "gb.hpp"

namespace fs = std::filesystem;

vluint64_t main_time = 0;

double sc_time_stamp() {
    return main_time;
}

int main(int argc, char* argv[]) {
    argparse::ArgumentParser program("vemu");

    program.add_argument("rom")
        .help("Path to the ROM file to load.");

    program.add_argument("-s", "--skip-boot-rom")
        .help("Skip the boot ROM and start execution directly at 0x0100.")
        .flag();

    program.add_argument("-g", "--gui")
        .help("Enable the SDL2 GUI.")
        .flag();

    program.add_argument("-t", "--trace")
        .help("Enable gameboy trace dumping.")
        .flag();

    program.add_argument("-d", "--debug")
        .help("Enable the built-in debugger.")
        .flag();

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
    // static const fs::path rom_path = fs::path(TEST_DIR) / "dmg-acid2.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/cpu_instrs.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "gb-test-roms/instr_timing/instr_timing.gb";

    // static const fs::path rom_path = fs::path(TEST_DIR) / "mooneye-test-suite/acceptance/timer/tima_write_reloading.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "Blue.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "mooneye-test-suite/acceptance/jp_timing.gb";
    // static const fs::path rom_path = fs::path(TEST_DIR) / "mooneye-test-suite/acceptance/bits/unused_hwio-GS.gb";

    try {
        program.parse_args(argc, argv);
    } catch (const std::exception& err) {
        std::cerr << err.what() << std::endl;
        std::cerr << program;
        return 1;
    }

    const fs::path rom_path = program.get<std::string>("rom");
    const bool skip_boot_rom = program.get<bool>("--skip-boot-rom");
    const bool gui_enabled = program.get<bool>("--gui");
    const bool dump_trace_enabled = program.get<bool>("--trace");
    const bool enable_debugger = program.get<bool>("--debug");

    GameboyHarness harness(gui_enabled, dump_trace_enabled, skip_boot_rom);

    GB::Options gb_options {
        .gui_enabled = gui_enabled,
        .dump_trace_enabled = dump_trace_enabled,
        .skip_boot_rom = skip_boot_rom,
        .enable_debugger = enable_debugger,
    };

    GB gb(gb_options);

    if (!gb.setup(rom_path)) {
        return 1;
    }

    gb.run();

    return 0;
}
