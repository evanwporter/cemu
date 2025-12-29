package cpu_types_pkg;

// When using Verilator I need it unpacked so I can access fields
// from regs in C++.
`ifndef VERILATOR
`define PACK_REG packed
`else
`define PACK_REG
`endif

// verilog_format: off
typedef struct `PACK_REG {
  logic [7:0] a, b, c, d, e, h, l;

  // Temporary storage during operations
  logic [7:0] w, z;

  // Instruction Register
  logic [7:0] IR;

  // Interrupt Master Enable
  logic IME;

  logic [7:0] flags;

  // Program counter
  logic [7:0] pch, pcl;

  // stack pointer
  logic [7:0] sph, spl;

  logic e8_sign;
} cpu_regs_t;
// verilog_format: on

`undef PACK_REG

typedef enum logic [1:0] {
  T1,
  T2,
  T3,
  T4
} t_phase_t;

endpackage
