#pragma once
#include "panels/cpu_state.hpp"
#include "panels/memory_viewer.hpp"

#include <SDL2/SDL.h>

#include "gb.hpp"
#include "op_history.hpp"
#include "types.hpp"

namespace debug {

    class Debugger {
    public:
        Debugger();

        bool init(GameboyHarness& emu);
        void run(GameboyHarness& emu);
        void shutdown();

    private:
        // Panels
        panels::CPUStatePanel cpu_panel;
        panels::MemoryViewerPanel memory_panel;

        // SDL
        SDL_Window* window = nullptr;
        SDL_Renderer* renderer = nullptr;
        bool quit = false;

        OperationHistory operation_history;

        // ImGui lifecycle
        bool init_gui();
        void shutdown_imgui();

        // Main loop helpers
        void process_events();
        void begin_frame();
        void end_frame();

        std::array<u8, 0x10000> memory_snapshot;

        CPURegisters last_cpu_state {};
    };

} // namespace debug