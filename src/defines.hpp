#pragma once
#include "address.hpp"

constexpr Address INTERRUPT_FLAG = 0xFF0F;
constexpr Address INTERRUPT_ENABLE = 0xFFFF;

constexpr Address LCD_CONTROL = 0xFF40;

namespace LCDC {
    constexpr u8 LCD_ENABLE = 1 << 7;
    constexpr u8 WINDOW_MAP_AREA = 1 << 6;
    constexpr u8 WINDOW_ENABLE = 1 << 5;
    constexpr u8 TILE_DATA_AREA = 1 << 4;
    constexpr u8 BG_MAP_AREA = 1 << 3;
    constexpr u8 OBJ_SIZE = 1 << 2;
    constexpr u8 OBJ_ENABLE = 1 << 1;
    constexpr u8 BG_ENABLE = 1 << 0;
}

constexpr Address LCD_Y_COORD = 0xFF44;

constexpr Address LCD_STATUS = 0xFF41;

constexpr Address LY_COMPARE = 0xFF45;

constexpr Address SCROLL_Y = 0xFF42;
constexpr Address SCROLL_X = 0xFF43;

constexpr Address WINDOW_Y = 0xFF4A;
constexpr Address WINDOW_X = 0xFF4B;