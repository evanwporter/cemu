typedef enum logic [4:0] {
  ALU_NONE,
  ALU_ADD,
  ALU_SUB,
  ALU_AND,
  ALU_OR,
  ALU_XOR,
  ALU_INC,
  ALU_DEC,
  ALU_SRA,
  ALU_SRL,
  ALU_SLA,
  ALU_SWAP
} alu_op_t;

typedef enum logic [3:0] {
  ROT_NONE,
  ROT_RLCA,
  ROT_RLA,
  ROT_RRCA,
  ROT_RRA,
  ROT_RLC,
  ROT_RRC,
  ROT_RL,
  ROT_RR
} rot_op_t;

typedef enum logic [4:0] {
  REG_NONE,
  REG_A,
  REG_B,
  REG_C,
  REG_D,
  REG_E,
  REG_H,
  REG_L,

  REG_AF,
  REG_BC,
  REG_DE,
  REG_HL,

  REG_SP,
  REG_PC,

  REG_IMM8,
  REG_IMM16,
  REG_IMM_S8, // Signed 8-bit immediate

  REG_ADDR_IMM8,  // Memory at immediate 8-bit address (added to 0xFF00)
  REG_ADDR_IMM16, // Memory at immediate 16-bit address

  REG_ADDR_HL,  // Memory at address [HL]
  REG_ADDR_BC,  // Memory at address [BC]
  REG_ADDR_DE,  // Memory at address [DE]
  REG_ADDR_SP,  // Memory at address [SP]

  REG_FLAGS  // Flag register (for internal condition checks)
} reg_sel_t;


typedef enum logic [1:0] {
  SAME_FLAG,
  RESET,
  SET,
  UNTOUCHED
} flag_update_t;

typedef enum logic [1:0] {
  POST_INC,
  POST_NO_CHANGE,
  POST_DEC
} post_delta_t;

typedef struct packed {
  // --------------- Memory Interface ---------------
  logic post_delta_t;  // Auto-increment/deincrement pointer (for HL+, etc.)

  // --------------- Data Path ---------------
  reg_sel_t src_sel;  // Source register or immediate
  reg_sel_t dst_sel;  // Destination register
  alu_op_t  alu_op;   // ALU operation (if any)
  logic     signed_;  // Treat src immediate as signed (for ADD, etc.)
  rot_op_t  rot_op;   // Rotate/shift operation (if any)

  // --------------- Control Flow ---------------
  logic     pc_load;  // Load PC (used for JP, CALL, RET, etc.)
  reg_sel_t pc_src;   // Source for new PC
  logic     sp_push;  // Push current PC onto stack
  logic     sp_pop;   // Pop PC from stack

  // --------------- Flags ---------------
  flag_update_t flag_zero;        // Update Zero flag (Z)
  flag_update_t flag_subtract;    // Update Subtract flag (N)
  flag_update_t flag_half_carry;  // Update Half Carry flag (H)
  flag_update_t flag_carry;       // Update Carry flag (C)

  // --------------- Conditional ---------------
  logic       cond_enable;  // 1 = instruction uses conditional branch
  logic [1:0] cond_type;    // which flag: 00=Z, 01=C, 10=N, 11=H
  logic       cond_value;   // 0 or 1: required flag value to branch
} control_word_t;

// write from A
// read to A



// addr_sel	    Which register drives the address bus (e.g., HL, PC, SP)
// src_sel	    Source of the data to be written (register or immediate)
// dst_sel	    Destination register for data read
// mem_read	    Memory read at addr_sel
// mem_write	  Memory write to addr_sel
