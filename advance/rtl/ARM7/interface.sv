import cpu_types_pkg::*;
import types_pkg::*;

// interface CPU_if;
//   logic [15:0] addr;
//   logic [ 7:0] wdata;
//   logic [ 7:0] rdata;
//   logic        read_en;
//   logic        write_en;

//   modport CPU_side(output addr, wdata, read_en, write_en, input rdata);

//   modport 

// endinterface : CPU_if

interface Decoder_if (
    input word_t IR
);

  decoded_word_t word;

  modport Decoder_side(input IR, output word);

endinterface : Decoder_if

interface ALU_if;
  word_t op_a;

  alu_op_t alu_op;

  logic carry_in;

  /// Set CSPR flags
  // Whether to update the CPU flags based on the ALU result
  // Bit 20 of the IR
  logic set_flags;

  word_t result;
  flags_t flags_out;

  modport ALU_side(input op_a, alu_op, carry_in, set_flags, output result, flags_out);
endinterface : ALU_if

interface Shifter_if;
  // Register in
  word_t Rm;

  /// Shift amount (0–31)
  logic [4:0] shift_amount;
  shift_type_t shift_type;
  logic carry_in;  // CPSR.C 

  word_t op_b;
  logic carry_out;

  modport shifter_side(
      input Rm,
      input shift_amount,
      input shift_type,
      input carry_in,
      output op_b,
      output carry_out
  );

  modport ALU_side(input op_b, input carry_out);

endinterface : Shifter_if

interface B_if;

  word_t data;

endinterface : B_if
