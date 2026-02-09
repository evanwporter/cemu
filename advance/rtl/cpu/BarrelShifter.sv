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
  wire [7:0] shift_amt_full = bus.shift_use_latch ? shift_amt_reg : {3'b0, bus.shift_amount};

  wire [4:0] shift_amt_5 = shift_amt_full[4:0];

  always_ff @(posedge clk) begin
    if (reset) begin
      shift_amt_reg <= 8'd0;
    end else if (bus.shift_latch_amt) begin
      shift_amt_reg <= bus.R_in[7:0];
    end
  end

  always_comb begin
    bus.op_b = bus.R_in;
    bus.carry_out = bus.carry_in;

    unique case (bus.shift_type)

      SHIFT_LSL: begin
        if (shift_amt_full == 0) begin
          bus.op_b = bus.R_in;
          bus.carry_out = bus.carry_in;
        end else if (shift_amt_full < 32) begin
          bus.op_b = bus.R_in << shift_amt_5;
          bus.carry_out = bus.R_in[32-shift_amt_5];
        end else if (shift_amt_full == 32) begin
          bus.op_b = 32'b0;
          bus.carry_out = bus.R_in[0];
        end else begin
          bus.op_b = 32'b0;
          bus.carry_out = 1'b0;
        end
      end

      SHIFT_LSR: begin
        if (!bus.shift_use_latch && shift_amt_full == 0) begin
          // LSR #0 (immediate form) => LSR #32
          bus.op_b = 32'b0;
          bus.carry_out = bus.R_in[31];
        end else if (shift_amt_full == 0) begin
          // Register form Rs==0 => no shift
          bus.op_b = bus.R_in;
          bus.carry_out = bus.carry_in;
        end else if (shift_amt_full < 32) begin
          bus.op_b = bus.R_in >> shift_amt_5;
          bus.carry_out = bus.R_in[shift_amt_5-1];
        end else if (shift_amt_full == 32) begin
          bus.op_b = 32'b0;
          bus.carry_out = bus.R_in[31];
        end else begin
          bus.op_b = 32'b0;
          bus.carry_out = 1'b0;
        end
      end

      SHIFT_ASR: begin
        if (!bus.shift_use_latch && shift_amt_full == 0) begin
          // ASR #0 (immediate form) => ASR #32
          bus.op_b = {32{bus.R_in[31]}};
          bus.carry_out = bus.R_in[31];
        end else if (shift_amt_full == 0) begin
          // Register form with Rs[7:0]==0 => no shift
          bus.op_b = bus.R_in;
          bus.carry_out = bus.carry_in;
        end else if (shift_amt_full < 32) begin
          bus.op_b = $signed(bus.R_in) >>> shift_amt_5;
          bus.carry_out = bus.R_in[shift_amt_5-1];
        end else begin
          bus.op_b = {32{bus.R_in[31]}};
          bus.carry_out = bus.R_in[31];
        end
      end

      SHIFT_ROR: begin
        if (bus.shift_use_rxx) begin
          // Explicit RRX (only when control unit says so)
          bus.op_b      = {bus.carry_in, bus.R_in[31:1]};
          bus.carry_out = bus.R_in[0];
        end else if (shift_amt_full == 0) begin
          // if (!bus.shift_use_rxx) begin
          //   // Register shift-immediate encoding: ROR #0 => RRX
          //   bus.op_b = {bus.carry_in, bus.R_in[31:1]};
          //   bus.carry_out = bus.R_in[0];
          // end else begin
          //   // Immediate rotate encoding: rotate=0 => no rotate
          bus.op_b = bus.R_in;
          bus.carry_out = bus.carry_in;
          // end
        end else if (shift_amt_5 == 0) begin
          // Multiple of 32 (register form)
          bus.op_b = bus.R_in;
          bus.carry_out = bus.R_in[31];
        end else begin
          bus.op_b = (bus.R_in >> shift_amt_5) | (bus.R_in << (32 - shift_amt_5));
          bus.carry_out = bus.R_in[shift_amt_5-1];
        end
      end
    endcase
  end

endmodule
