package ppu_util_pkg;
  localparam logic [7:0] GB_SCREEN_HEIGHT = 144;
  localparam logic [7:0] GB_SCREEN_WIDTH = 160;

  localparam logic [8:0] DOTS_PER_LINE = 456;
  localparam logic [7:0] LINES_PER_FRAME = 154;

  // Mode durations in clock cycles
  localparam logic [8:0] MODE2_LEN = 80;
  localparam logic [8:0] MODE3_LEN = 172;
  localparam logic [8:0] MODE0_LEN = 204;  // 376 - 172;
endpackage : ppu_util_pkg
