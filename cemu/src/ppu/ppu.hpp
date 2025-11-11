#pragma once

#include "framebuffer.hpp"

#include "cpu/register.hpp"
#include "definitions.hpp"
#include "mmu/mmu.hpp"
#include "options.hpp"

#include <functional>
#include <vector>

class Gameboy;

using vblank_callback_t = std::function<void(const FrameBuffer&)>;

enum class VideoMode {
    ACCESS_OAM,
    ACCESS_VRAM,
    HBLANK,
    VBLANK,
};

struct TileInfo {
    u8 line;
    std::vector<u8> pixels;
};

class PPU {
public:
    PPU(Gameboy& inGb, Options& inOptions);

    void tick(Cycles cycles);
    void register_vblank_callback(const vblank_callback_t& _vblank_callback);

    u8 read(const Address& address);
    void write(const Address& address, u8 byte);

    u8 control_byte;

    Register8 lcd_control;
    Register8 lcd_status;

    Register8 scroll_y;
    Register8 scroll_x;

    // LCDC Y-coordinate
    Register8 line; // Line y-position: register LY
    Register8 ly_compare;

    Register8 window_y;
    Register8 window_x; // Note: x - 7

    Register8 bg_palette;
    Register8 sprite_palette_0; // OBP0
    Register8 sprite_palette_1; // OBP1

    // TODO: LCD Color Palettes (CGB)
    // TODO: LCD VRAM Bank (CGB)

    Register8 dma_transfer; // DMA

    bool debug_disable_background = false;
    bool debug_disable_sprites = false;
    bool debug_disable_window = false;

private:
    void write_scanline(u8 current_line);
    void write_sprites();
    void draw();
    void draw_bg_line(uint current_line);
    void draw_window_line(uint current_line);
    void draw_sprite(uint sprite_n);
    static GBColor get_pixel_from_line(u8 byte1, u8 byte2, u8 pixel_index);

    static bool is_on_screen(u8 x, u8 y);
    static bool is_on_screen_x(u8 x);
    static bool is_on_screen_y(u8 y);

    bool display_enabled() const;
    bool window_tile_map() const;
    bool window_enabled() const;
    bool bg_window_tile_data() const;
    bool bg_tile_map_display() const;
    bool sprite_size() const;
    bool sprites_enabled() const;
    bool bg_enabled() const;

    TileInfo get_tile_info(Address tile_set_location, u8 tile_id, u8 tile_line) const;

    static Color get_real_color(u8 pixel_value);
    static Palette load_palette(Register8& palette_register);
    static Color get_color_from_palette(GBColor color, const Palette& palette);

    Gameboy& gb;

    FrameBuffer buffer;
    FrameBuffer background_map;

    std::vector<u8> video_ram;

    VideoMode current_mode = VideoMode::ACCESS_OAM;
    uint cycle_counter = 0;

    vblank_callback_t vblank_callback;
};

const uint CLOCKS_PER_HBLANK = 204; // Mode 0
const uint CLOCKS_PER_SCANLINE_OAM = 80; // Mode 2
const uint CLOCKS_PER_SCANLINE_VRAM = 172; // Mode 3
const uint CLOCKS_PER_SCANLINE = (CLOCKS_PER_SCANLINE_OAM + CLOCKS_PER_SCANLINE_VRAM + CLOCKS_PER_HBLANK);

const uint CLOCKS_PER_VBLANK = 4560; // Mode 1
const uint SCANLINES_PER_FRAME = 144;
const uint CLOCKS_PER_FRAME = (CLOCKS_PER_SCANLINE * SCANLINES_PER_FRAME) + CLOCKS_PER_VBLANK;
