#pragma once

#include <SDL.h>

#include <VGameboy.h>
#include <VGameboy___024root.h>
#include <memory>
#include <verilated.h>

#include <filesystem>
#include <fstream>

#include "types.hpp"

#include "gpu.hpp"

class GB {
private:
    struct CPU {
    private:
        VGameboy_cpu_regs_t__struct__0& cpu_regs;

    public:
        CPU(VGameboy& top) :
            cpu_regs(top.rootp->Gameboy__DOT__cpu_inst__DOT__regs) { }

        u8& get_A() { return cpu_regs.__PVT__a; }
        u8& get_F() { return cpu_regs.__PVT__flags; }
        u8& get_B() { return cpu_regs.__PVT__b; }
        u8& get_C() { return cpu_regs.__PVT__c; }
        u8& get_D() { return cpu_regs.__PVT__d; }
        u8& get_E() { return cpu_regs.__PVT__e; }
        u8& get_H() { return cpu_regs.__PVT__h; }
        u8& get_L() { return cpu_regs.__PVT__l; }
        u16 get_SP() { return (static_cast<u16>(cpu_regs.__PVT__sph) << 8) | cpu_regs.__PVT__spl; }
        u16 get_PC() { return static_cast<u16>(cpu_regs.__PVT__pch) << 8 | cpu_regs.__PVT__pcl; }
    };

public:
    struct Options {
        bool gui_enabled = true;
        bool dump_trace_enabled = false;
        bool skip_boot_rom = false;
    };

    GB(Options options) :
        options(options) { }

    std::optional<CPU> cpu;

    /// Sets up the Gameboy with the given ROM.
    bool setup(const std::filesystem::path& rom_path);

    /// Advances the simulation by one tick (clock).
    void tick();

    /// Advance the simulation by one CPU instruction.
    void step();

    /// Runs the Gameboy until completion.
    void run();

    /// Reads a byte from the Gameboy's memory.
    u8 read_memory(u16 addr) const;

    /// Return true if we are at the beginning of an instruction.
    bool began_instruction() const;

private:
    std::unique_ptr<VGameboy> top;
    std::optional<GPU> gpu;

    VerilatedContext ctx;

    u64 cycles = 0;

    /// Loads a ROM into the Gameboy's memory.
    bool load_rom(const std::filesystem::path& filename);

    void set_initial_state();

    Options options;

    void dump_gd_trace(std::ostream& os);

    // Trace log file that we output to if enabled.
    std::ofstream trace;

    std::string serial_buffer;
    bool handle_serial_output();
};