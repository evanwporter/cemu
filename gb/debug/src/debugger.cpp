#include "debugger.hpp"

#include "VGameboy_Bus_if.h"
#include "backends/imgui_impl_sdl2.h"
#include "backends/imgui_impl_sdlrenderer2.h"
#include "gbh.hpp"
#include "imgui.h"
#include "mem_write_table.hpp"

#include <SDL2/SDL.h>

namespace debug {

    bool Debugger::setup() {
        if (!enabled)
            return true;

        for (int i = 0; i < 0x10000; ++i) {
            memory_snapshot[i] = 0x00;
        }

        if (!init_gui()) {
            return false;
        }

        return true;
    };

    void Debugger::exit() {
        if (!enabled)
            return;

        shutdown_imgui();

        if (renderer)
            SDL_DestroyRenderer(renderer);
        if (window)
            SDL_DestroyWindow(window);

        SDL_Quit();
    }

    bool Debugger::init_gui() {
        if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_GAMECONTROLLER) != 0)
            return false;

        window = SDL_CreateWindow(
            "Game Boy Debugger",
            SDL_WINDOWPOS_CENTERED,
            SDL_WINDOWPOS_CENTERED,
            1200,
            700,
            SDL_WINDOW_SHOWN);

        renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
        if (!window || !renderer)
            return false;

        IMGUI_CHECKVERSION();
        ImGui::CreateContext();
        ImGui::StyleColorsDark();

        ImGui_ImplSDL2_InitForSDLRenderer(window, renderer);
        ImGui_ImplSDLRenderer2_Init(renderer);

        instr_history_panel.set_history(&operation_history);
        tiles_panel.set_snapshot(memory_snapshot);

        return true;
    }

    void Debugger::shutdown_imgui() {
        ImGui_ImplSDLRenderer2_Shutdown();
        ImGui_ImplSDL2_Shutdown();
        ImGui::DestroyContext();
    }

    void Debugger::process_events() {
        SDL_Event e;
        while (SDL_PollEvent(&e)) {
            ImGui_ImplSDL2_ProcessEvent(&e);
            if (e.type == SDL_QUIT)
                quit = true;
        }
    }

    void Debugger::begin_frame() {
        ImGui_ImplSDLRenderer2_NewFrame();
        ImGui_ImplSDL2_NewFrame();
        ImGui::NewFrame();
    }

    void Debugger::end_frame() {
        ImGui::Render();
        SDL_SetRenderDrawColor(renderer, 45, 45, 48, 255);
        SDL_RenderClear(renderer);
        ImGui_ImplSDLRenderer2_RenderDrawData(ImGui::GetDrawData());
        SDL_RenderPresent(renderer);
    }

    void Debugger::on_tick() {
        if (!enabled)
            return;

        // Update any per-tick debugger state here
        if (emu.get_top().rootp->__PVT__Gameboy__DOT__cpu_bus->write_en) {
            const auto delta = Delta {
                .addr = static_cast<u16>(emu.get_top().rootp->__PVT__Gameboy__DOT__cpu_bus->addr),
                .value = static_cast<u8>(emu.get_top().rootp->__PVT__Gameboy__DOT__cpu_bus->wdata)
            };
            if (operation_history.get_latest_delta() && operation_history.get_latest_delta()->addr != delta.addr) {
                // Write operation is performed
                operation_history.back().history.push_back(delta);
                memory_snapshot[delta.addr] = delta.value;
            }
        }
    }

    void Debugger::on_step() {
        if (!enabled)
            return;

        const u8 A = emu.cpu->get_A();
        const u8 F = emu.cpu->get_F();
        const u8 B = emu.cpu->get_B();
        const u8 C = emu.cpu->get_C();
        const u8 D = emu.cpu->get_D();
        const u8 E = emu.cpu->get_E();
        const u8 H = emu.cpu->get_H();
        const u8 L = emu.cpu->get_L();
        const u8 W = emu.cpu->get_W();
        const u8 Z = emu.cpu->get_Z();

        const u16 SP = emu.cpu->get_SP();
        const u16 PC = emu.cpu->get_PC();

        const u8 opcode = emu.cpu->get_opcode();
        const std::optional<u8> cb_opcode = opcode == 0xCB
            ? std::optional<u8>(emu.read_memory(PC))
            : std::nullopt;

        const auto cpu_state = debug::CPURegisters {
            .AF = static_cast<debug::u16>((A << 8) | F),
            .BC = static_cast<debug::u16>((B << 8) | C),
            .DE = static_cast<debug::u16>((D << 8) | E),
            .HL = static_cast<debug::u16>((H << 8) | L),
            .SP = static_cast<debug::u16>(SP),
            .PC = static_cast<debug::u16>(PC),
        };

        const auto& info = mem_write_table[opcode];

        for (int i = 0; i < info.count; i++) {
            const auto& w = info.writes[i];

            u16 base = 0;
            switch (w.addr_src) {
            case MemAddrSrc::HL:
                base = cpu_state.HL;
                break;
            case MemAddrSrc::BC:
                base = cpu_state.BC;
                break;
            case MemAddrSrc::DE:
                base = cpu_state.DE;
                break;
            case MemAddrSrc::SP:
                base = cpu_state.SP;
                break;
            case MemAddrSrc::WZ:
                base = (W << 8) | Z;
                break;
            case MemAddrSrc::FF_C:
                base = 0xFF00 | (cpu_state.BC & 0xFF);
                break;
            case MemAddrSrc::FF_Z:
                base = 0xFF00 | Z;
                break;
            default:
                continue;
            }

            const u16 addr = base + w.offset;
            const u8 new_value = emu.read_memory(addr);

            memory_panel.update(addr, new_value);
        }

        cpu_panel.update(cpu_state);

        begin_frame();

        cpu_panel.render();
        memory_panel.render();
        render_controls();
        tiles_panel.render();

        if (auto selected = instr_history_panel.render(exec_mode)) {
            size_t op_index = *selected;

            auto snapshot = operation_history.get_state_at(op_index);
            memory_panel.set_snapshot(snapshot);

            memory_selection.addresses.clear();
            for (const auto& d : operation_history
                                     .get_operations()[op_index]
                                     .history) {
                memory_selection.addresses.push_back(d.addr);
            }

            memory_selection.valid = !memory_selection.addresses.empty();

            memory_panel.set_selection(memory_selection);
        }

        end_frame();

        last_cpu_state = cpu_state;
    }

    void Debugger::render_controls() {
        ImGui::Begin("Controls");

        if (exec_mode == ExecMode::Running) {
            if (ImGui::Button("Pause")) {
                exec_mode = ExecMode::Paused;
            }
        } else {
            if (ImGui::Button("Play")) {
                exec_mode = ExecMode::Running;
            }
        }

        ImGui::SameLine();
        if (ImGui::Button("Step")) {
            exec_mode = ExecMode::StepOnce;
        }

        ImGui::SameLine();
        if (ImGui::Button("Stop")) {
            exec_mode = ExecMode::Stopped;
        }

        ImGui::SameLine();
        if (ImGui::Button("Reset")) {
            // reset_requested = true;
        }

        ImGui::End();
    }

    DebugCommand Debugger::poll_command() {
        if (!enabled)
            return DebugCommand::None;

        process_events();

        if (quit)
            return DebugCommand::Quit;

        switch (exec_mode) {
        case ExecMode::Running:
            return DebugCommand::Run;
        case ExecMode::Paused:
            return DebugCommand::Pause;
        case ExecMode::StepOnce:
            exec_mode = ExecMode::Paused;
            return DebugCommand::StepOnce;
        case ExecMode::Stopped:
            return DebugCommand::Stop;
        }
        return DebugCommand::None;
    }
}
