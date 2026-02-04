import cpu_types_pkg::*;
import types_pkg::*;

module BarrelShifter (
    Shifter_if.shifter_side bus
);

  function automatic logic [31:0] shift(input logic [31:0] value, input shift_type_t shift_type,
                                        input int unsigned amount);
    case (shift_type)
      SHIFT_LSL: shift = value << amount;
      SHIFT_LSR: shift = value >> amount;
      SHIFT_ASR: shift = $signed(value) >>> amount;
      SHIFT_ROR: shift = (value >> amount) | (value << (32 - amount));
      default:   shift = value;
    endcase
  endfunction

  logic [31:0] stage[0:5];

  assign stage[0] = bus.Rm;

  assign stage[1] = bus.shift_amount[0] ? shift(stage[0], bus.shift_type, 1) : stage[0];
  assign stage[2] = bus.shift_amount[1] ? shift(stage[1], bus.shift_type, 2) : stage[1];
  assign stage[3] = bus.shift_amount[2] ? shift(stage[2], bus.shift_type, 4) : stage[2];
  assign stage[4] = bus.shift_amount[3] ? shift(stage[3], bus.shift_type, 8) : stage[3];
  assign stage[5] = bus.shift_amount[4] ? shift(stage[4], bus.shift_type, 16) : stage[4];

  // Default output
  always_comb begin
    bus.op_b      = stage[5];
    bus.carry_out = bus.carry_in;

    unique case (bus.shift_type)

      SHIFT_LSL: begin
        if (bus.shift_amount != 5'd0) bus.carry_out = bus.Rm[32-bus.shift_amount];
      end

      SHIFT_LSR: begin
        if (bus.shift_amount == 5'd0) bus.carry_out = bus.Rm[31];  // LSR #32
        else bus.carry_out = bus.Rm[bus.shift_amount-1];
      end

      SHIFT_ASR: begin
        if (bus.shift_amount == 5'd0) bus.carry_out = bus.Rm[31];  // ASR #32
        else bus.carry_out = bus.Rm[bus.shift_amount-1];
      end

      SHIFT_ROR: begin
        if (bus.shift_amount == 5'd0) begin  // RRX
          bus.op_b      = {bus.carry_in, bus.Rm[31:1]};
          bus.carry_out = bus.Rm[0];
        end else begin
          bus.carry_out = bus.Rm[bus.shift_amount-1];
        end
      end

    endcase
  end

endmodule
