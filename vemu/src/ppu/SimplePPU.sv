module SimplePPU (
    input logic clk,
    input logic reset,

    Bus_if.Peripheral_side bus,
    Interrupt_if.PPU_side  IF_bus
);

  logic [7:0] VRAM[0:8191];
  logic [7:0] OAM[160];
  logic [7:0] framebuffer[23040];

  logic [8:0] cycle;  // 0..455
  logic [7:0] ly;  // 0..153
  logic [1:0] mode;  // 0,1,2,3

  typedef enum logic [1:0] {
    M0 = 0,
    M1 = 1,
    M2 = 2,
    M3 = 3
  } ppu_mode_t;

  // registers
  logic [7:0] LCDC;  // FF40
  logic [7:0] SCY;  // FF42
  logic [7:0] SCX;  // FF43
  logic [7:0] LYC;  // FF45
  logic [7:0] BGP;  // FF47

  // ==========================================
  // MMU reads/writes (no blocking in simple mode)
  // ==========================================
  always_ff @(posedge clk) begin
    if (bus.write_en) begin
      if (bus.addr >= 16'h8000 && bus.addr <= 16'h9FFF) VRAM[bus.addr-16'h8000] <= bus.wdata;
      else if (bus.addr >= 16'hFE00 && bus.addr <= 16'hFE9F) OAM[bus.addr-16'hFE00] <= bus.wdata;
      else if (bus.addr == 16'hFF40) LCDC <= bus.wdata;
      else if (bus.addr == 16'hFF42) SCY <= bus.wdata;
      else if (bus.addr == 16'hFF43) SCX <= bus.wdata;
      else if (bus.addr == 16'hFF45) LYC <= bus.wdata;
      else if (bus.addr == 16'hFF47) BGP <= bus.wdata;
    end
  end

  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en) begin
      if (bus.addr >= 16'h8000 && bus.addr <= 16'h9FFF) bus.rdata = VRAM[bus.addr-16'h8000];
      else if (bus.addr >= 16'hFE00 && bus.addr <= 16'hFE9F) bus.rdata = OAM[bus.addr-16'hFE00];
      else if (bus.addr == 16'hFF40) bus.rdata = LCDC;
      else if (bus.addr == 16'hFF42) bus.rdata = SCY;
      else if (bus.addr == 16'hFF43) bus.rdata = SCX;
      else if (bus.addr == 16'hFF44) bus.rdata = ly;
      else if (bus.addr == 16'hFF45) bus.rdata = LYC;
      else if (bus.addr == 16'hFF47) bus.rdata = BGP;
    end
  end

  // ==========================================
  // Rendering Function — Software style in RTL
  // (just like the 500-line emulator)
  // ==========================================
  function logic [1:0] get_pixel(input int x, input int y);
    int scx = (x + SCX) % 256;
    int scy = (y + SCY) % 256;

    int tile_x = scx >> 3;
    int tile_y = scy >> 3;

    int tile_index = tile_y * 32 + tile_x;

    int tile_id = VRAM[tile_index];

    int line = scy & 7;

    logic [7:0] lo = VRAM[(tile_id*16)+line*2];
    logic [7:0] hi = VRAM[(tile_id*16)+line*2+1];

    int pixel_bit = 7 - (scx & 7);

    return {hi[pixel_bit], lo[pixel_bit]};  // 2-bit color
  endfunction

  // ==========================================
  // Timing: 456 cycles per line, 154 lines/frame
  // ==========================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      cycle <= 0;
      ly <= 0;
      mode <= M2;
    end else begin

      cycle <= cycle + 1;

      case (mode)
        M2: if (cycle == 80) mode <= M3;
        M3: if (cycle == 252) mode <= M0;  // skip real 172, we jump straight to render
        M0:
        if (cycle == 455) begin
          cycle <= 0;
          ly <= ly + 1;

          if (ly == 143) begin
            mode <= M1;
            IF_bus.vblank_req <= 1;
          end else mode <= M2;
        end
        M1:
        if (cycle == 455) begin
          cycle <= 0;
          ly <= ly + 1;

          if (ly == 153) begin
            ly   <= 0;
            mode <= M2;
          end
        end
      endcase

      // Render visible scanlines
      if (mode == M3 && ly < 144) begin
        for (int x = 0; x < 160; x++) begin
          logic [1:0] col = get_pixel(x, ly);
          framebuffer[ly*160+x] <= col;
        end
      end

    end
  end

endmodule
