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

    GBColors get_pixel(int x, int y) const;

private:
    GameBoy& gb;
    MMU& mmu;

    PPU_MODES mode = PPU_MODES::OAM_SCAN;

    uint cycle_count = 0;

    std::array<u8, 0x2000> vram {}; // 0x8000–0x9FFF (8 KiB)
    std::array<u8, 0x00A0> oam {}; // 0xFE00–0xFE9F (160 bytes)

    std::array<std::array<GBColors, LCD_WIDTH>, LCD_HEIGHT> framebuffer {};

    void draw_bg_line(const int line);
    void draw_window_line(const int line);
    void draw_sprites(const int line);

    void requestVBlankInterrupt();

    void oam_scan();
    void draw_pixels();
    void vblank();
    void hblank();
};
