#pragma once
#include <array>

#include "address.hpp"
#include "cpu/register.hpp"
#include "tile.hpp"
#include "types.hpp"
#include "util/bitops.hpp"

class GameBoy;

constexpr int LCD_WIDTH = 160;
constexpr int LCD_HEIGHT = 144;

enum class PPU_MODES {
    HORIZONTAL_BLANK,
    VERTICAL_BLANK,
    OAM_SCAN,
    DRAWING_PIXELS,
};

class PPU {
public:
    explicit PPU(GameBoy& gb);
    ~PPU() = default;

    static constexpr Address VRAM_START { 0x8000 };

    static constexpr Address OAM_START { 0xFE00, VRAM_START };

    void reset();
    void step();

    // LCD Control
    Register8 LCDC = 0;

    Register8 SCX = 0;
    Register8 SCY = 0;

    Register8 WX = 0;
    Register8 WY = 0;

    // Tile data areas
    static constexpr Address TILE_DATA_AREA_0 { 0x8000, VRAM_START };
    static constexpr Address TILE_DATA_AREA_1 { 0x8800, VRAM_START };

    // Background & Window tile maps
    static constexpr Address TILE_MAP_AREA_0 { 0x9800, VRAM_START };
    static constexpr Address TILE_MAP_AREA_1 { 0x9C00, VRAM_START };

    u8 readVRAM(const u16 offset) const { return 0; };
    void writeVRAM(const u16 offset, const u8 value) { };

    u8 readVRAM(const Address& address) const { return 0; };
    void writeVRAM(const Address& address, const u8 value) { };

    u8 readOAM(const Address& address) const { return 0; };
    void writeOAM(const Address& address, const u8 value) { };

    bool display_enabled() const { return check_bit(LCDC, 7); }

    /// `0 = 9800–9BFF`; `1 = 9C00–9FFF`
    bool window_tile_map_area() const { return check_bit(LCDC, 6); }

    bool window_enabled() const { return check_bit(LCDC, 5); }

    /// `0 = 8800–97FF`; `1 = 8000–8FFF`
    bool bg_window_tile_data_area() const { return check_bit(LCDC, 4); }

    /// `0 = 9800–9BFF`; `1 = 9C00–9FFF`
    bool bg_tile_map_area() const { return check_bit(LCDC, 3); }

    /// `0 = 8x8`; `1 = 8x16`
    bool obj_size() const { return check_bit(LCDC, 2); }

    /// `0 = Off`; `1 = On`
    bool obj_enabled() const { return check_bit(LCDC, 1); }

    /// `0 = Off`; `1 = On`
    bool bg_enabled() const { return check_bit(LCDC, 0); }

    void draw_scanline(const int line) {
        if (!display_enabled())
            return;

        draw_bg_line(line);
        draw_window_line(line);
    }

    void step(const uint cycles) {
        cycle_count += cycles;

        switch (mode) {
        case PPU_MODES::OAM_SCAN:
            if (cycle_count >= 80) {
                cycle_count %= 80;
                mode = PPU_MODES::DRAWING_PIXELS;
            }
            break;

        case PPU_MODES::DRAWING_PIXELS:
            if (cycle_count >= 172) {
                cycle_count -= 172;
                mode = PPU_MODES::HORIZONTAL_BLANK;

                // Draw current scanline
                draw_bg_line(LY);
                draw_window_line(LY);
            }
            break;

        case PPU_MODES::HORIZONTAL_BLANK: // HBlank
            if (cycle_count >= 204) {
                cycle_count %= 204;
                LY++;
                if (LY == 144) {
                    mode = PPU_MODES::VERTICAL_BLANK;
                    requestVBlankInterrupt();
                } else {
                    mode = PPU_MODES::OAM_SCAN;
                }
            }
            break;

        case PPU_MODES::VERTICAL_BLANK: // VBlank
            if (cycle_count >= 456) {
                cycle_count %= 456;
                LY++;
                if (LY > 153) {
                    LY = 0;
                    mode = PPU_MODES::OAM_SCAN; // start new frame
                }
            }
            break;
        }
    }

private:
    GameBoy& gb;
    MMU& mmu;

    PPU_MODES mode = PPU_MODES::OAM_SCAN;

    uint cycle_count = 0;

    // Current scanline
    uint LY = 0;

    std::array<std::array<GBColors, LCD_WIDTH>, LCD_HEIGHT> framebuffer {};

    void draw_bg_line(const int line) {
        if (!bg_enabled())
            return;

        const Address mapBase = bg_tile_map_area() ? TILE_MAP_AREA_1 : TILE_MAP_AREA_0;
        const Address tileDataBase = bg_window_tile_data_area()
            ? TILE_DATA_AREA_0 // 0x8000–8FFF unsigned
            : TILE_DATA_AREA_1; // 0x8800–97FF signed

        int bgY = (SCY + line) & 0xFF;
        int tileY = bgY / 8;
        int fineY = bgY % 8;

        TileSet tiles;
        tiles.load(mmu, tileDataBase);

        TileMap tilemap;
        tilemap.load(mmu, mapBase);

        for (int x = 0; x < LCD_WIDTH; ++x) {
            int bgX = (SCX + x) & 0xFF;
            int tileX = bgX / 8;
            int fineX = bgX % 8;

            u8 tileId = tilemap.getTileId(tileX, tileY);
            if (!bg_window_tile_data_area())
                tileId = static_cast<s8>(tileId) + 128;

            const Tile& tile = tiles.get(tileId);
            framebuffer[line][x] = tile.pixel(fineX, fineY);
        }
    }

    void draw_window_line(const int line) {
        if (!window_enabled() || line < WY)
            return;

        const Address mapBase = window_tile_map_area() ? TILE_MAP_AREA_1 : TILE_MAP_AREA_0;
        const Address tileDataBase = bg_window_tile_data_area()
            ? TILE_DATA_AREA_0 // 0x8000–8FFF (unsigned)
            : TILE_DATA_AREA_1; // 0x8800–97FF (signed)

        int winLine = line - WY;
        int tileY = winLine / 8;
        int fineY = winLine % 8;

        TileSet tiles;
        tiles.load(mmu, tileDataBase);

        TileMap tilemap;
        tilemap.load(mmu, mapBase);

        for (int x = WX - 7; x < LCD_WIDTH; ++x) {
            if (x < 0)
                continue;

            int winX = x - (WX - 7);
            int tileX = winX / 8;
            int fineX = winX % 8;

            u8 tileId = tilemap.getTileId(tileX, tileY);
            if (!bg_window_tile_data_area())
                tileId = static_cast<s8>(tileId) + 128;

            const Tile& tile = tiles.get(tileId);
            framebuffer[line][x] = tile.pixel(fineX, fineY);
        }
    }

    void requestVBlankInterrupt();
};
