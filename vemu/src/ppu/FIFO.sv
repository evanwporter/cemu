import ppu_types_pkg::*;

module FIFO (
    input logic clk,
    input logic reset,

    // Producer (fetcher) writes
    input logic write_en,
    input pixel_t write_data,
    output logic full,  // FIFO is full (can't accept writes)

    // Consumer (framebuffer) reads
    input logic read_en,
    output pixel_t read_data,
    output logic empty,  // FIFO is empty (can't be read)

    output logic [3:0] count  // number of pixels inside
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
    end else if (write_en && !full) begin
      buffer[write_ptr] <= write_data;
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
      read_ptr  <= '0;
      read_data <= '0;
    end else if (read_en && !empty) begin
      read_data <= buffer[read_ptr];
      read_ptr  <= read_ptr + 1'b1;
    end
  end


  // ======================================================
  // Update Count
  // ======================================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      count <= '0;
    end else begin
      case ({
        write_en && !full, read_en && !empty
      })
        2'b10:   count <= count + 1;  // Write only
        2'b01:   count <= count - 1;  // Read only
        default: count <= count;  // No change or simultaneous read/write
      endcase
    end
  end


  assign empty = (count == 0);
  assign full  = (count == DEPTH);

endmodule
