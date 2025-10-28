typedef struct packed {
  logic [7:0]  a,  f,  b, c, d, e, h, l;
  logic [15:0] sp, pc;
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
