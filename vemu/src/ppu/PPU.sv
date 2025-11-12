`ifndef PPU_SV
`define PPU_SV 

`include "ppu/types.sv"
`include "ppu/FIFO.sv"
`include "ppu/Fetcher.sv"
`include "ppu/Framebuffer.sv"

`include "mmu/interface.sv"
`include "mmu/addresses.sv"

module PPU (
    input logic clk,
    input logic reset,

    Bus_if.Peripheral_side bus
);

  logic [8:0] cycle_counter;
  logic [7:0] line;

  ppu_regs_t regs;

  localparam int CYCLES_PER_LINE = 456;
  localparam int LINES_PER_FRAME = 154;

  // Mode durations in clock cycles
  localparam int MODE2_LEN = 80;
  localparam int MODE3_LEN = 172;
  localparam int MODE0_LEN = 204;

  logic dot_en;
  assign dot_en = (mode == PPU_MODE_3);

  logic [7:0] VRAM[VRAM_len];
  logic [7:0] OAM[OAM_len];

  // Window active check
  logic window_active;
  assign window_active = (regs.LCDC[5] && (line >= regs.WY) &&
                         (/* current X >= WX - 7 */ 1'b1)); // TODO: implement per-dot window condition


  // ======================================================
  // Background FIFO
  // ======================================================
  logic bg_push_en;
  logic bg_fifo_full, bg_fifo_empty;
  logic             bg_pop_en;
  logic       [4:0] bg_fifo_count;
  ppu_pixel_t       bg_push_px;
  ppu_pixel_t       bg_top_px;

  FIFO bg_fifo (
      .clk    (clk),
      .reset  (reset),
      .push_en(bg_push_en),
      .push_px(bg_push_px),
      .full   (bg_fifo_full),
      .pop_en (bg_pop_en),
      .pop_px (bg_top_px),
      .empty  (bg_fifo_empty),
      .count  (bg_fifo_count),
      .flush  (1'b0)
  );


  // ======================================================
  // Fetcher (VRAM -> FIFO)
  // ======================================================
  logic        vram_read_req;
  logic [15:0] vram_addr;
  logic [ 7:0] vram_rdata;

  Fetcher fetcher (
      .clk          (clk),
      .reset        (reset),
      .dot_en       (dot_en),
      .regs         (regs),
      .x_clock      (cycle_counter),
      .window_active(window_active),
      .y_screen     (line),
      // VRAM bus
      .vram_read_req(vram_read_req),
      .vram_addr    (vram_addr),
      .vram_rdata   (vram_rdata),
      // FIFO interface
      .bg_fifo_full (bg_fifo_full),
      .bg_fifo_empty(bg_fifo_empty),
      .bg_push_en   (bg_push_en),
      .bg_push_px   (bg_push_px),
      .pushed_count (  /* unused for now */),
      // control
      .flush        (1'b0),
      .f_state_dbg  ()
  );

  // Fetcher reads from the VRAM immeditely.
  // TODO: block it if needed
  wire [7:0] vram_data_for_fetcher = vram_read_req ? vram[vram_addr-16'h8000] : '0;

  assign vram_rdata = vram_data_for_fetcher;

  // ======================================================
  // Framebuffer (FIFO -> pixel storage)
  // ======================================================
  logic fifo_pop_en;
  logic frame_done_internal;

  Framebuffer framebuffer (
      .clk        (clk),
      .reset      (reset),
      .dot_en     (dot_en),
      .fifo_empty (bg_fifo_empty),
      .fifo_pop_en(bg_pop_en),
      .fifo_top_px(bg_top_px),
      .flush      (1'b0),
      .frame_done (frame_done_internal)
  );

  assign frame_done = frame_done_internal;

  // ======================================================

  // MMU Listeners for VRAM, OAM, Registers
  always_ff @(posedge clk) begin
    if (bus.write_en) begin
      unique case (1'b1)

        // VRAM writes (blocked in Mode 3)
        (bus.addr inside {[VRAM_start : VRAM_end]}): begin
          if (mode != PPU_MODE_3) begin
            vram[bus.addr-16'h8000] <= bus.wdata;
          end
        end

        // OAM writes (blocked in Mode 2 & 3)
        (bus.addr inside {[OAM_start : OAM_end]}): begin
          if (!(mode == PPU_MODE_2 || mode == PPU_MODE_3)) begin
            oam[bus.addr-16'hFE00] <= bus.wdata;
          end
        end

        // PPU register writes
        // TODO: check whether this ever needs to be blocked
        (bus.addr inside {[PPU_regs_start : PPU_regs_end]}): begin
          unique case (bus.addr)
            16'hFF40: regs.LCDC <= bus.wdata;
            16'hFF42: regs.SCY <= bus.wdata;
            16'hFF43: regs.SCX <= bus.wdata;
            16'hFF44: begin
              $display("[%0t] Warning attempting to write 0x%h to LY register", $time, bus.wdata);
            end
            16'hFF45: regs.LYC <= bus.wdata;
            16'hFF47: regs.BGP <= bus.wdata;
            default:  ;
          endcase
        end

        default:  /* ignore */;
      endcase
    end
  end

  // ---------------- Read Mux -------------------
  always_comb begin
    bus.rdata = 8'hFF;  // open bus unless selected & allowed

    if (bus.read_en) begin
      unique case (bus.addr) inside

        // VRAM reads (blocked in Mode 3)
        [VRAM_start : VRAM_end]: begin
          bus.rdata = (mode == PPU_MODE_3) ? 8'hFF : vram[bus.addr-VRAM_start];
        end

        // OAM reads (blocked in Mode 2 & 3)
        [OAM_start : OAM_end]: begin
          bus.rdata = (mode == PPU_MODE_2 || mode == PPU_MODE_3) ? 8'hFF : oam[bus.addr-OAM_start];
        end

        // PPU register reads
        [PPU_regs_start : PPU_regs_end]: begin
          unique case (bus.addr)
            16'hFF40: bus.rdata = regs.LCDC;
            16'hFF42: bus.rdata = regs.SCY;
            16'hFF43: bus.rdata = regs.SCX;
            16'hFF44: bus.rdata = regs.LY;
            16'hFF45: bus.rdata = regs.LYC;
            // TODO: DMA transfer
            16'hFF47: bus.rdata = regs.BGP;
            default:  bus.rdata = 8'hFF;
          endcase
        end
      endcase
    end
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      mode          <= PPU_MODE_2;
      line          <= 8'd0;
      cycle_counter <= 0;
      frame_done    <= 1'b0;
    end else begin
      frame_done <= 1'b0;
      cycle_counter <= cycle_counter + 1;

      // Mode switching logic
      unique case (mode)
        PPU_MODE_2: if (cycle_counter == MODE2_LEN) mode <= PPU_MODE_3;
        PPU_MODE_3: if (cycle_counter == MODE2_LEN + MODE3_LEN) mode <= PPU_MODE_0;
        PPU_MODE_0: begin
          if (cycle_counter == CYCLES_PER_LINE - 1) begin
            cycle_counter <= 0;
            line <= line + 1;
            if (line == 8'd143) mode <= PPU_MODE_1;
            else mode <= PPU_MODE_2;
          end
        end
        PPU_MODE_1: begin
          if (cycle_counter == CYCLES_PER_LINE - 1) begin
            cycle_counter <= 0;
            line <= line + 1;
            if (line == LINES_PER_FRAME - 1) begin
              line <= 8'd0;
              mode <= PPU_MODE_2;
              frame_done <= 1'b1;
            end
          end
        end
      endcase
    end
  end

endmodule

`endif  // PPU_SV
