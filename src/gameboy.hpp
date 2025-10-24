#pragma once

#include <memory>

#include "apu.hpp"
#include "cartridge/cartridge.hpp"
#include "cpu/cpu.hpp"
#include "io.hpp"
#include "mmu/mmu.hpp"
#include "ppu/ppu.hpp"
#include "timer.hpp"
#include "types.hpp"

class GameBoy {
public:
    GameBoy() {
        mmu = std::make_unique<MMU>(*this);
        cpu = std::make_unique<CPU>(*this);

        ppu = nullptr;
        apu = nullptr;
        io = nullptr;
        timer = nullptr;
    }

    // System components
    std::unique_ptr<Cartridge> cartridge;
    std::unique_ptr<CPU> cpu;
    std::unique_ptr<PPU> ppu;
    std::unique_ptr<APU> apu;
    std::unique_ptr<IO> io;
    std::unique_ptr<Timer> timer;
    std::unique_ptr<MMU> mmu;

    // Lifecycle
    void reset() {
        cpu->reset();
        ppu->reset();
    }
    void step();
    void load(const std::string& path);
};
