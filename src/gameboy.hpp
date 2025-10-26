#pragma once

#include <functional>
#include <memory>

#include "cpu/cpu.hpp"
#include "io/io.hpp"
#include "io/serial.hpp"
#include "options.hpp"
#include "ppu/ppu.hpp"
#include "timer/timer.hpp"
#include "util/log.hpp"

using should_close_callback_t = std::function<bool()>;

class Gameboy {
public:
    Gameboy(Options& options);

    Gameboy(const std::string& filename, Options& options);

    void run(
        const should_close_callback_t& _should_close_callback,
        const vblank_callback_t& _vblank_callback);

    void button_pressed(GbButton button);
    void button_released(GbButton button);

    void debug_toggle_background();
    void debug_toggle_sprites();
    void debug_toggle_window();

    const std::vector<u8>& get_cartridge_ram() const;

    void tick();

    std::shared_ptr<Cartridge> cartridge;

    std::unique_ptr<CPU> cpu;
    friend class CPU;

    std::unique_ptr<PPU> ppu;
    friend class PPU;

    std::unique_ptr<MMU> mmu;
    friend class MMU;

    std::unique_ptr<Timer> timer;
    friend class Timer;

    IO io;
    Serial serial;

private:
    uint elapsed_cycles = 0;

    should_close_callback_t should_close_callback;
};
