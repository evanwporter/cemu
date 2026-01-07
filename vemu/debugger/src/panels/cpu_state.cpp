
#include "imgui.h"

#include "panels/cpu_state.hpp"

#include "types.hpp"

namespace debug::panels {

    CPUStatePanel::CPUStatePanel() :
        visible_(true) {
    }

    void CPUStatePanel::update(const CPURegisters& state) {
        state_ = state;
    }

    void CPUStatePanel::render() {
        if (!visible_) {
            return;
        }

        // Set initial window position and size (only on first use)
        ImGui::SetNextWindowPos(ImVec2(10, 10), ImGuiCond_FirstUseEver);
        ImGui::SetNextWindowSize(ImVec2(200, 220), ImGuiCond_FirstUseEver);

        ImGui::Begin(get_name());

        // Cycle count
        // ImGui::Text("Cycle: %llu (0x%llX)", (unsigned long long)state_.cycle, (unsigned long long)state_.cycle);

        ImGui::Separator();

        // Program Counter and Stack Pointer
        ImGui::Text("PC: 0x%04X", state_.PC);
        ImGui::Text("SP: 0x%04X", state_.SP);

        ImGui::Separator();

        // Register pairs
        ImGui::Text("AF: 0x%04X", state_.AF);
        ImGui::Text("BC: 0x%04X", state_.BC);
        ImGui::Text("DE: 0x%04X", state_.DE);
        ImGui::Text("HL: 0x%04X", state_.HL);

        ImGui::Separator();

        // IME flag
        // ImGui::Text("IME: %s", state_.ime ? "Enabled" : "Disabled");

        ImGui::End();
    }

} // namespace debug::panels
