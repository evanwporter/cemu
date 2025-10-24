#pragma once
#include "address.hpp"
#include "mmu/mmu.hpp"
#include "types.hpp"

#include <array>

constexpr uint TILE_HEIGHT_PX = 8;
constexpr uint TILE_WIDTH_PX = 8;

/**
 * @brief A single 8x8 tile of pixel data.
 *
 * One pixel is 2 bits. This allows for each pixel to represent one of four
 * colors. Each tile is stored in 16 bytes, with each pair of bytes representing
 * one row of 8 pixels.
 */
class Tile {
public:
    GBColors pixel(int x, int y) const;

    void load(const MMU& mmu, const Address& base_addr);

private:
    std::array<std::array<GBColors, TILE_WIDTH_PX>, TILE_HEIGHT_PX> pixels {};
};

/**
 * @brief The Tile Set.
 *
 * Data is stored from 0x8000–0x97FF. The tile set contains 384 tiles,
 * each tile is 16 bytes in size.
 */
class TileSet {
public:
    void load(const MMU& mmu, const Address& base_addr) {
        for (int i = 0; i < TILE_COUNT; ++i) {
            const Address tile_addr = base_addr + i * 16;
            tiles[i].load(mmu, tile_addr);
        }
    }

    const Tile& get(int index) const {
        return tiles[index % TILE_COUNT];
    }

private:
    static constexpr uint TILE_COUNT = 384;
    std::array<Tile, TILE_COUNT> tiles {};
};

/**
 * @brief The Tile Map.
 *
 * The tile map is a 32x32 grid of tile indices. So in total it would
 * be 256x256 pixels. Each index corresponds to a tile in the tile set.
 * The index is a single byte.
 */
class TileMap {
public:
    void load(const MMU& mmu, const Address& base_addr);

    [[nodiscard]] u8 get_tile_id(int x, int y) const;

private:
    static constexpr uint WIDTH = 32;
    static constexpr uint HEIGHT = 32;
    std::array<u8, WIDTH * HEIGHT> entries {};
};