import types_pkg::*;
import cpu_types_pkg::*;

module BarrelShifter (
    input clk,
    input reset,
    Shifter_if.shifter_side bus
);

  /// I believe ARM7 stores it as a byte in the shifter, even 
  /// though only the bottom 5 bits are used.
  byte_t shift_amt_reg;

  // Select latched vs immediate shift
  wire [4:0] shift_amount = bus.use_shift_latch ? 5'(shift_amt_reg) : bus.shift_amount;

  always_ff @(posedge clk) begin
    if (reset) begin
      shift_amt_reg <= 8'd0;
    end else if (bus.latch_shift_amt) begin
      shift_amt_reg <= bus.R_in[7:0];
    end
  end

  always_comb begin
    bus.op_b      = bus.R_in;
    bus.carry_out = bus.carry_in;

    unique case (bus.shift_type)

      SHIFT_LSL: begin
        if (shift_amount == 0) begin
          bus.op_b = bus.R_in;
          bus.carry_out = bus.carry_in;
        end else if (shift_amount < 32) begin
          bus.op_b = bus.R_in << shift_amount;
          bus.carry_out = bus.R_in[32-shift_amount];
        end else if (shift_amount == 32) begin
          bus.op_b = 32'b0;
          bus.carry_out = bus.R_in[0];
        end else begin
          bus.op_b = 32'b0;
          bus.carry_out = 1'b0;
        end
      end

      SHIFT_LSR: begin
        if (shift_amount == 0) begin
          bus.op_b = bus.R_in;
          bus.carry_out = bus.carry_in;
        end else if (shift_amount < 32) begin
          bus.op_b = bus.R_in >> shift_amount;
          bus.carry_out = bus.R_in[shift_amount-1];
        end else if (shift_amount == 32) begin
          bus.op_b = 32'b0;
          bus.carry_out = bus.R_in[31];
        end else begin
          bus.op_b = 32'b0;
          bus.carry_out = 1'b0;
        end
      end

      SHIFT_ASR: begin
        if (shift_amount == 0) begin
          bus.op_b = bus.R_in;
          bus.carry_out = bus.carry_in;
        end else if (shift_amount < 32) begin
          bus.op_b = $signed(bus.R_in) >>> shift_amount;
          bus.carry_out = bus.R_in[shift_amount-1];
        end else begin
          // shift >= 32 replicates sign bit
          bus.op_b = {32{bus.R_in[31]}};
          bus.carry_out = bus.R_in[31];
        end
      end

      SHIFT_ROR: begin
        if (shift_amount == 0) begin
          bus.op_b = bus.R_in;
          bus.carry_out = bus.carry_in;
          $display("Performing RRX with R_in=0x%08x and carry_in=%b, result=0x%08x, carry_out=%b",
                   bus.R_in, bus.carry_in, bus.op_b, bus.carry_out);
        end else if (shift_amount == 0) begin
          bus.op_b = bus.R_in;
          bus.carry_out = bus.R_in[31];
          $display(
              "Performing ROR with shift amount multiple of 32, treating as shift of 0. R_in=0x%08x, result=0x%08x, carry_out=%b",
              bus.R_in, bus.op_b, bus.carry_out);
        end else begin
          bus.op_b = (bus.R_in >> shift_amount) | (bus.R_in << (32 - shift_amount));
          bus.carry_out = bus.R_in[shift_amount-1];
          $display(
              "Performing ROR with R_in=0x%08x and shift amount=%0d, result=0x%08x, carry_out=%b",
              bus.R_in, shift_amount, bus.op_b, bus.carry_out);
        end
      end

      /// TODO RXX
      // SHIFT_RRX: begin
      //   bus.op_b      = {bus.carry_in, bus.R_in[31:1]};
      //   bus.carry_out = bus.R_in[0];
      // end

    endcase
  end

endmodule
