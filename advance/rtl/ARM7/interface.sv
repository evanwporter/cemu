import cpu_types_pkg::*;

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
  word_t op_b;

  alu_op_t alu_op;

  logic carry_in;

  /// Set CSPR flags
  // Whether to update the CPU flags based on the ALU result
  // Bit 20 of the IR
  logic set_flags;

  word_t result;
  flags_t flags_out;

  modport ALU_side(input op_a, op_b, alu_op, carry_in, set_flags, output result, flags_out);
endinterface : ALU_if

interface Shifter_if;
  // Register in
  logic [31:0] R_in;

  /// Shift amount (0–31)
  logic [4:0] shift_amount;
  shift_type_t shift_type;
  logic carry_in;  // CPSR.C 

  logic [31:0] B_out;
  logic carry_out;

  modport shifter_side(
      input R_in,
      input shift_amount,
      input shift_type,
      input carry_in,
      output B_out,
      output carry_out
  );

endinterface : Shifter_if
