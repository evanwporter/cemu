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
  ADDR_WZ
} address_src_t;

typedef enum logic [2:0] {
  DATA_BUS_OP_READ,
  DATA_BUS_OP_WRITE,
  DATA_BUS_OP_ALU_ONLY
} data_bus_op_t;

typedef enum logic [3:0] {
  DATA_BUS_SRC_NONE,
  DATA_BUS_SRC_IR,

  DATA_BUS_SRC_ALU,

  DATA_BUS_SRC_A,
  DATA_BUS_SRC_B,
  DATA_BUS_SRC_C,
  DATA_BUS_SRC_D,
  DATA_BUS_SRC_E,
  DATA_BUS_SRC_H,
  DATA_BUS_SRC_L,

  DATA_BUS_SRC_W,
  DATA_BUS_SRC_Z,

  DATA_BUS_SRC_SPH,
  DATA_BUS_SRC_SPL

} data_bus_src_t;

typedef enum logic [2:0] {
  IDU_OP_NONE,
  IDU_OP_INC,
  IDU_OP_DEC
} idu_op_t;

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
  ALU_OP_DEC
} alu_op_t;

typedef enum logic [3:0] {
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

  ALU_SRC_MEM
} alu_src_t;

typedef enum logic [2:0] {
  MISC_SRC_NONE,
  MISC_SRC_PC,
  MISC_SRC_SP,
  MISC_SRC_WZ
} misc_src_t;

typedef enum logic [2:0] {
  MISC_OP_NONE,
  MISC_OP_HALT,
  MISC_OP_EI,
  MISC_OP_DI,
  MISC_OP_COND_CHECK,
  MISC_OP_R16_R16_COPY
} misc_ops_t;

typedef enum logic [2:0] {
  COND_NONE,
  COND_NZ,  // not zero
  COND_Z,  // zero
  COND_NC,  // not carry
  COND_C  // carry
} cond_t;

// Corresponds to one m-cycle
typedef struct packed {
  address_src_t addr_src;  // source for address bus
  data_bus_src_t data_bus_src;  // source for data bus
  data_bus_op_t data_bus_op;  // read or write to memory / direction

  idu_op_t idu_op;  // IDU operation to perform on the ADDR bus

  alu_op_t alu_op;  // ALU operation to perform

  // A = A op B
  alu_src_t alu_dst;
  alu_src_t alu_src;

  misc_ops_t misc_op;  // miscellaneous operation

  cond_t cond;  // condition for this cycle

  misc_src_t misc_src;  // source for miscellaneous operations
  misc_src_t misc_dst;  // destination for miscellaneous operations

} cycle_t;

// Maximum number of cycles per instruction
parameter int MAX_CYCLES_PER_INSTR = 6;

typedef logic [2:0] cycle_count_t;

// A control word is the set of all micro-cycles that make up one instruction
typedef struct packed {
  cycle_t [MAX_CYCLES_PER_INSTR-1:0] cycles;
  logic [2:0]                        num_cycles;  // number of valid cycles (1–6)
} control_word_t;

`define DEFAULT_CYCLE '{ \
    addr_src:     ADDR_NONE, \
    data_bus_src: DATA_BUS_SRC_NONE, \
    data_bus_op:  DATA_BUS_OP_ALU_ONLY, \
    idu_op:       IDU_OP_NONE, \
    alu_op:       ALU_OP_NONE, \
    alu_dst:      ALU_SRC_NONE, \
    alu_src:      ALU_SRC_NONE, \
    misc_op:      MISC_OP_NONE, \
    cond:         COND_NONE, \
    misc_dst:     MISC_SRC_NONE, \
    misc_src:     MISC_SRC_NONE  \
}

`endif  // OPCODES_SV
