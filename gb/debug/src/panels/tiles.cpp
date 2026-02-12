#include "imgui.h"
#include <array>

#include "panels/tiles.hpp"

namespace debug::panels {

    static constexpr int TILE_SIZE = 16;

    static uint16_t tile_offset(uint16_t tileIndex) {
        return tileIndex * TILE_SIZE;
    }

    std::array<std::array<uint8_t, 8>, 8> decode_tile(const uint8_t* vram, uint16_t tileIndex) {
        std::array<std::array<uint8_t, 8>, 8> pixels {};

        const uint8_t* tile = vram + tileIndex * 16;

        for (int y = 0; y < 8; y++) {
            uint8_t lo = tile[y * 2];
            uint8_t hi = tile[y * 2 + 1];

            for (int x = 0; x < 8; x++) {
                uint8_t bit = 7 - x;
                pixels[y][x] = ((hi >> bit) & 1) << 1 | ((lo >> bit) & 1);
            }
        }
        return pixels;
    }

    void TilesPanel::set_snapshot(const std::array<u8, 0x10000>& mem) {
        vram_ = &mem[VRAM_START];
        dirty_.fill(false);
        focused_tile_.reset();
    }

    void TilesPanel::set_highlight(const std::vector<u16>& addrs) {
        dirty_.fill(false);
        focused_tile_.reset();

        for (u16 addr : addrs) {
            if (addr >= VRAM_START && addr < VRAM_START + VRAM_SIZE) {
                dirty_[addr - VRAM_START] = true;
            }
        }

        // focus first dirty tile
        for (int t = 0; t < TILE_COUNT; ++t) {
            if (tile_dirty(t)) {
                focused_tile_ = t;
                break;
            }
        }
    }

    bool TilesPanel::tile_dirty(int tile) const {
        u16 base = tile * 16;
        for (int i = 0; i < 16; ++i)
            if (dirty_[base + i])
                return true;
        return false;
    }

    void TilesPanel::render() {
        if (!vram_)
            return;

        ImGui::Begin("VRAM Tiles");
        render_tile_grid();
        ImGui::End();
    }

    void TilesPanel::render_tile_grid() {
        constexpr int SCALE = 2;
        constexpr float TILE_PX = 8 * SCALE;

        ImGui::BeginChild("tiles", ImVec2(0, 0), true);
        ImGui::PushStyleVar(ImGuiStyleVar_ItemSpacing, ImVec2(2, 2));

        for (int t = 0; t < TILE_COUNT; ++t) {
            if (t % 16 != 0)
                ImGui::SameLine();

            auto pixels = decode_tile(vram_, t);

            ImGui::PushID(t);
            ImVec2 p = ImGui::GetCursorScreenPos();

            if (tile_dirty(t)) {
                ImGui::GetWindowDrawList()->AddRect(
                    p,
                    { p.x + TILE_PX, p.y + TILE_PX },
                    IM_COL32(255, 80, 80, 255));
            }

            if (selected_tile_ == t) {
                ImGui::GetWindowDrawList()->AddRect(
                    p,
                    { p.x + TILE_PX, p.y + TILE_PX },
                    IM_COL32(100, 150, 255, 255),
                    0,
                    0,
                    2.0f);
            }

            ImGui::InvisibleButton("tile", { TILE_PX, TILE_PX });
            if (ImGui::IsItemClicked()) {
                selected_tile_ = t;
            }

            // draw pixels
            auto* draw = ImGui::GetWindowDrawList();
            for (int y = 0; y < 8; y++)
                for (int x = 0; x < 8; x++) {
                    uint8_t c = pixels[y][x] * 85;
                    draw->AddRectFilled(
                        { p.x + x * SCALE, p.y + y * SCALE },
                        { p.x + (x + 1) * SCALE, p.y + (y + 1) * SCALE },
                        IM_COL32(c, c, c, 255));
                }

            if (focused_tile_ && *focused_tile_ == t)
                ImGui::SetScrollHereY(0.3f);

            ImGui::PopID();
        }

        ImGui::PopStyleVar();
        ImGui::EndChild();
    }

} // namespace debug::panels
