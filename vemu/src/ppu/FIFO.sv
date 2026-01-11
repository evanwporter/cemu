import ppu_types_pkg::*;

module FIFO (
    input logic clk,
    input logic reset,

    input logic dot_en,

    FIFO_if.FIFO_side bus
);
  localparam logic [3:0] DEPTH = 8;

  pixel_t buffer[DEPTH];

  logic [2:0] write_ptr;
  logic [2:0] read_ptr;

  // ======================================================
  // Push (Write) Logic
  // ======================================================
  // 1) Check: Is the FIFO full?
  // 2) Write data at write_ptr
  // 3) Increment write_ptr
  // 4) Increase count

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      write_ptr <= '0;
    end else if (bus.write_en && !bus.full && dot_en) begin
      buffer[write_ptr] <= bus.write_data;
      write_ptr <= write_ptr + 1'b1;
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
    if (reset) begin
      read_ptr <= '0;
    end else if (bus.read_en && !bus.empty) begin
      read_ptr <= read_ptr + 1'b1;
    end
  end

  assign bus.read_data = buffer[read_ptr];


  // ======================================================
  // Update Count
  // ======================================================

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      bus.count <= '0;
    end else begin
      case ({
        bus.write_en && !bus.full, bus.read_en && !bus.empty
      })
        2'b10:   bus.count <= bus.count + 1;  // Write only
        2'b01:   bus.count <= bus.count - 1;  // Read only
        default: bus.count <= bus.count;  // No change or simultaneous read/write
      endcase
    end
  end


  assign bus.empty = (bus.count == 0);
  assign bus.full  = (bus.count == DEPTH);

endmodule
