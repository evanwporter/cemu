#include "gameboy.hpp"
#include "cartridge/cartridge.hpp"
#include <memory>

Gameboy::Gameboy(Options& options) :
    cpu(std::make_unique<CPU>(*this, options)),
    ppu(std::make_unique<PPU>(*this, options)),
    mmu(std::make_unique<MMU>(*this, options)),
    timer(std::make_unique<Timer>(*this)),
    serial(options) {
    if (options.disable_logs)
        log_set_level(LogLevel::Error);

    log_set_level(options.trace ? LogLevel::Trace : LogLevel::Info);
}

Gameboy::Gameboy(const std::string& filename, Options& options) :
    cartridge(std::make_unique<Cartridge>()),
    cpu(std::make_unique<CPU>(*this, options)),
    ppu(std::make_unique<PPU>(*this, options)),
    mmu(std::make_unique<MMU>(*this, options)),
    timer(std::make_unique<Timer>(*this)),
    serial(options) {

    cartridge->load(filename);

    if (options.disable_logs)
        log_set_level(LogLevel::Error);

    log_set_level(options.trace ? LogLevel::Trace : LogLevel::Info);
}

void Gameboy::button_pressed(GbButton button) {
    io.button_pressed(button);
}

void Gameboy::button_released(GbButton button) {
    io.button_released(button);
}

void Gameboy::debug_toggle_background() {
    ppu->debug_disable_background = !ppu->debug_disable_background;
}

void Gameboy::debug_toggle_sprites() {
    ppu->debug_disable_sprites = !ppu->debug_disable_sprites;
}

void Gameboy::debug_toggle_window() {
    ppu->debug_disable_window = !ppu->debug_disable_window;
}

void Gameboy::run(
    const should_close_callback_t& _should_close_callback,
    const vblank_callback_t& _vblank_callback) {
    should_close_callback = _should_close_callback;

    ppu->register_vblank_callback(_vblank_callback);

    while (!should_close_callback()) {
        tick();
    }
}

void Gameboy::tick() {

    auto cycles = cpu->tick();
    elapsed_cycles += cycles.cycles;

    ppu->tick(cycles);
    timer->tick(cycles.cycles);
}
