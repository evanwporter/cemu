package mmu_types_pkg;

  typedef enum logic [1:0] {
    INSTR_READ = 2'b00,
    DATA_READ  = 2'b01,
    DATA_WRITE = 2'b10
  } transaction_kind_t;

endpackage : mmu_types_pkg
