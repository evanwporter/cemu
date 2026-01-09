#include "panels/instr_history.hpp"
#include "opcodes.hpp"

#include "imgui.h"
#include <optional>

namespace debug::panels {

    void InstructionHistoryPanel::set_history(const OperationHistory* history) {
        history_ = history;
    }

    std::optional<std::size_t> InstructionHistoryPanel::render(ExecMode exec_mode) {
        if (!history_)
            return std::nullopt;

        // Freeze while running
        if (exec_mode != ExecMode::Running) {
            visible_count_ = history_->get_operations().size();
        }

        ImGui::Begin("Instruction History");

        bool cb_opcode = false;

        for (size_t i = 0; i < visible_count_; ++i) {
            const auto& op = history_->get_operations()[i];

            char label[64];

            if (op.opcode == 0xCB) {
                cb_opcode = true;
                continue;
            }

            if (cb_opcode)
                snprintf(label, sizeof(label), "%02X %s", op.opcode, opcode_cb_names[op.opcode]);
            else
                snprintf(label, sizeof(label), "%02X %s", op.opcode, opcode_names[op.opcode]);

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