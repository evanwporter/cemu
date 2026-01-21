import ppu_types_pkg::*;
import ppu_util_pkg::*;
import ppu_fetcher_types_pkg::*;

module ObjFetcher (
    input logic clk,
    input logic reset,

    Fetcher_if.Fetcher_side bus,

    RenderingControl_if.Obj_Fetcher_side control_bus,

    FIFO_if.Fetcher_side fifo_bus,

    input object_t sprite_buf[10]
);

  logic [9:0] sprite_hit;
  logic [9:0] sprite_valid;

  enum logic [2:0] {
    FETCHER_IDLE,
    FETCHER_GET_LOW,
    FETCHER_GET_HIGH,
    FETCHER_PUSH
  } state;

  dot_phase_t dot_phase;

  // Next pixel being evaluated
  wire [7:0] next_pixel_x = control_bus.pixel_x + 8'd1;

  always_comb begin
    for (int i = 0; i < 10; i++) begin
      sprite_hit[i] =
      sprite_valid[i] &&
      (next_pixel_x >= sprite_buf[i].x_pos - 8) &&
      (next_pixel_x <  sprite_buf[i].x_pos);
    end
  end

  wire any_sprite_hit = |sprite_hit;

  logic [3:0] first_sprite_idx;

  always_comb begin
    first_sprite_idx = 4'd0;
    for (int j = 0; j < 10; j++) begin
      if (sprite_hit[j]) begin
        first_sprite_idx = j[3:0];
        break;
      end
    end
  end

  object_t current_sprite;

  logic [3:0] sprite_row;
  logic [15:0] tilemap_addr;

  wire xflip = current_sprite.attr[5];
  wire yflip = current_sprite.attr[6];

  always_comb begin
    logic [3:0] raw_row;
    raw_row = 4'(bus.regs.LY + 8'd16 - current_sprite.y_pos);

    sprite_row = yflip ? (4'd7 - raw_row) : raw_row;

    tilemap_addr = 16'h8000 + {4'd0, current_sprite.tile_idx, 4'b0000} + {11'd0, sprite_row, 1'b0};
  end

  logic [7:0] tile_low_byte, tile_high_byte;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      control_bus.stall <= 1'b0;
      sprite_valid <= sprite_hit;
      state <= FETCHER_IDLE;
      dot_phase <= DOT_PHASE_0;
    end else begin

      if (bus.mode == PPU_MODE_2 && bus.dot_counter == MODE2_LEN - 1) begin
        for (int i = 0; i < 10; i++) begin
          sprite_valid[i] <= sprite_buf[i].valid;
        end
        control_bus.stall <= 1'b0;
        state <= FETCHER_IDLE;
        dot_phase <= DOT_PHASE_0;
      end

      if (bus.mode == PPU_MODE_3) begin

        unique case (state)
          FETCHER_IDLE: begin
            if (any_sprite_hit) begin
              control_bus.stall <= 1'b1;
              current_sprite <= sprite_buf[first_sprite_idx];
              sprite_valid[first_sprite_idx] <= 1'b0;

              state <= FETCHER_GET_LOW;
              dot_phase <= DOT_PHASE_0;

              // $display("[OBJ] HIT idx=%0d x=%0d y=%0d tile=%0d LY=%0d next_x=%0d", first_sprite_idx,
              //          sprite_buf[first_sprite_idx].x_pos, sprite_buf[first_sprite_idx].y_pos,
              //          sprite_buf[first_sprite_idx].tile_idx, bus.regs.LY, next_pixel_x);
            end
          end

          FETCHER_GET_LOW: begin
            unique case (dot_phase)
              DOT_PHASE_0: begin
                bus.addr <= tilemap_addr;
                bus.read_req <= 1'b1;

                dot_phase <= DOT_PHASE_1;

                // $display("[OBJ] READ LOW addr=%04x tile=%0d row=%0d", tilemap_addr,
                //          current_sprite.tile_idx, sprite_row);
              end

              DOT_PHASE_1: begin
                // Fetch low byte of sprite data
                tile_low_byte <= bus.rdata;
                bus.read_req <= 1'b0;

                state <= FETCHER_GET_HIGH;
                dot_phase <= DOT_PHASE_0;

                // $display("[OBJ] LOW BYTE rdata=%02x from addr=%04x", bus.rdata, bus.addr);
              end
            endcase
          end

          FETCHER_GET_HIGH: begin
            unique case (dot_phase)
              DOT_PHASE_0: begin
                bus.addr <= tilemap_addr + 16'd1;
                bus.read_req <= 1'b1;

                dot_phase <= DOT_PHASE_1;

                // $display("[OBJ] READ HIGH addr=%04x tile=%0d row=%0d", tilemap_addr + 16'd1,
                //          current_sprite.tile_idx, sprite_row);
              end

              DOT_PHASE_1: begin
                // Fetch high byte of sprite data
                tile_high_byte <= bus.rdata;
                bus.read_req <= 1'b0;

                state <= FETCHER_PUSH;
                dot_phase <= DOT_PHASE_0;

                // $display("[OBJ] HIGH BYTE rdata=%02x from addr=%04x", bus.rdata, bus.addr);

              end
            endcase
          end

          FETCHER_PUSH: begin
            unique case (dot_phase)
              DOT_PHASE_0: begin
                // Push pixels to FIFO

                pixel_t px;

                // Build all 8 pixels in parallel
                for (logic [3:0] i = 0; i < 8; i++) begin
                  logic [2:0] bit_index;
                  bit_index  = xflip ? 3'(i) : 3'(7 - i);

                  px.color   = gb_color_t'({tile_high_byte[bit_index], tile_low_byte[bit_index]});
                  px.palette = current_sprite.attr[0] ? 3'd1 : 3'd0;
                  px.spr_idx = 6'd0;  //current_sprite.oam_idx;
                  px.bg_prio = current_sprite.attr[7];
                  px.valid   = 1'b1;

                  fifo_bus.write_data[3'(i)] <= px;
                end

                fifo_bus.write_en <= 1'b1;

                dot_phase <= DOT_PHASE_1;
              end

              DOT_PHASE_1: begin
                fifo_bus.write_en <= 1'b0;
                control_bus.stall <= 1'b0;

                state <= FETCHER_IDLE;
              end
            endcase
          end
        endcase
      end
    end
  end
endmodule
