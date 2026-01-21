import ppu_types_pkg::*;
import ppu_util_pkg::*;

module Obj_FIFO (
    input logic clk,
    input logic reset,

    FIFO_if.FIFO_side bus,

    input logic flush
);
  pixel_t buffer[FIFO_DEPTH];

  logic [2:0] read_ptr;

  // ======================================================
  // Push (Write) Logic
  // ======================================================
  // 1) Check: Is the FIFO empty?
  // 2) Write FIFO_DEPTH pixels into the buffer in one cycle
  // 3) Set count to FIFO_DEPTH

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      for (logic [3:0] i = 0; i < FIFO_DEPTH; i++) begin
        buffer[3'(i)] <= pixel_t'(0);
      end

    end else if (bus.write_en) begin
      // Bus is empty? Great -- just write everything
      if (bus.empty) begin
        for (logic [3:0] i = 0; i < FIFO_DEPTH; i++) begin
          buffer[3'(i)] <= bus.write_data[3'(i)];
        end

        if (read_ptr != 3'd0) begin
          $fatal(1, "OBJ FIFO: write while read_ptr != 0 (read_ptr=%0d)", read_ptr);
        end

      end else begin
        for (logic [3:0] i = 0; i < FIFO_DEPTH; i++) begin
          pixel_t incoming;
          incoming = bus.write_data[3'(i)];

          buffer[3'(i)] <= buffer[3'(i)];

          if (incoming.valid) begin
            if (!buffer[3'(i)].valid) begin
              buffer[3'(i)] <= incoming;

            end else if (incoming.spr_idx < buffer[3'(i)].spr_idx) begin
              buffer[3'(i)] <= incoming;
            end
          end
        end
      end
    end
  end


  // ======================================================
  // Pop (Read) Logic
  // ======================================================
  // 1) Check: Is the FIFO empty?
  // 2) Read data at read_ptr
  // 3) Increment read_ptr
  // 4) Decrease count

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      read_ptr <= 3'd0;
    end else if (bus.read_en && !bus.empty) begin
      read_ptr <= read_ptr + 1'b1;
    end
  end

  assign bus.read_data = buffer[read_ptr];


  // ======================================================
  // Update Count
  // ======================================================

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      bus.count <= '0;
    end else begin
      if (bus.write_en && bus.empty) begin
        // Bulk write of 8 pixels
        bus.count <= FIFO_DEPTH;
      end else if (bus.read_en && !bus.empty) begin
        // Single read
        bus.count <= bus.count - 1'b1;
      end
    end
  end


  assign bus.empty = (bus.count == 0);
  assign bus.full  = (bus.count == FIFO_DEPTH);

endmodule
