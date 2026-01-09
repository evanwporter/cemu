Background is 256x256 pixels
32x32 tiles
Each tile is 8x8 pixels

Only 160x144 pixels are displayed.
SCX and SCY select which portion of the background to display

The window is for text boxes and stuff.
WX and WY set where the window starts. Everything below and to the right of this
is part of the window.

Tile Data is stored between $8000-$97FF
The area stores 384 tiles.
Each tile takes 16 bytes.
Each line consists of 2 bytes
There are 4 possible colors

There are three blocks of 128 tiles each

- $8000–87FF
- $8800–8FFF
- $9000–97FF

8 pixels fit into 2 bytes of data
There are 8 pixels in a row in a tile.

Tile IDs for:

|                   | Block 0 ($8000–$87FF) | Block 1 ($8800–$8FFF) | Block 2 ($9000–$97FF) |
| ----------------- | --------------------- | --------------------- | --------------------- |
| Objects           | 0–127                 | 128–255               | —                     |
| BG/Win (LCDC.4=1) | 0–127                 | 128–255               | —                     |
| BG/Win (LCDC.4=0) | -                     | 128–255               | 0–127                 |

The tile map appears at $9800-$9BFF and $9C00-$9FFF (1024 bytes)
Either map can be used to display the background or the window
The tile map is 32x32

1 byte corresponds to the index of a tile.

`LCDC.3 == 0`: The BG uses tilemap $9800
`LCDC.3 == 1`: The BG uses tilemap $9C00

`LCDC.6 == 0`: The Window uses tilemap $9800
`LCDC.6 == 1`: The Window uses tilemap $9C00

We have a set of screen pixels
`x_screen` and `y_screen`, where these are the (x, y) coordinates on the 160x144 screen.

```
bg_x = (SCX + x_screen) % 256
bg_y = (SCY + y_screen) % 256
```

`bg_x` and `bg_y` are the absolute background coordinate on the 256x256 map.

Each tile is 8x8, so divide by 8 to find which tile ($0–31$) you’re in:

```
tile_x = bg_x >> 3 (tile 0-31)
tile_y = bg_y >> 3 (tile 0-31)
```

The tile map is stored row major so we can find the relative starting address of the tile map

```
tile_index = tile_y * 32 + tile_x;
```

If LCDC bit 3 selects the base tilemap:

```
tilemap_base = (regs.LCDC[3]) ? 16'h9C00 : 16'h9800;
tilemap_addr = tilemap_base + tile_index;
```

We can find the tile set offset. Which is just the row # and col # within the tile.

```
tile_y_offset = bg_y & 7   // which row inside the tile
tile_x_offset = bg_x & 7   // which column inside the tile
```

Now we get the exact tile number from the VRAM tilemap.

```
tile_index = VRAM[ tilemap_base + tile_y * 32 + tile_x ]
```

Tile row address is the exact location of the address of the tile row

### LCDC.4 == 1

```
tile_base = 0x8000 + (tile_index * 16)
row_offset = tile_y_offset * 2
tile_row_addr = tile_base + row_offset
```

### LCDC.4 == 0

```
tile_base = 0x9000 + (signed(tile_index) * 16)
row_offset = tile_y_offset * 2
tile_row_addr = tile_base + row_offset
```

Above two can be combined into the following expression:

```
tile_row_addr =
  (LCDC[4] ? 16'h8000 : 16'h9000)
  + (LCDC[4] ? tile_index : $signed(tile_index)) * 16
  + (tile_y_offset * 2)
```

This culminates in obtaining the pixel color.

```
low_byte  = VRAM[tile_row_addr];
high_byte = VRAM[tile_row_addr + 1];
bit_index = 7 - tile_x_offset;
color_id = { high_byte[bit_index], low_byte[bit_index] };
```
