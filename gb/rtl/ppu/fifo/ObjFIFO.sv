import ppu_types_pkg::*;
import ppu_util_pkg::*;

module Obj_FIFO (
    input logic clk,
    input logic reset,
    FIFO_if.FIFO_side bus,
    input logic flush
);

  pixel_t buffer[FIFO_DEPTH];

  // Object priority
  function automatic logic obj_has_priority(pixel_t new_px, pixel_t old_px);
    if (!old_px.valid) return 1'b1;
    if (!new_px.valid || new_px.color == 2'd0) return 1'b0;

    // DMG priority
    if (new_px.x_pos < old_px.x_pos) return 1'b1;
    if (new_px.x_pos > old_px.x_pos) return 1'b0;

    return (new_px.spr_idx < old_px.spr_idx);
  endfunction

  // Write / Merge logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      for (logic [3:0] i = 0; i < FIFO_DEPTH; i++) buffer[3'(i)] <= pixel_t'(0);
      bus.count <= 0;

    end else begin

      // BULK WRITE
      if (bus.write_en && bus.empty) begin
        for (logic [3:0] i = 0; i < FIFO_DEPTH; i++) buffer[3'(i)] <= bus.write_data[3'(i)];

        bus.count <= FIFO_DEPTH;
      end else if (bus.write_en && !bus.empty) begin
        for (logic [3:0] i = 0; i < FIFO_DEPTH; i++) begin
          if (obj_has_priority(bus.write_data[3'(i)], buffer[3'(i)]))
            buffer[3'(i)] <= bus.write_data[3'(i)];
        end
        bus.count <= FIFO_DEPTH;
      end

      // READ (SHIFT)
      if (bus.read_en && !bus.empty) begin
        for (logic [3:0] i = 0; i < FIFO_DEPTH - 1; i++) buffer[3'(i)] <= buffer[3'(i)+1];

        buffer[FIFO_DEPTH-1] <= pixel_t'(0);
        bus.count <= bus.count - 1'b1;
      end
    end
  end

  // Outputs
  assign bus.read_data = buffer[0];
  assign bus.empty     = (bus.count == 0);
  assign bus.full      = (bus.count == FIFO_DEPTH);

endmodule

