interface Shifter_if;
  // Register in
  logic [31:0] R_in;

  /// Shift amount (0–31)
  logic [ 4:0] shift_amount;
  logic [ 1:0] shift_type;  // LSL / LSR / ASR / ROR
  logic        carry_in;  // CPSR.C 

  logic [31:0] B_out;
  logic        carry_out;

  modport shifter_side(
      input R_in,
      input shift_amount,
      input shift_type,
      input carry_in,
      output B_out,
      output carry_out
  );

endinterface : Shifter_if
