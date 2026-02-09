`ifndef CPU_UTIL_SVH
`define CPU_UTIL_SVH

`define TRACE_CPU \
  $display("[%0t] PC=%0d IR=%h instr=%0d flush=%b cycle=%0d | WB=%0d Rd=%0d ALU=%h", \
    $time, \
    regs.user.r15, \
    IR, \
    decoder_bus.word.instr_type, \
    controlUnit.flush_cnt != 3'd0, \
    controlUnit.cycle, \
    control_signals.ALU_writeback, \
    decoder_bus.word.Rd, \
    alu_bus.result \
  );

`define DISPLAY_CONTROL(ctrl) \
  $display("---- CONTROL WORD ----"); \
  $display("incrementer_writeback : %0b", ctrl.incrementer_writeback); \
  $display("ALU_writeback         : %s", ctrl.ALU_writeback.name()); \
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
  $display("shift_latch_amt       : %0b", ctrl.shift_latch_amt); \
  $display("shift_use_latch       : %0b", ctrl.shift_use_latch); \
  $display("shift_type            : %s", ctrl.shift_type.name()); \
  $display("shift_amount          : %0d", ctrl.shift_amount); \
  $display("----------------------"); \
  $fflush();

`define DISPLAY_DECODED_DATAPROC_IMM(word) \
  begin \
    $display("---- DECODED WORD (DATAPROC_IMM) ----");                      \
    $display("IR        = 0x%08x", (word).IR);                              \
    $display("opcode    = %0d",   (word).immediate.data_proc_imm.opcode);   \
    $display("S bit     = %0b",   (word).immediate.data_proc_imm.set_flags);\
    $display("Rn        = R%0d",  (word).Rn); \
    $display("Rd        = R%0d",  (word).Rd); \
    $display("Rm        = R%0d",  (word).Rm);                               \
    $display("Rs        = R%0d",  (word).Rs);                               \
    $display("imm8      = 0x%02x", \
             (word).immediate.data_proc_imm.imm8);                          \
    $display("cond pass = %0d", (word).condition_pass); \
    $display("rotate    = %0d (actual ROR=%0d)",                            \
             (word).immediate.data_proc_imm.rotate,                         \
             ((word).immediate.data_proc_imm.rotate << 1));                 \
    $display("------------------------------------");                       \
    $fflush();                                                              \
  end

`define DISPLAY_DECODED_DATAPROC_REG_IMM(word) \
  begin \
    $display("---- DECODED WORD (DATAPROC_REG_IMM) ----");                 \
    $display("IR          = 0x%08x", (word).IR);                           \
    $display("opcode      = %0d",   (word).immediate.data_proc_reg_imm.opcode); \
    $display("S bit       = %0b",   (word).immediate.data_proc_reg_imm.set_flags); \
    $display("Rn          = R%0d",  (word).Rn);                            \
    $display("Rd          = R%0d",  (word).Rd);                            \
    $display("Rm          = R%0d",  (word).Rm);                            \
    $display("shift type  = %s",    (word).immediate.data_proc_reg_imm.shift_type.name()); \
    $display("shift amt   = %0d",   (word).immediate.data_proc_reg_imm.shift_amount); \
    $display("cond pass   = %0d",   (word).condition_pass);               \
    $display("----------------------------------------");                   \
    $fflush();                                                            \
  end

  `define DISPLAY_DECODED_DATAPROC_REG_REG(word) \
  begin \
    $display("---- DECODED WORD (DATAPROC_REG_REG) ----");                  \
    $display("IR          = 0x%08x", (word).IR);                           \
    $display("opcode      = %0d",   (word).immediate.data_proc_reg_reg.opcode); \
    $display("S bit       = %0b",   (word).immediate.data_proc_reg_reg.set_flags); \
    $display("Rn          = R%0d",  (word).Rn);                            \
    $display("Rd          = R%0d",  (word).Rd);                            \
    $display("Rm          = R%0d",  (word).Rm);                            \
    $display("Rs          = R%0d",  (word).Rs);                            \
    $display("shift type  = %s",    (word).immediate.data_proc_reg_reg.shift_type.name()); \
    $display("cond pass   = %0d",   (word).condition_pass);               \
    $display("------------------------------------------");                  \
    $fflush();                                                            \
  end


`define WRITE_REG(REGS, MODE, REGNUM, VALUE) \
  begin \
    unique case (REGNUM) \
      4'd0:  (REGS).common.r0  <= (VALUE); \
      4'd1:  (REGS).common.r1  <= (VALUE); \
      4'd2:  (REGS).common.r2  <= (VALUE); \
      4'd3:  (REGS).common.r3  <= (VALUE); \
      4'd4:  (REGS).common.r4  <= (VALUE); \
      4'd5:  (REGS).common.r5  <= (VALUE); \
      4'd6:  (REGS).common.r6  <= (VALUE); \
      4'd7:  (REGS).common.r7  <= (VALUE); \
      4'd8: begin \
        if ((MODE) == MODE_FIQ) (REGS).fiq.r8  <= (VALUE); \
        else (REGS).user.r8 <= (VALUE); \
      end \
      4'd9: begin \
        if ((MODE) == MODE_FIQ) (REGS).fiq.r9  <= (VALUE); \
        else (REGS).user.r9 <= (VALUE); \
      end \
      4'd10: begin \
        if ((MODE) == MODE_FIQ) (REGS).fiq.r10 <= (VALUE); \
        else (REGS).user.r10<= (VALUE); \
      end \
      4'd11: begin \
        if ((MODE) == MODE_FIQ) (REGS).fiq.r11 <= (VALUE); \
        else (REGS).user.r11<= (VALUE); \
      end \
      4'd12: begin \
        if ((MODE) == MODE_FIQ) (REGS).fiq.r12 <= (VALUE); \
        else (REGS).user.r12<= (VALUE); \
      end \
      4'd13: begin \
        unique case (MODE) \
          MODE_USR, MODE_SYS: (REGS).user.r13 <= (VALUE); \
          MODE_FIQ: (REGS).fiq.r13 <= (VALUE); \
          MODE_SVC: (REGS).supervisor.r13 <= (VALUE); \
          MODE_ABT: (REGS).abort.r13 <= (VALUE); \
          MODE_IRQ: (REGS).irq.r13 <= (VALUE); \
          MODE_UND: (REGS).undefined.r13 <= (VALUE);  \
        endcase \
      end \
      4'd14: begin \
        unique case (MODE) \
          MODE_USR, MODE_SYS: (REGS).user.r14 <= (VALUE); \
          MODE_FIQ: (REGS).fiq.r14 <= (VALUE); \
          MODE_SVC: (REGS).supervisor.r14 <= (VALUE); \
          MODE_ABT: (REGS).abort.r14 <= (VALUE); \
          MODE_IRQ: (REGS).irq.r14 <= (VALUE); \
          MODE_UND: (REGS).undefined.r14 <= (VALUE); \
        endcase \
      end \
      4'd15: (REGS).user.r15 <= (VALUE); \
    endcase \
  end

`endif // CPU_UTIL_SVH