#include "panels/memory_viewer.hpp"
#include "imgui.h"

#include <cstdio>

namespace debug::panels {

    MemoryViewerPanel::MemoryViewerPanel() = default;

    void MemoryViewerPanel::update(const u16 addr, const u8 value) {
        memory_[addr] = value;
    }

    void MemoryViewerPanel::render() {
        if (!visible_)
            return;

        // Left-side placement
        ImGui::SetNextWindowPos(ImVec2(10, 10), ImGuiCond_FirstUseEver);
        ImGui::SetNextWindowSize(ImVec2(520, 580), ImGuiCond_FirstUseEver);

        ImGui::Begin("Memory");

        if (ImGui::BeginTabBar("MemoryTabs")) {

            if (ImGui::BeginTabItem("ROM")) {
                render_region(0x0000, 0x7FFF);
                ImGui::EndTabItem();
            }

            if (ImGui::BeginTabItem("VRAM")) {
                render_region(0x8000, 0x9FFF);
                ImGui::EndTabItem();
            }

            if (ImGui::BeginTabItem("WRAM")) {
                render_region(0xC000, 0xDFFF);
                ImGui::EndTabItem();
            }

            if (ImGui::BeginTabItem("OAM")) {
                render_region(0xFE00, 0xFE9F);
                ImGui::EndTabItem();
            }

            if (ImGui::BeginTabItem("IO")) {
                render_region(0xFF00, 0xFF7F);
                ImGui::EndTabItem();
            }

            if (ImGui::BeginTabItem("HRAM")) {
                render_region(0xFF80, 0xFFFE);
                ImGui::EndTabItem();
            }

            ImGui::EndTabBar();
        }

        ImGui::End();
    }

    void MemoryViewerPanel::render_region(u16 start, u16 end) {
        ImGui::BeginChild("mem_scroll", ImVec2(0, 0), false, ImGuiWindowFlags_HorizontalScrollbar);

        for (u32 addr = start; addr <= end; addr += 16) {

            bool row_has_highlight = false;
            for (int i = 0; i < 16 && addr + i <= end; ++i) {
                if (highlight_[addr + i]) {
                    row_has_highlight = true;
                    break;
                }
            }

            if (row_has_highlight) {
                ImGui::PushStyleColor(
                    ImGuiCol_Text,
                    IM_COL32(255, 80, 80, 255));
            }

            char line[128];
            int offset = std::snprintf(line, sizeof(line), "%04X: ", addr);

            for (int i = 0; i < 16 && addr + i <= end; ++i) {
                offset += std::snprintf(
                    line + offset,
                    sizeof(line) - offset,
                    "%02X ",
                    memory_[addr + i]);
            }

            ImGui::TextUnformatted(line);

            // Auto-scroll to focused address
            if (focus_addr_ && addr <= *focus_addr_ && *focus_addr_ < addr + 16) {
                ImGui::SetScrollHereY(0.35f);
            }

            if (row_has_highlight) {
                ImGui::PopStyleColor();
            }
        }

        ImGui::EndChild();
    }

    void MemoryViewerPanel::set_snapshot(
        const std::array<u8, 0x10000>& mem) {
        memory_ = mem;
        highlight_.fill(false);
        focus_addr_.reset();
    }

    void MemoryViewerPanel::set_selection(const MemorySelection& sel) {
        highlight_.fill(false);
        focus_addr_.reset();

        if (!sel.valid)
            return;

        for (u16 addr : sel.addresses) {
            highlight_[addr] = true;
        }

        // Focus first modified address
        focus_addr_ = sel.addresses.front();
    }

}
