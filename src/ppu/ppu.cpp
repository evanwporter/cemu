#include "ppu/ppu.hpp"
#include "defines.hpp"
#include "gameboy.hpp"
#include "mmu/mmu.hpp"

PPU::PPU(GameBoy& gb) :
    gb(gb), mmu(*gb.mmu) { }

void PPU::requestVBlankInterrupt() {
    constexpr u8 VBLANK_BIT = 1 << 0;
    u8 ifReg = mmu.read(0xFF0F);
    mmu.write(0xFF0F, ifReg | VBLANK_BIT);
}

GBColors PPU::get_pixel(int x, int y) const {
    return framebuffer[y][x];
}

void PPU::reset() {
    // Control registers
    lcd_control.set(0x91); // LCD on, BG on, window off, etc.

    SCX.set(0x00);
    SCY.set(0x00);
    WX.set(0x00);
    WY.set(0x00);

    std::fill(vram.begin(), vram.end(), 0);
    std::fill(oam.begin(), oam.end(), 0);

    // Internal counters
    LY = 0;
    cycle_count = 0;
    mode = PPU_MODES::OAM_SCAN;

    // Clear framebuffer
    for (auto& row : framebuffer)
        row.fill(GBColors::Color1);

    vram.fill(0);
}

void PPU::draw_sprites(const int line) {
    if (!obj_enabled())
        return;

    const bool tall_sprites = obj_size(); // true → 8x16, false → 8x8

    // Iterate through 40 sprite entries (each = 4 bytes)
    for (int sprite_n = 0; sprite_n < 40; ++sprite_n) {
        const Address oam_entry = OAM_START + sprite_n * 4;

        const u8 sprite_y = mmu.read(oam_entry);
        const u8 sprite_x = mmu.read(oam_entry + 1);
        const u8 tile_index = mmu.read(oam_entry + 2);
        const u8 attributes = mmu.read(oam_entry + 3);

        // Sprite vertical position correction: top-left corner = (x-8, y-16)
        const int top_y = sprite_y - 16;
        const int top_x = sprite_x - 8;

        // Skip sprites that don't intersect current scanline
        if (line < top_y || line >= top_y + (tall_sprites ? 16 : 8))
            continue;

        // Decode attribute bits
        const bool use_palette_1 = (attributes & (1 << 4));
        const bool flip_x = (attributes & (1 << 5));
        const bool flip_y = (attributes & (1 << 6));
        const bool behind_bg = (attributes & (1 << 7));

        // Compute which line within the sprite we’re drawing
        int line_in_sprite = line - top_y;
        if (flip_y)
            line_in_sprite = (tall_sprites ? 16 : 8) - 1 - line_in_sprite;

        // Each tile row = 2 bytes
        const Address tile_base = TILE_DATA_AREA_0; // Sprites always use unsigned indexing
        const u16 tile_offset = (tall_sprites ? (tile_index & 0xFE) : tile_index) * 16;
        const Address tile_line_addr = tile_base + tile_offset + line_in_sprite * 2;

        const u8 low = mmu.read(tile_line_addr);
        const u8 high = mmu.read(tile_line_addr + 1);

        for (int x = 0; x < 8; ++x) {
            int screen_x = top_x + (flip_x ? (7 - x) : x);
            if (screen_x < 0 || screen_x >= LCD_WIDTH)
                continue;

            const int bit = 7 - x;
            const u8 lo = (low >> bit) & 1;
            const u8 hi = (high >> bit) & 1;
            const u8 color_index = (hi << 1) | lo;

            if (color_index == 0)
                continue; // Transparent pixel

            // Background priority: skip if bg pixel nonzero and sprite behind bg
            if (behind_bg && framebuffer[line][screen_x] != GBColors::Color1)
                continue;

            framebuffer[line][screen_x] = static_cast<GBColors>(color_index);
        }
    }
}

void PPU::draw_scanline(const int line) {
    if (!display_enabled())
        return;

    printf("LCDC = %02X\n", lcd_control.get());

    draw_bg_line(line);
    draw_window_line(line);
    draw_sprites(line);
}

void PPU::step(const uint cycles) {
    cycle_count += cycles;

    switch (mode) {
    case PPU_MODES::OAM_SCAN:
        oam_scan();
        break;

    case PPU_MODES::DRAWING_PIXELS:
        draw_pixels();
        break;

    case PPU_MODES::HORIZONTAL_BLANK: // HBlank
        hblank();
        break;

    case PPU_MODES::VERTICAL_BLANK: // VBlank
        vblank();
        break;
    }
}

void PPU::oam_scan() {
    if (cycle_count >= 80) {
        cycle_count %= 80;

        // LCD Bit
        if (lcd_status.get_bit(5)) {
            gb.cpu->interrupt_flag.set_bit(1, true);
        }

        u8 LY = mmu.read(LCD_Y_COORD);
        u8 LY_compare = mmu.read(LY_COMPARE);

        const bool coincidence = (LY == LY_compare);
        lcd_status.set_bit(6, coincidence);

        if (coincidence && lcd_status.get_bit(2)) {
            // LYC=LY interrupt enable
            gb.cpu->interrupt_flag.set_bit(1, true);
        }

        mode = PPU_MODES::DRAWING_PIXELS;
    }
}

void PPU::draw_pixels() {
    if (cycle_count >= 172) {
        cycle_count -= 172;

        mode = PPU_MODES::HORIZONTAL_BLANK;

        // Draw current scanline
        draw_scanline(LY);
    }

    bool hblank_interrupt = check_bit(lcd_status.get(), 3);

    if (hblank_interrupt) {
        gb.cpu->interrupt_flag.set_bit(1, true);
    }
}

void PPU::hblank() {
    // HBlank = Mode 0
    if (cycle_count >= 204) {
        cycle_count %= 204;

        // --- STAT interrupt (Mode 0 enable bit 3) ---
        if (lcd_status.get_bit(3)) {
            gb.cpu->interrupt_flag.set_bit(1, true);
        }

        // --- Increment LY for next line ---
        LY++;

        // --- Update LY==LYC coincidence flag ---
        u8 LY_compare = mmu.read(LY_COMPARE);
        const bool coincidence = (LY == LY_compare);
        lcd_status.set_bit(6, coincidence);

        if (coincidence && lcd_status.get_bit(2)) {
            // LYC=LY interrupt enable
            gb.cpu->interrupt_flag.set_bit(1, true);
        }

        // --- Transition to next mode ---
        if (LY == 144) {
            mode = PPU_MODES::VERTICAL_BLANK;
            requestVBlankInterrupt();

            // --- STAT interrupt (Mode 1 enable bit 4) ---
            if (lcd_status.get_bit(4)) {
                gb.cpu->interrupt_flag.set_bit(1, true);
            }
        } else {
            mode = PPU_MODES::OAM_SCAN;
        }
    }
}

void PPU::vblank() {
    // VBlank = Mode 1
    if (cycle_count >= 456) {
        cycle_count %= 456;

        LY++;

        // --- Update LY==LYC coincidence flag ---
        u8 LY_compare = mmu.read(LY_COMPARE);
        const bool coincidence = (LY == LY_compare);
        lcd_status.set_bit(6, coincidence);

        if (coincidence && lcd_status.get_bit(2)) {
            gb.cpu->interrupt_flag.set_bit(1, true);
        }

        // --- Transition to next frame after line 153 ---
        if (LY > 153) {
            LY = 0;
            mode = PPU_MODES::OAM_SCAN;

            // --- STAT interrupt (Mode 2 enable bit 5) ---
            if (lcd_status.get_bit(5)) {
                gb.cpu->interrupt_flag.set_bit(1, true);
            }
        }
    }
}

// Optional helper (reusable in multiple modes)
void PPU::check_lyc() {
    u8 LY_compare = mmu.read(LY_COMPARE);
    const bool coincidence = (LY == LY_compare);
    lcd_status.set_bit(6, coincidence);

    if (coincidence && lcd_status.get_bit(2)) {
        gb.cpu->interrupt_flag.set_bit(1, true);
    }
}