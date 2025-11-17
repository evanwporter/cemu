`include "ppu/types.sv"
`include "ppu/Fetcher.sv"

module fetcher_top (
    input logic clk,
    input logic reset,

    input logic dot_en,
    input ppu_regs_t regs  /*verilator public*/,
    input logic [8:0] x_clock,
    input logic window_active,
    input logic [7:0] y_screen,

    // VRAM memory is directly inside the top
    output logic [15:0] vram_addr,
    input  logic [ 7:0] vram_rdata,
    output logic        vram_read_req,

    // FIFO signals
    input logic bg_fifo_empty,
    input logic bg_fifo_full,
    output logic bg_push_en,
    output ppu_pixel_t bg_push_px,

    output logic [2:0] f_state_dbg
);

  Fetcher dut (
      .clk(clk),
      .reset(reset),
      .dot_en(dot_en),
      .regs(regs),
      .x_clock(x_clock),
      .window_active(window_active),
      .y_screen(y_screen),

      .vram_read_req(vram_read_req),
      .vram_addr(vram_addr),
      .vram_rdata(vram_rdata),

      .bg_fifo_full(bg_fifo_full),
      .bg_fifo_empty(bg_fifo_empty),
      .bg_push_en(bg_push_en),
      .bg_push_px(bg_push_px),

      .pushed_count(),

      .flush(1'b0),
      .f_state_dbg(f_state_dbg)
  );

endmodule
