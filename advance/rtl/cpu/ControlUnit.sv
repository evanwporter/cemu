import control_types_pkg::*;
import cpu_types_pkg::*;

`include "cpu/util.svh"

// In the future just add these signals when instr_done goes high
`define FETCH_NEXT_INSTR(ctrl)        \
  ctrl.memory_latch_IR = 1'b1;        \
  ctrl.memory_read_en= 1'b1;          \
  ctrl.incrementer_writeback = 1'b1;  \
  ctrl.addr_bus_src= ADDR_SRC_PC;

module ControlUnit (
    input logic clk,
    input logic reset,
    Decoder_if.ControlUnit_side decoder_bus,
    output control_t control_signals,
    input flush_req
);

  logic [3:0] cycle;

  logic [2:0] flush_cnt;

  /// We only enable the decoder when we are ready to fetch a new instruction.
  assign decoder_bus.enable = control_signals.instr_done;

  always_ff @(posedge clk) begin
    if (reset) begin
      cycle <= 4'd0;
    end else begin
      if (control_signals.instr_done) begin
        $display("\nControlUnit: Instruction complete, preparing for next instruction");
        cycle <= 4'd0;
      end else begin
        cycle <= cycle + 4'd1;
        $display("\nControlUnit: Instruction not complete");
      end
    end
  end

  /// After cycle 0, the decoded word may no longer be valid, so we latch it.
  decoded_word_t curr_instr;

  always_ff @(posedge clk) begin
    if (reset) begin
    end else if (cycle == 4'd0) begin
      curr_instr <= decoder_bus.word;
    end
  end

  always_ff @(posedge clk) begin
    if (reset) begin
      /// Start with a flush so we can fetch the first instruction
      /// This will start flushing next cycle.
      flush_cnt <= 3'd3;
      $display("ControlUnit: Reset, starting flush");
      $fflush();
    end else if (flush_req) begin
      flush_cnt <= 3'd1;
      $display("ControlUnit: Flush requested, starting flush");
      $fflush();

    end else if (flush_cnt != 3'd0) begin
      flush_cnt <= flush_cnt - 3'd1;
      $display("ControlUnit: Flushing, %0d cycles of flush remaining", flush_cnt);
      $fflush();
    end
  end

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

  always_ff @(posedge clk) begin
    if (decoder_bus.word.instr_type == ARM_INSTR_DATAPROC_IMM) begin
      `DISPLAY_DECODED_DATAPROC_IMM(decoder_bus.word)
    end else if (decoder_bus.word.instr_type == ARM_INSTR_DATAPROC_REG_IMM) begin
      `DISPLAY_DECODED_DATAPROC_REG_IMM(decoder_bus.word)
    end else if (decoder_bus.word.instr_type == ARM_INSTR_DATAPROC_REG_REG) begin
      `DISPLAY_DECODED_DATAPROC_REG_REG(decoder_bus.word)
    end
  end

  always_comb begin
    control_signals = '0;

    control_signals.instr_done = 1'b0;

    // decoder_bus.enable = 1'b1;

    if (flush_cnt == 3'd3) begin
      /// Start by writing the Address to PC

      control_signals.addr_bus_src = ADDR_SRC_PC;

      $display("ControlUnit: In reset phase, preparing for flush");
      $fflush();

    end else if (flush_cnt == 3'd2 || flush_req) begin
      /// Plan for fetch and decode next cycle.
      control_signals.memory_read_en = 1;
      control_signals.memory_latch_IR = 1;
      control_signals.incrementer_writeback = 1;
      control_signals.addr_bus_src = ADDR_SRC_INCR;

      $display("\nControlUnit: Flush cycle 1, fetching instruction");
      $fflush();

    end else if (flush_cnt == 3'd1) begin
      control_signals.memory_read_en = 1;
      control_signals.memory_latch_IR = 1;
      control_signals.incrementer_writeback = 1;
      control_signals.addr_bus_src = ADDR_SRC_PC;
      control_signals.instr_done = 1'b1;

      $display("ControlUnit: Flush cycle 2, flushing instruction");
      $fflush();

    end else begin

      case (decoder_bus.word.instr_type)

        // ============================
        // Data Processing (Immediate)
        // ============================

        ARM_INSTR_DATAPROC_IMM: begin
          $display("ControlUnit: Decoding data processing immediate instruction with IR=0x%08x",
                   decoder_bus.word.IR);
          $fflush();

          if (cycle == 4'd0) begin
            control_signals.B_bus_source = B_BUS_SRC_IMM;
            control_signals.B_bus_imm = 12'(decoder_bus.word.immediate.data_proc_imm.imm8);

            control_signals.shift_amount = {decoder_bus.word.immediate.data_proc_imm.rotate, 1'b0};

            control_signals.shift_type = SHIFT_ROR;

            control_signals.ALU_op = alu_op_t'(decoder_bus.word.immediate.data_proc_imm.opcode);

            if (decoder_bus.word.condition_pass) begin
              $display("ControlUnit: Condition passed, executing instruction");
              control_signals.alu_writeback =
                  get_alu_writeback(alu_op_t'(decoder_bus.word.immediate.data_proc_imm.opcode));
              control_signals.ALU_set_flags = decoder_bus.word.immediate.data_proc_imm.set_flags;
              $display("ControlUnit: ALU writeback source=%0d, set_flags=%b",
                       control_signals.alu_writeback, control_signals.ALU_set_flags);
            end

            control_signals.instr_done = 1'b1;

            control_signals.addr_bus_src = ADDR_SRC_PC;
            control_signals.memory_latch_IR = 1'b1;
            control_signals.memory_read_en = 1'b1;
            control_signals.incrementer_writeback = 1'b1;

            $display("ControlUnit: Decoding complete, preparing for next instruction");
          end
        end

        // ============================
        // Data Processing (Reg + Reg)
        // ============================

        ARM_INSTR_DATAPROC_REG_REG: begin
          // Performs one internal cycle
          // Notably we don't fetch or decode this cycle
          if (cycle == 4'd0) begin
            // decoder_bus.enable = 1'b0;

            control_signals.B_bus_source = B_BUS_SRC_REG_RS;

            control_signals.shift_latch_amt = 1'b1;

            $display("ControlUnit: Instr done is %b, cycle is %0d", control_signals.instr_done,
                     cycle);

            if (cycle == 4'd1 && decoder_bus.word.Rs == 4'd15) begin
              control_signals.pc_rs_add_4 = 1'b1;
              $display("ControlUnit: Rs is PC, adding 4 to value read from Rs");
            end

            // if (!decoder_bus.word.condition_pass) begin
            //   control_signals.instr_done = 1'b1;

            //   $display("ControlUnit: Condition failed, skipping instruction");
            // end
          end

          if (cycle == 4'd1) begin
            control_signals.shift_use_latch = 1'b1;

            control_signals.B_bus_source = B_BUS_SRC_REG_RM;

            control_signals.shift_type = curr_instr.immediate.data_proc_reg_reg.shift_type;
            control_signals.shift_use_latch = 1'b1;

            control_signals.ALU_op = alu_op_t'(curr_instr.immediate.data_proc_reg_reg.opcode);

            if (curr_instr.condition_pass) begin
              control_signals.alu_writeback =
                  get_alu_writeback(alu_op_t'(curr_instr.immediate.data_proc_reg_reg.opcode));
              control_signals.ALU_set_flags = curr_instr.immediate.data_proc_reg_reg.set_flags;
            end

            if (cycle == 4'd1 && curr_instr.Rn == 4'd15) begin
              control_signals.pc_rn_add_4 = 1'b1;
            end

            if (cycle == 4'd1 && curr_instr.Rm == 4'd15) begin
              control_signals.pc_rm_add_4 = 1'b1;
            end

            $display("ControlUnit: 2 Instr done is %b, cycle is %0d", control_signals.instr_done,
                     cycle);

            `FETCH_NEXT_INSTR(control_signals)

            control_signals.instr_done = 1'b1;
          end
        end

        // ============================
        // Data Processing (Reg + Imm)
        // ============================

        ARM_INSTR_DATAPROC_REG_IMM: begin

          control_signals.B_bus_source = B_BUS_SRC_REG_RM;

          control_signals.shift_type = decoder_bus.word.immediate.data_proc_reg_imm.shift_type;
          control_signals.shift_amount = decoder_bus.word.immediate.data_proc_reg_imm.shift_amount;

          control_signals.ALU_op = alu_op_t'(decoder_bus.word.immediate.data_proc_reg_imm.opcode);

          if (decoder_bus.word.condition_pass) begin
            control_signals.alu_writeback =
                get_alu_writeback(alu_op_t'(decoder_bus.word.immediate.data_proc_reg_imm.opcode));
            control_signals.ALU_set_flags = decoder_bus.word.immediate.data_proc_reg_imm.set_flags;
          end

          if (decoder_bus.word.immediate.data_proc_reg_imm.shift_type == SHIFT_ROR &&
              decoder_bus.word.immediate.data_proc_reg_imm.shift_amount == 5'd0) begin
            // Register shift-immediate encoding: ROR #0 => RRX
            control_signals.shift_use_rxx = 1'b1;
          end

          `FETCH_NEXT_INSTR(control_signals)

          control_signals.instr_done = 1'b1;
        end

        // ============================
        // Load / Store (offset only)
        // ============================

        ARM_INSTR_STORE, ARM_INSTR_LOAD: begin
          if (cycle == 4'd0) begin
            // decoder_bus.enable = 1'b0;

            control_signals.incrementer_writeback = 1'b1;

            /// TODO U and P bits

            control_signals.addr_bus_src = ADDR_SRC_ALU;

            control_signals.ALU_op = decoder_bus.word.immediate.ls.U ? ALU_OP_ADD : ALU_OP_SUB;

            /// If its pre offset we add/subtract the offset to the base register before the memory access
            if (decoder_bus.word.immediate.ls.P == ARM_LDR_STR_PRE_OFFSET) begin
              if (decoder_bus.word.immediate.ls.wt == 1'b1) begin
                /// Updating the base register with the offset is enabled so we 
                /// latch operand b for the writeback in the next cycle
                control_signals.ALU_latch_op_b = 1'b1;
              end
            end else begin
              /// Post offset, so we don't add/subtract operand b
              /// before its used to update the address bus
              control_signals.ALU_disable_op_b = 1'b1;

              /// We also make sure to latch operand b so that we can 
              /// use it for the writeback in the next cycle
              control_signals.ALU_latch_op_b   = 1'b1;
            end

            /// Depending on the instruction, operand b can either be an immediate or a register with optional shift
            if (decoder_bus.word.immediate.ls.I == ARM_LDR_STR_IMMEDIATE) begin
              /// Immediate offset with an optional rotation/shift

              control_signals.B_bus_source = B_BUS_SRC_IMM;
              control_signals.B_bus_imm    = decoder_bus.word.immediate.ls.offset.imm12;

              control_signals.shift_type = SHIFT_LSL;
              control_signals.shift_amount = 5'd0;

            end else begin
              /// We are using a register offset with an optional shift

              control_signals.B_bus_source = B_BUS_SRC_REG_RM;
              control_signals.shift_type = decoder_bus.word.immediate.ls.offset.shifted.shift_type;
              control_signals.shift_amount = decoder_bus.word.immediate.ls.offset.shifted.shift_amount;
            end
          end

          if (decoder_bus.word.instr_type == ARM_INSTR_LOAD) begin
            // decoder_bus.enable = 1'b0;
            if (cycle == 4'd1) begin

              /// TODO W and P bits
              if (decoder_bus.word.immediate.ls.P == ARM_LDR_STR_POST_OFFSET 
              || decoder_bus.word.immediate.ls.wt == 1'b1) begin
                /// Since we are writing back to the base register, 
                /// we need to make sure to use the offset for the writeback
                /// which we latched in the previous cycle
                control_signals.ALU_use_op_b_latch = 1'b1;
                control_signals.alu_writeback = ALU_WB_REG_RN;
              end

              control_signals.alu_writeback = ALU_WB_REG_RN;

              control_signals.addr_bus_src  = ADDR_SRC_PC;

            end
          end

        end

        default: ;
      endcase

      // if (flush_required) begin
      //   control_signals.memory_latch_IR = 1'b0;
      //   control_signals.memory_read_en = 1'b0;
      //   control_signals.incrementer_writeback = 1'b0;
      // end

      // `DISPLAY_CONTROL(control_signals)
    end
  end

endmodule : ControlUnit
