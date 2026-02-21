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

#include "debugger.hpp"

class GB {
private:
    struct SM83 {
    private:
        VGameboy_cpu_regs_t__struct__0& cpu_regs;

    public:
        SM83(VGameboy& top) :
            cpu_regs(top.rootp->Gameboy__DOT__cpu_inst__DOT__regs) { }

        u8& get_A() { return cpu_regs.__PVT__a; }
        u8& get_F() { return cpu_regs.__PVT__flags; }
        u8& get_B() { return cpu_regs.__PVT__b; }
        u8& get_C() { return cpu_regs.__PVT__c; }
        u8& get_D() { return cpu_regs.__PVT__d; }
        u8& get_E() { return cpu_regs.__PVT__e; }
        u8& get_H() { return cpu_regs.__PVT__h; }
        u8& get_L() { return cpu_regs.__PVT__l; }
        u8& get_W() { return cpu_regs.__PVT__w; }
        u8& get_Z() { return cpu_regs.__PVT__z; }
        u16 get_SP() { return (static_cast<u16>(cpu_regs.__PVT__sph) << 8) | cpu_regs.__PVT__spl; }
        u16 get_PC() { return static_cast<u16>(cpu_regs.__PVT__pch) << 8 | cpu_regs.__PVT__pcl; }

        u8 get_opcode() { return cpu_regs.__PVT__IR; }
    };

public:
    struct Options {
        bool gui_enabled = true;
        bool dump_trace_enabled = false;
        bool skip_boot_rom = false;
        bool enable_debugger = true;
    };

    GB() :
        options(Options { true, false, false, false }) { };

    GB(Options options) :
        options(options) { }

    std::optional<SM83> cpu;

    /// Sets up the Gameboy with the given ROM.
    bool setup(const std::filesystem::path& rom_path);

    /// Advances the simulation by one tick (clock).
    bool tick();

    /// Advance the simulation by one SM83 instruction.
    bool step();

    /// Runs the Gameboy until completion.
    bool run();

    /// Reads a byte from the Gameboy's memory.
    u8 read_memory(u16 addr) const;

    /// Return true if we are at the beginning of an instruction.
    bool began_instruction() const;

    /// API is subject to change
    VGameboy& get_top() {
        return *top;
    }

private:
    std::unique_ptr<VGameboy> top;
    std::optional<GPU> gpu;

    std::unique_ptr<debug::Debugger> debugger;

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