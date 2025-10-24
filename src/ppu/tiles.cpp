#include "tiles.hpp"
#include "types.hpp"

GBColors Tile::pixel(int x, int y) const {
    return pixels[y][x];
}