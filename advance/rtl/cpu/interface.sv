import types_pkg::*;
import cpu_types_pkg::*;

interface Decoder_if (
    input word_t IR
);

  decoded_word_t word;
  logic enable;

  modport Decoder_side(input IR, enable, output word);

  modport ControlUnit_side(input word, output enable);

endinterface : Decoder_if

interface ALU_if (
    input word_t op_a
);

  /// Whether to latch the B_bus value into the ALU for use in the next cycle
  logic latch_op_b;

  /// Whether to use the latched B_bus value in the ALU for the current cycle
  logic use_op_b_latch;

  /// Whether to use the B_bus value in the ALU for the current cycle
  /// If false, then regardless of what the B_bus value is, the ALU will use zero as its B operand
  logic disable_op_b;

  alu_op_t alu_op;

  logic carry_in;

  //   /// Set CSPR flags
  //   // Whether to update the CPU flags based on the ALU result
  //   // Bit 20 of the IR
  //   logic set_flags;

  word_t result;
  flags_t flags_out;

  modport ALU_side(
      input op_a, alu_op, carry_in, use_op_b_latch, disable_op_b, latch_op_b,
      output result, flags_out
  );
endinterface : ALU_if

interface Shifter_if (
    input word_t R_in
);

  /// Shift amount (0–31)
  logic [4:0] shift_amount;

  /// Signal to latch the shift amount from the Rs register
  logic latch_shift_amt;

  /// Signal to use the latched shift amount
  logic use_shift_latch;

  shift_type_t shift_type;
  logic carry_in;  // CPSR.C 

  word_t op_b;
  logic carry_out;

  modport shifter_side(
      input R_in,
      input shift_amount,
      input shift_type,
      input carry_in,
      input latch_shift_amt,
      input use_shift_latch,
      output op_b,
      output carry_out
  );

  modport ALU_side(input op_b, input carry_out);

endinterface : Shifter_if
