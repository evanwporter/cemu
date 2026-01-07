#include "panels/instr_history.hpp"

#include "imgui.h"
#include <optional>

namespace debug::panels {

    void InstructionHistoryPanel::set_history(const OperationHistory* history) {
        history_ = history;
    }

    std::optional<size_t> InstructionHistoryPanel::render(ExecMode exec_mode) {
        if (!history_)
            return std::nullopt;

        // Freeze while running
        if (exec_mode != ExecMode::Running) {
            visible_count_ = history_->get_operations().size();
        }

        ImGui::Begin("Instruction History");

        for (size_t i = 0; i < visible_count_; ++i) {
            const auto& op = history_->get_operations()[i];

            char label[64];
            snprintf(label, sizeof(label), "%06zu | OPCODE %02X | %zu writes", i, op.opcode, op.history.size());

            if (ImGui::Selectable(label, selected_ == (int)i)) {
                selected_ = (int)i;
                ImGui::End();
                return i;
            }
        }

        ImGui::End();
        return std::nullopt;
    }

} // namespace debug::panels