import types_pkg::*;
import control_types_pkg::*;
import cpu_types_pkg::*;

module ControlUnit (
    Decoder_if.ControlUnit_side decoder_bus,
    output control_t control_signals
);

  logic [3:0] stage;

  always_comb begin
    control_signals = '0;

    decoder_bus.enable = 1'b1;

    /// Stage 0

    case (decoder_bus.word.instr_type)

      // ============================
      // Data Processing (Immediate)
      // ============================

      ARM_INSTR_DATAPROC_IMM: begin
        if (stage == 4'd0) begin
          control_signals.alu_writeback = ALU_WB_REG_RD;
          control_signals.incrementer_writeback = 1'b1;
          control_signals.addr_bus_src = ADDR_SRC_INCR;

          control_signals.B_bus_source = B_BUS_SRC_IMM;
          control_signals.B_bus_imm = 12'(decoder_bus.word.immediate.data_proc_imm.imm8);

          control_signals.shift_amount = {decoder_bus.word.immediate.data_proc_imm.rotate, 1'b0};

          control_signals.shift_type = SHIFT_ROR;

          control_signals.ALU_op = alu_op_t'(decoder_bus.word.immediate.data_proc_imm.opcode);
          control_signals.set_ALU_flags = decoder_bus.word.immediate.data_proc_imm.set_flags;
        end
      end

      // ============================
      // Data Processing (Reg + Reg)
      // ============================

      ARM_INSTR_DATAPROC_REG_REG: begin
        // Performs one internal cycle
        // Notably we don't fetch or decode this cycle
        if (stage == 4'd0) begin
          decoder_bus.enable = 1'b0;

          control_signals.B_bus_source = B_BUS_SRC_REG_RS;

          control_signals.latch_shift_amt = 1'b1;

        end

        if (stage == 4'd1) begin
          control_signals.use_shift_latch = 1'b1;

          control_signals.B_bus_source = B_BUS_SRC_REG_RM;

          control_signals.alu_writeback = ALU_WB_REG_RD;
          control_signals.incrementer_writeback = 1'b1;
          control_signals.addr_bus_src = ADDR_SRC_INCR;

          control_signals.ALU_op = alu_op_t'(decoder_bus.word.immediate.data_proc_imm.opcode);
          control_signals.set_ALU_flags = decoder_bus.word.immediate.data_proc_imm.set_flags;
        end
      end

      // ============================
      // Data Processing (Reg + Imm)
      // ============================

      ARM_INSTR_DATAPROC_REG_IMM: begin
        control_signals.alu_writeback = ALU_WB_REG_RD;
        control_signals.incrementer_writeback = 1'b1;
        control_signals.addr_bus_src = ADDR_SRC_INCR;

        control_signals.B_bus_source = B_BUS_SRC_REG_RM;

        control_signals.shift_type = decoder_bus.word.immediate.data_proc_reg_imm.shift_type;
        control_signals.shift_amount = decoder_bus.word.immediate.data_proc_reg_imm.shift_amount;

        control_signals.ALU_op = alu_op_t'(decoder_bus.word.immediate.data_proc_reg_imm.opcode);
        control_signals.set_ALU_flags = decoder_bus.word.immediate.data_proc_reg_imm.set_flags;

      end

      // ============================
      // Load / Store (offset only)
      // ============================

      ARM_INSTR_STORE, ARM_INSTR_LOAD: begin
        if (stage == 4'd0) begin
          decoder_bus.enable = 1'b0;

          control_signals.incrementer_writeback = 1'b1;

          /// TODO U and P bits

          control_signals.addr_bus_src = ADDR_SRC_ALU;

          control_signals.ALU_op = decoder_bus.word.immediate.ls.U ? ALU_OP_ADD : ALU_OP_SUB;

          if (decoder_bus.word.immediate.ls.I == ARM_LDR_STR_IMMEDIATE) begin
            control_signals.B_bus_source = B_BUS_SRC_IMM;
            control_signals.B_bus_imm    = decoder_bus.word.immediate.ls.offset.imm12;

            control_signals.shift_type = SHIFT_LSL;
            control_signals.shift_amount = 5'd0;

          end else begin
            control_signals.B_bus_source = B_BUS_SRC_REG_RM;
            control_signals.shift_type = decoder_bus.word.immediate.ls.offset.shifted.shift_type;

            control_signals.shift_type = decoder_bus.word.immediate.ls.offset.shifted.shift_type;
            control_signals.shift_amount = decoder_bus.word.immediate.ls.offset.shifted.shift_amount;
          end
        end

        if (decoder_bus.word.instr_type == ARM_INSTR_LOAD) begin
          decoder_bus.enable = 1'b0;
          if (stage == 4'd1) begin

            /// TODO W and P bits
            if (decoder_bus.word.immediate.ls.wt == 1'b1) begin
              control_signals.alu_writeback = ALU_WB_REG_RN;
            end

            control_signals.alu_writeback = ALU_WB_REG_RN;

            control_signals.addr_bus_src  = ADDR_SRC_PC;

          end
        end

      end

      default: ;
    endcase
  end

endmodule : ControlUnit
