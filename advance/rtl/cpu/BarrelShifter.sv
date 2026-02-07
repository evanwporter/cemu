import types_pkg::*;
import cpu_types_pkg::*;

module BarrelShifter (
    input clk,
    input reset,
    Shifter_if.shifter_side bus
);

  /// I believe ARM7 stores it as a byte in the shifter, even though only the bottom 5 bits are used
  byte_t shift_amt_reg;

  wire [4:0] shift_amount = bus.use_shift_latch ? shift_amt_reg[4:0] : bus.shift_amount;

  always_ff @(posedge clk) begin
    if (reset) begin
      shift_amt_reg <= 8'd0;
    end else if (bus.latch_shift_amt) begin
      shift_amt_reg <= 8'(bus.shift_amount);
    end
  end

  always_comb begin

    unique case (bus.shift_type)

      SHIFT_LSL: begin
      end

      SHIFT_LSR: begin
      end

      SHIFT_ASR: begin
      end

      SHIFT_ROR: begin
      end

    endcase
  end

endmodule
