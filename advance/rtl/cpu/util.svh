`ifndef CPU_UTIL_SVH
`define CPU_UTIL_SVH

`define TRACE_CPU \
  $display("[%0t] PC=%0d IR=%h instr=%0d flush=%b cycle=%0d | WB=%0d Rd=%0d ALU=%h", \
    $time, \
    regs.user[15], \
    IR, \
    decoder_bus.word.instr_type, \
    controlUnit.flush_cnt != 3'd0, \
    controlUnit.cycle, \
    control_signals.alu_writeback, \
    decoder_bus.word.Rd, \
    alu_bus.result \
  );

`define DISPLAY_CONTROL(ctrl) \
  $display("---- CONTROL WORD ----"); \
  $display("incrementer_writeback : %0b", ctrl.incrementer_writeback); \
  $display("alu_writeback         : %s", ctrl.alu_writeback.name()); \
  $display("shift_source          : %s", ctrl.shift_source.name()); \
  $display("B_bus_source          : %s", ctrl.B_bus_source.name()); \
  $display("B_bus_imm             : 0x%03h", ctrl.B_bus_imm); \
  $display("addr_bus_src          : %s", ctrl.addr_bus_src.name()); \
  $display("memory_write_en       : %0b", ctrl.memory_write_en); \
  $display("memory_read_en        : %0b", ctrl.memory_read_en); \
  $display("memory_latch_IR       : %0b", ctrl.memory_latch_IR); \
  $display("ALU_latch_op_b        : %0b", ctrl.ALU_latch_op_b); \
  $display("ALU_use_op_b_latch    : %0b", ctrl.ALU_use_op_b_latch); \
  $display("ALU_disable_op_b      : %0b", ctrl.ALU_disable_op_b); \
  $display("ALU_set_flags         : %0b", ctrl.ALU_set_flags); \
  $display("ALU_op                : %s", ctrl.ALU_op.name()); \
  $display("latch_shift_amt       : %0b", ctrl.latch_shift_amt); \
  $display("use_shift_latch       : %0b", ctrl.use_shift_latch); \
  $display("shift_type            : %s", ctrl.shift_type.name()); \
  $display("shift_amount          : %0d", ctrl.shift_amount); \
  $display("----------------------"); \
  $fflush();


`endif // CPU_UTIL_SVH