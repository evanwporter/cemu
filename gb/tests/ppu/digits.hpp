#pragma once

#include <cstdint>

#include <verilated.h>

#include "types.hpp"

constexpr uint8_t digit_glyphs[16][5] = {
    // 0
    {
        0b1111,
        0b1001,
        0b1001,
        0b1001,
        0b1111 },

    // 1
    {
        0b0010,
        0b0110,
        0b0010,
        0b0010,
        0b0111 },

    // 2
    {
        0b1111,
        0b0001,
        0b1111,
        0b1000,
        0b1111 },

    // 3
    {
        0b1111,
        0b0001,
        0b1111,
        0b0001,
        0b1111 },

    // 4
    {
        0b1001,
        0b1001,
        0b1111,
        0b0001,
        0b0001 },

    // 5
    {
        0b1111,
        0b1000,
        0b1111,
        0b0001,
        0b1111 },

    // 6
    {
        0b1111,
        0b1000,
        0b1111,
        0b1001,
        0b1111 },

    // 7
    {
        0b1111,
        0b0001,
        0b0010,
        0b0100,
        0b0100 },

    // 8
    {
        0b1111,
        0b1001,
        0b1111,
        0b1001,
        0b1111 },

    // 9
    {
        0b1111,
        0b1001,
        0b1111,
        0b0001,
        0b1111 },

    // A–F (10–15)
    { 0b0110, 0b1001, 0b1111, 0b1001, 0b1001 }, // A
    { 0b1110, 0b1001, 0b1110, 0b1001, 0b1110 }, // B
    { 0b0111, 0b1000, 0b1000, 0b1000, 0b0111 }, // C
    { 0b1110, 0b1001, 0b1001, 0b1001, 0b1110 }, // D
    { 0b1111, 0b1000, 0b1110, 0b1000, 0b1111 }, // E
    { 0b1111, 0b1000, 0b1110, 0b1000, 0b1000 }, // F
};

inline void write_numbered_tile(
    vram_t& vram,
    int tile_index,
    int number // 0–15
) {
    constexpr int TILE_BASE = 0x0000;
    const auto& glyph = digit_glyphs[number & 0xF];

    for (int y = 0; y < 8; ++y) {
        uint8_t lsb = 0;
        uint8_t msb = 0;

        for (int x = 0; x < 8; ++x) {
            uint8_t color = 0;

            // Border
            if (x == 0 || x == 7 || y == 0 || y == 7) {
                color = 1;
            }
            // Digit glyph (centered at 2,1)
            else if (x >= 2 && x < 6 && y >= 1 && y < 6) {
                int gx = x - 2;
                int gy = y - 1;
                if (glyph[gy] & (1 << (3 - gx)))
                    color = 2;
            }

            lsb |= (color & 1) << (7 - x);
            msb |= ((color >> 1) & 1) << (7 - x);
        }

        vram[TILE_BASE + tile_index * 16 + y * 2 + 0] = lsb;
        vram[TILE_BASE + tile_index * 16 + y * 2 + 1] = msb;
    }
}