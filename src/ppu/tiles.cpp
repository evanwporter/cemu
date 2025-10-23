#include "tile.hpp"
#include "types.hpp"

GBColors Tile::pixel(uint x, uint y) const {
    return pixels[y][x];
}