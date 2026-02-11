import types_pkg::*;
import cpu_types_pkg::*;
import control_types_pkg::*;

package cpu_util_pkg;

  function automatic logic eval_cond(input logic [3:0] cond, input logic N, input logic Z,
                                     input logic C, input logic V);
    case (cond)
      4'b0000: eval_cond = Z;  // EQ
      4'b0001: eval_cond = !Z;  // NE
      4'b0010: eval_cond = C;  // CS/HS
      4'b0011: eval_cond = !C;  // CC/LO
      4'b0100: eval_cond = N;  // MI
      4'b0101: eval_cond = !N;  // PL
      4'b0110: eval_cond = V;  // VS
      4'b0111: eval_cond = !V;  // VC
      4'b1000: eval_cond = C && !Z;  // HI
      4'b1001: eval_cond = !C || Z;  // LS
      4'b1010: eval_cond = (N == V);  // GE
      4'b1011: eval_cond = (N != V);  // LT
      4'b1100: eval_cond = !Z && (N == V);  // GT
      4'b1101: eval_cond = Z || (N != V);  // LE
      4'b1110: eval_cond = 1'b1;  // AL
      4'b1111: eval_cond = 1'b0;  // NV (never)
      default: eval_cond = 1'b0;
    endcase

    $display("eval_cond: cond=%b N=%0b Z=%0b C=%0b V=%0b -> pass=%0b", cond, N, Z, C, V, eval_cond);
    $fflush();
  endfunction

  function automatic word_t read_reg(input cpu_regs_t regs, input cpu_mode_t mode,
                                     input logic [3:0] reg_num);
    unique case (reg_num)

      // R0–R7 : common
      4'd0: read_reg = regs.common.r0;
      4'd1: read_reg = regs.common.r1;
      4'd2: read_reg = regs.common.r2;
      4'd3: read_reg = regs.common.r3;
      4'd4: read_reg = regs.common.r4;
      4'd5: read_reg = regs.common.r5;
      4'd6: read_reg = regs.common.r6;
      4'd7: read_reg = regs.common.r7;

      // R8–R12 : banked only for FIQ
      4'd8:  read_reg = (mode == MODE_FIQ) ? regs.fiq.r8 : regs.user.r8;
      4'd9:  read_reg = (mode == MODE_FIQ) ? regs.fiq.r9 : regs.user.r9;
      4'd10: read_reg = (mode == MODE_FIQ) ? regs.fiq.r10 : regs.user.r10;
      4'd11: read_reg = (mode == MODE_FIQ) ? regs.fiq.r11 : regs.user.r11;
      4'd12: read_reg = (mode == MODE_FIQ) ? regs.fiq.r12 : regs.user.r12;

      // R13 / R14 : fully banked
      4'd13: begin
        unique case (mode)
          MODE_USR, MODE_SYS: read_reg = regs.user.r13;
          MODE_FIQ: read_reg = regs.fiq.r13;
          MODE_SVC: read_reg = regs.supervisor.r13;
          MODE_ABT: read_reg = regs.abort.r13;
          MODE_IRQ: read_reg = regs.irq.r13;
          MODE_UND: read_reg = regs.undefined.r13;
        endcase
      end

      4'd14: begin
        unique case (mode)
          MODE_USR, MODE_SYS: read_reg = regs.user.r14;
          MODE_FIQ: read_reg = regs.fiq.r14;
          MODE_SVC: read_reg = regs.supervisor.r14;
          MODE_ABT: read_reg = regs.abort.r14;
          MODE_IRQ: read_reg = regs.irq.r14;
          MODE_UND: read_reg = regs.undefined.r14;
        endcase
      end

      // R15 : PC (always user)
      4'd15: read_reg = regs.user.r15;

    endcase
  endfunction


  function automatic logic mode_has_spsr(cpu_mode_t mode);
    unique case (mode)
      MODE_FIQ, MODE_IRQ, MODE_SVC, MODE_ABT, MODE_UND: mode_has_spsr = 1'b1;
      MODE_USR, MODE_SYS:                               mode_has_spsr = 1'b0;  // USR/SYS
    endcase
  endfunction

  function automatic word_t read_spsr(input cpu_regs_t regs, input cpu_mode_t mode);
    unique case (mode)
      MODE_FIQ: read_spsr = regs.SPSR.fiq;
      MODE_IRQ: read_spsr = regs.SPSR.irq;
      MODE_SVC: read_spsr = regs.SPSR.supervisor;
      MODE_ABT: read_spsr = regs.SPSR.abort;
      MODE_UND: read_spsr = regs.SPSR.undefined;
      MODE_USR, MODE_SYS: read_spsr = regs.CPSR;  // don't-care; should not be used
    endcase
  endfunction


  function automatic alu_writeback_source_t get_alu_writeback(input alu_op_t opcode);
    case (opcode)
      ALU_OP_CMP, ALU_OP_CMP_NEG, ALU_OP_TEST, ALU_OP_TEST_EXCLUSIVE: begin
        return ALU_WB_NONE;
      end

      default: begin
        return ALU_WB_REG_RD;
      end
    endcase
  endfunction

endpackage : cpu_util_pkg
