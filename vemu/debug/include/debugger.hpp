#pragma once
#include "panels/cpu_state.hpp"
#include "panels/instr_history.hpp"
#include "panels/memory_viewer.hpp"

#include <SDL2/SDL.h>

#include <array>

// #include "gbh.hpp"
#include "op_history.hpp"
#include "panels/tiles.hpp"
#include "types.hpp"

class GB;

namespace debug {

    enum class DebugCommand {
        None,
        Run,
        Pause,
        StepOnce,
        Stop,
        Reset,
        Quit,
    };

    class Debugger {
    public:
        Debugger(GB& gb, VGameboy& top, bool enabled = false) :
            emu(gb), top(top), enabled(enabled) { };

        /// Sets up the debugger GUI and state
        bool setup();

        /// This function is called after every tick (clock)
        void on_tick();

        /// This function is called after every instruction step
        void on_step();

        /// Shuts down the debugger and cleans up resources
        void exit();

        /// Polls for debugger commands
        DebugCommand poll_command();

    private:
        GB& emu;
        VGameboy& top;

        bool enabled = true;

        MemorySelection memory_selection;

        ExecMode exec_mode = ExecMode::Running;

        // Panels
        panels::CPUStatePanel cpu_panel;
        panels::MemoryViewerPanel memory_panel;
        panels::InstructionHistoryPanel instr_history_panel;
        panels::TilesPanel tiles_panel;

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

        void render_controls();

        std::array<u8, 0x10000> memory_snapshot;

        CPURegisters last_cpu_state {};
    };

} // namespace debug