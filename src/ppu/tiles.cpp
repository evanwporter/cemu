#include "tiles.hpp"
#include "types.hpp"

GBColors Tile::pixel(int x, int y) const {
    return pixels[y][x];
}

void Tile::load(const MMU& mmu, const Address& base_addr) {
    // Loop through one horizontal row of pixels (8 pixels)
    for (u16 y = 0; y < TILE_HEIGHT_PX; ++y) {

        // Each row is represented by two bytes

        /// Contains bit 0 of each pixel in the row
        u8 low = mmu.read(base_addr + y * 2);

        /// Contains bit 1 of each pixel in the row
        u8 high = mmu.read(base_addr + y * 2 + 1);

        for (u16 x = 0; x < TILE_WIDTH_PX; ++x) {
            u8 loBit = (low >> (7 - x)) & 1;
            u8 hiBit = (high >> (7 - x)) & 1;
            pixels[y][x] = static_cast<GBColors>((hiBit << 1) | loBit);
        }
    }
}

void TileMap::load(const MMU& mmu, const Address& base_addr) {
    for (int i = 0; i < WIDTH * HEIGHT; ++i) {
        entries[i] = mmu.read(base_addr + i);
    }
}

u8 TileMap::get_tile_id(int x, int y) const {
    return entries[(y % HEIGHT) * WIDTH + (x % WIDTH)];
}