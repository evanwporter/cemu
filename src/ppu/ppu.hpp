#pragma once
#include <array>

#include "address.hpp"
#include "cpu/register.hpp"
#include "tiles.hpp"
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

    /// LCD Control
    Register8 lcd_control = 0;

    /// LCD Status
    Register8 lcd_status = 0;

    Register8 SCX = 0;
    Register8 SCY = 0;

    Register8 WX = 0;
    Register8 WY = 0;

    // Current horizontal line
    // It can hold values from 0 to 153
    // 144-153 are the VBlank lines
    u8 LY = 0;

    u8 LY_compare = 0;

    // Tile data areas
    static constexpr Address TILE_DATA_AREA_0 = 0x8000; // { 0x8000, VRAM_START };
    static constexpr Address TILE_DATA_AREA_1 = 0x8800; // { 0x8800, VRAM_START };

    // Background & Window tile maps
    static constexpr Address TILE_MAP_AREA_0 = 0x9800; // { 0x9800, VRAM_START };
    static constexpr Address TILE_MAP_AREA_1 = 0x9C00; // { 0x9C00, VRAM_START };

    // u8 readVRAM(const Address& address) const {
    //     const u16 base = (address >= 0x8800 && address < 0x9800) ? 0x8800 : 0x8000;
    //     const u16 idx = address - base;
    //     return vram[idx];
    // }
    u8 readVRAM(const Address& address) const {
        const u16 idx = (address - 0x8000).value();
        return vram[idx];
    }
    void writeVRAM(const Address& address, const u8 value) {
        const u16 idx = (address - 0x8000).value();
        vram[idx] = value;
    }

    u8 readOAM(const Address& address) const {
        const u16 idx = (address - 0xFE00).value();
        if (idx < oam.size())
            return oam[idx];
        return 0xFF;
    }

    void writeOAM(const Address& address, const u8 value) {
        const u16 idx = (address - 0xFE00).value();
        if (idx < oam.size())
            oam[idx] = value;
    }

    bool display_enabled() const { return check_bit(lcd_control, 7); }

    /// `0 = 9800–9BFF`; `1 = 9C00–9FFF`
    bool window_tile_map_area() const { return check_bit(lcd_control, 6); }

    bool window_enabled() const { return check_bit(lcd_control, 5); }

    /// `0 = 8800–97FF`; `1 = 8000–8FFF`
    bool bg_window_tile_data_area() const { return check_bit(lcd_control, 4); }

    /// `0 = 9800–9BFF`; `1 = 9C00–9FFF`
    bool bg_tile_map_area() const { return check_bit(lcd_control, 3); }

    /// `0 = 8x8`; `1 = 8x16`
    bool obj_size() const { return check_bit(lcd_control, 2); }

    /// `0 = Off`; `1 = On`
    bool obj_enabled() const { return check_bit(lcd_control, 1); }

    /// `0 = Off`; `1 = On`
    bool bg_enabled() const { return check_bit(lcd_control, 0); }

    void draw_scanline(const int line);

    void step(const uint cycles);

    void oam_scan();
    void draw_pixels();
    void check_lyc();
    void vblank();
    void hblank();

    GBColors get_pixel(int x, int y) const;

private:
    GameBoy& gb;
    MMU& mmu;

    PPU_MODES mode = PPU_MODES::OAM_SCAN;

    uint cycle_count = 0;

    std::array<u8, 0x2000> vram {}; // 0x8000–0x9FFF (8 KiB)
    std::array<u8, 0x00A0> oam {}; // 0xFE00–0xFE9F (160 bytes)

    std::array<std::array<GBColors, LCD_WIDTH>, LCD_HEIGHT> framebuffer {};

    void draw_bg_line(const int line) {
        if (!bg_enabled())
            return;

        const Address tile_map_base = bg_tile_map_area()
            ? TILE_MAP_AREA_1
            : TILE_MAP_AREA_0;

        const Address tileDataBase = bg_window_tile_data_area()
            ? TILE_DATA_AREA_0 // 0x8000–8FFF
            : TILE_DATA_AREA_1; // 0x8800–97FF

        int bgY = (SCY + line) & 0xFF;
        int tileY = bgY / 8;
        int fineY = bgY % 8;

        TileSet tiles;
        tiles.load(mmu, tileDataBase);

        TileMap tilemap;
        tilemap.load(mmu, tile_map_base);

        for (int x = 0; x < LCD_WIDTH; ++x) {
            int bgX = (SCX + x) & 0xFF;
            int tileX = bgX / 8;
            int fineX = bgX % 8;

            u8 tileId = tilemap.get_tile_id(tileX, tileY);
            if (!bg_window_tile_data_area())
                tileId = static_cast<s8>(tileId) + 128;

            const Tile& tile = tiles.get(tileId);
            framebuffer[line][x] = tile.pixel(fineX, fineY);
        }
    }

    void draw_window_line(const int line) {
        if (!window_enabled() || line < WY)
            return;

        const Address tile_map_base = window_tile_map_area()
            ? TILE_MAP_AREA_1
            : TILE_MAP_AREA_0;

        const Address tile_data_base = bg_window_tile_data_area()
            ? TILE_DATA_AREA_0
            : TILE_DATA_AREA_1;

        int winLine = line - WY;
        int tileY = winLine / 8;
        int fineY = winLine % 8;

        TileSet tiles;
        tiles.load(mmu, tile_data_base);

        TileMap tilemap;
        tilemap.load(mmu, tile_map_base);

        for (int x = WX - 7; x < LCD_WIDTH; ++x) {
            if (x < 0)
                continue;

            int winX = x - (WX - 7);
            int tileX = winX / 8;
            int fineX = winX % 8;

            u8 tileId = tilemap.get_tile_id(tileX, tileY);
            if (!bg_window_tile_data_area())
                tileId = static_cast<s8>(tileId) + 128;

            const Tile& tile = tiles.get(tileId);
            framebuffer[line][x] = tile.pixel(fineX, fineY);
        }
    }

    void draw_sprites(const int line);

    void requestVBlankInterrupt();
};
