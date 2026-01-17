import ppu_types_pkg::*;
import ppu_util_pkg::*;

module FIFO (
    input logic clk,
    input logic reset,

    FIFO_if.FIFO_side bus,

    input logic flush
);
  gb_color_t buffer[FIFO_DEPTH];

  // logic [2:0] read_ptr;
  // logic [2:0] write_ptr;

  // ======================================================
  // Push (Write) Logic
  // ======================================================
  // 1) Check: Is the FIFO empty?
  // 2) Write FIFO_DEPTH pixels into the buffer in one cycle
  // 3) Set count to FIFO_DEPTH

  always_ff @(posedge clk or posedge reset) begin
    if (reset || flush) begin
      // Nothing to do
      for (logic [3:0] i = 0; i < FIFO_DEPTH; i++) begin
        buffer[3'(i)] <= gb_color_t'(0);
      end
    end else if (bus.write_en && bus.empty) begin
      // Performs 8 parallel writes
      for (logic [3:0] i = 0; i < FIFO_DEPTH; i++) begin
        buffer[3'(i)] <= bus.write_data[3'(i)];
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
      // read_ptr <= '0;
    end else if (bus.read_en && !bus.empty) begin
      // read_ptr <= read_ptr + 1'b1;
    end
  end

  assign bus.read_data = buffer;


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
        bus.count <= 0;
      end
    end
  end


  assign bus.empty = (bus.count == 0);
  assign bus.full  = (bus.count == FIFO_DEPTH);

endmodule
