`ifndef OPCODES_SV
`define OPCODES_SV 

typedef enum logic [3:0] {
  ADDR_NONE,
  ADDR_AF,
  ADDR_BC,
  ADDR_DE,
  ADDR_HL,
  ADDR_PC,
  ADDR_SP,
  ADDR_WZ,

  ADDR_FF_C,
  ADDR_FF_Z
} address_src_t;

typedef enum logic [1:0] {
  DATA_BUS_OP_READ,   // read from memory
  DATA_BUS_OP_WRITE,  // write to memory
  DATA_BUS_OP_NONE    // no request
} data_bus_op_t;

typedef enum logic [3:0] {
  DATA_BUS_SRC_NONE,
  DATA_BUS_SRC_IR,

  DATA_BUS_SRC_A,
  DATA_BUS_SRC_B,
  DATA_BUS_SRC_C,
  DATA_BUS_SRC_D,
  DATA_BUS_SRC_E,
  DATA_BUS_SRC_H,
  DATA_BUS_SRC_L,
  DATA_BUS_SRC_FLAGS,

  DATA_BUS_SRC_W,
  DATA_BUS_SRC_Z,

  DATA_BUS_SRC_SP_HIGH,
  DATA_BUS_SRC_SP_LOW,

  DATA_BUS_SRC_PC_HIGH,
  DATA_BUS_SRC_PC_LOW

} data_bus_src_t;

typedef enum logic [1:0] {
  IDU_OP_NONE,
  IDU_OP_INC,
  IDU_OP_DEC
} idu_op_t;

typedef enum logic [2:0] {
  IDU_SRC_NONE,
  IDU_SRC_PC,
  IDU_SRC_SP,
  IDU_SRC_HL,
  IDU_SRC_BC,
  IDU_SRC_DE,
  IDU_SRC_AF
} idu_src_t;

typedef enum logic [4:0] {
  ALU_OP_NONE,
  ALU_OP_COPY,
  ALU_OP_ADD,
  ALU_OP_ADC,
  ALU_OP_SUB,
  ALU_OP_SBC,
  ALU_OP_AND,
  ALU_OP_OR,
  ALU_OP_XOR,
  ALU_OP_INC,
  ALU_OP_DEC,
  ALU_OP_CP,

  ALU_OP_RR,
  ALU_OP_RRC,
  ALU_OP_RL,
  ALU_OP_RLC,

  ALU_OP_CCF,
  ALU_OP_SCF,

  ALU_OP_ADD_SIGNED,

  ALU_OP_ADD_HIGH,
  ALU_OP_ADD_LOW,

  ALU_OP_BIT,
  ALU_OP_SLA,
  ALU_OP_SRA,
  ALU_OP_SWAP,
  ALU_OP_SRL,
  ALU_OP_RES,
  ALU_OP_SET
} alu_op_t;

typedef enum logic [4:0] {
  ALU_SRC_NONE,
  ALU_SRC_A,
  ALU_SRC_B,
  ALU_SRC_C,
  ALU_SRC_D,
  ALU_SRC_E,
  ALU_SRC_H,
  ALU_SRC_L,

  ALU_SRC_W,
  ALU_SRC_Z,

  ALU_SRC_SP_HIGH,
  ALU_SRC_SP_LOW,

  ALU_SRC_PC_HIGH,
  ALU_SRC_PC_LOW
} alu_src_t;

typedef enum logic [2:0] {
  ALU_BIT_0,
  ALU_BIT_1,
  ALU_BIT_2,
  ALU_BIT_3,
  ALU_BIT_4,
  ALU_BIT_5,
  ALU_BIT_6,
  ALU_BIT_7
} alu_bit_t;

typedef enum logic [2:0] {
  MISC_OP_DST_NONE,
  MISC_OP_DST_PC,
  MISC_OP_DST_SP,
  MISC_OP_DST_BC,
  MISC_OP_DST_DE,
  MISC_OP_DST_HL,
  MISC_OP_DST_AF
} misc_op_dst_t;

typedef enum logic [3:0] {
  MISC_OP_NONE,
  MISC_OP_HALT,
  MISC_OP_IME_DISABLE,
  MISC_OP_IME_ENABLE,
  MISC_OP_COND_CHECK,
  MISC_OP_R16_WZ_COPY,
  MISC_OP_SET_PC_CONST,
  MISC_OP_JR_SIGNED,
  MISC_OP_SP_HL_COPY,
  MISC_OP_CB_PREFIX
} misc_ops_t;

typedef enum logic [2:0] {
  COND_NONE,
  COND_NZ,  // not zero
  COND_Z,  // zero
  COND_NC,  // not carry
  COND_C  // carry
} cond_t;

// Corresponds to one m-cycle
// Try to keep it under 32 bits for efficiency
typedef struct packed {
  address_src_t addr_src;  // source for address bus
  data_bus_src_t data_bus_src;  // source for data bus
  data_bus_op_t data_bus_op;  // read or write to memory / direction

  idu_op_t idu_op;  // IDU operation to perform on the ADDR bus
  address_src_t idu_dst;  // destination for IDU operation

  alu_op_t alu_op;  // ALU operation to perform

  // A = A op B
  alu_src_t alu_dst;
  alu_src_t alu_src;

  alu_bit_t alu_bit;  // bit index for bit operations

  misc_ops_t misc_op;  // miscellaneous operation

  misc_op_dst_t misc_op_dst;  // destination for misc operation

  cond_t cond;  // condition for this cycle

} cycle_t;

typedef logic [2:0] cycle_count_t;

// Maximum number of cycles per instruction
parameter cycle_count_t MAX_CYCLES_PER_INSTR = 6;

// A control word is the set of all micro-cycles that make up one instruction
typedef struct packed {
  cycle_t [MAX_CYCLES_PER_INSTR-1:0] cycles;
  logic [2:0] num_cycles;  // number of valid cycles (1–6)
} control_word_t;

`define DEFAULT_CYCLE '{ \
  addr_src:     ADDR_NONE, \
  data_bus_src: DATA_BUS_SRC_NONE, \
  data_bus_op:  DATA_BUS_OP_NONE, \
  idu_op:       IDU_OP_NONE, \
  idu_dst:      ADDR_NONE, \
  alu_op:       ALU_OP_NONE, \
  alu_dst:      ALU_SRC_NONE, \
  alu_src:      ALU_SRC_NONE, \
  alu_bit:      ALU_BIT_0, \
  misc_op:      MISC_OP_NONE, \
  misc_op_dst:  MISC_OP_DST_NONE, \
  cond:         COND_NONE \
}

`endif  // OPCODES_SV
