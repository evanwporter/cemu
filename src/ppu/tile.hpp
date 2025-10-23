#pragma once
#include "address.hpp"
#include "mmu/mmu.hpp"
#include "types.hpp"

#include <array>

const uint TILE_HEIGHT_PX = 8;
const uint TILE_WIDTH_PX = 8;

class Tile {
public:
    GBColors pixel(uint x, uint y) const;

    void load(const MMU& mmu, Address& baseAddr) {
        for (uint y = 0; y < TILE_HEIGHT_PX; ++y) {
            u8 low = mmu.read(baseAddr + y * 2);
            u8 high = mmu.read(baseAddr + y * 2 + 1);
            for (uint x = 0; x < TILE_WIDTH_PX; ++x) {
                u8 loBit = (low >> (7 - x)) & 1;
                u8 hiBit = (high >> (7 - x)) & 1;
                pixels[y][x] = static_cast<GBColors>((hiBit << 1) | loBit);
            }
        }
    }

private:
    std::array<std::array<GBColors, TILE_WIDTH_PX>, TILE_HEIGHT_PX> pixels {};
};

// Data is from 0x8000–0x97FF
class TileSet {
public:
    static constexpr int TILE_COUNT = 384;
    std::array<Tile, TILE_COUNT> tiles {};

    void load(const MMU& mmu, const Address& base) {
        for (int i = 0; i < TILE_COUNT; ++i) {
            Address tileAddr = base + i * 16;
            tiles[i].load(mmu, tileAddr);
        }
    }

    const Tile& get(int index) const {
        return tiles[index % TILE_COUNT];
    }
};

class TileMap {
public:
    static constexpr int WIDTH = 32;
    static constexpr int HEIGHT = 32;
    std::array<u8, WIDTH * HEIGHT> entries {};

    void load(const MMU& mmu, const Address& baseAddr) {
        for (int i = 0; i < WIDTH * HEIGHT; ++i)
            entries[i] = mmu.read(baseAddr + i);
    }

    [[nodiscard]] u8 getTileId(int x, int y) const {
        return entries[(y % HEIGHT) * WIDTH + (x % WIDTH)];
    }
};