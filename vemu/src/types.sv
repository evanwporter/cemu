`ifndef TYPES_SV
`define TYPES_SV 

// When using Verilator I need it unpacked so I can access fields
// from regs in C++.
`ifndef VERILATOR
`define PACK_REG packed
`else
`define PACK_REG
`endif


typedef struct `PACK_REG {
  logic [7:0] a, b, c, d, e, h, l;

  // Temporary storage during operations
  logic [7:0] w, z;

  // Instruction Register
  logic [7:0] IR;

  // Interrupt Enable
  logic [7:0] IE;

  logic [7:0] flags;
  logic [15:0] sp, pc;

  // stack pointer
  logic [7:0] sph, spl;

} cpu_regs_t;

typedef enum logic [1:0] {
  BUS_OP_IDLE,  // no request
  BUS_OP_READ,  // read from memory
  BUS_OP_WRITE  // write to memory
} bus_op_t;

typedef enum logic {
  BUS_SIZE_BYTE,  // 8-bit transfer
  BUS_SIZE_WORD   // 16-bit transfer
} bus_size_t;

typedef enum logic [1:0] {
  T1,
  T2,
  T3,
  T4
} t_phase_t;


`endif  // TYPES_SV
