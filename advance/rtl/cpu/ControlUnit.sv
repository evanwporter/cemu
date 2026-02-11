import control_types_pkg::*;
import cpu_types_pkg::*;

`include "cpu/util.svh"

// In the future just add these signals when pipeline_advance goes high
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

  /// Cycle counter to keep track of which cycle of the instruction we are on
  logic [3:0] cycle;

  logic [2:0] flush_cnt;

  /// We only enable the decoder when we are ready to fetch a new instruction.
  assign decoder_bus.pipeline_advance = control_signals.pipeline_advance;

  always_ff @(posedge clk) begin
    if (reset) begin
      cycle <= 4'd0;
    end else begin
      if (control_signals.pipeline_advance) begin
        $display("\nControlUnit: Instruction complete, preparing for next instruction");
        cycle <= 4'd0;
      end else begin
        cycle <= cycle + 4'd1;
        $display("\nControlUnit: Instruction not complete");
      end
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

  always_ff @(posedge clk) begin
    if (decoder_bus.word.instr_type == ARM_INSTR_DATAPROC_IMM) begin
      `DISPLAY_DECODED_DATAPROC_IMM(decoder_bus.word)
    end else if (decoder_bus.word.instr_type == ARM_INSTR_DATAPROC_REG_IMM) begin
      `DISPLAY_DECODED_DATAPROC_REG_IMM(decoder_bus.word)
    end else if (decoder_bus.word.instr_type == ARM_INSTR_DATAPROC_REG_REG) begin
      `DISPLAY_DECODED_DATAPROC_REG_REG(decoder_bus.word)
    end else if (decoder_bus.word.instr_type == ARM_INSTR_LOAD || decoder_bus.word.instr_type == ARM_INSTR_STORE) begin
      `DISPLAY_DECODED_LS(decoder_bus.word)
    end
  end

  always_comb begin
    control_signals = '0;

    control_signals.pipeline_advance = 1'b0;

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
      control_signals.pipeline_advance = 1'b1;

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
              control_signals.ALU_writeback = cpu_util_pkg::get_alu_writeback(
                  alu_op_t'(decoder_bus.word.immediate.data_proc_imm.opcode));
              control_signals.ALU_set_flags = decoder_bus.word.immediate.data_proc_imm.set_flags;
              $display("ControlUnit: ALU writeback source=%0d, set_flags=%b",
                       control_signals.ALU_writeback, control_signals.ALU_set_flags);
            end

            control_signals.pipeline_advance = 1'b1;

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

            $display("ControlUnit: Instr done is %b, cycle is %0d",
                     control_signals.pipeline_advance, cycle);

            if (cycle == 4'd1 && decoder_bus.word.Rs == 4'd15) begin
              control_signals.pc_rs_add_4 = 1'b1;
              $display("ControlUnit: Rs is PC, adding 4 to value read from Rs");
            end
          end

          if (cycle == 4'd1) begin
            control_signals.shift_use_latch = 1'b1;

            control_signals.B_bus_source = B_BUS_SRC_REG_RM;

            control_signals.shift_type = decoder_bus.word.immediate.data_proc_reg_reg.shift_type;
            control_signals.shift_use_latch = 1'b1;

            control_signals.ALU_op = alu_op_t'(decoder_bus.word.immediate.data_proc_reg_reg.opcode);

            if (decoder_bus.word.condition_pass) begin
              control_signals.ALU_writeback = cpu_util_pkg::get_alu_writeback(
                  alu_op_t'(decoder_bus.word.immediate.data_proc_reg_reg.opcode));
              control_signals.ALU_set_flags = decoder_bus.word.immediate.data_proc_reg_reg.set_flags;
            end

            if (cycle == 4'd1 && decoder_bus.word.Rn == 4'd15) begin
              control_signals.pc_rn_add_4 = 1'b1;
            end

            if (cycle == 4'd1 && decoder_bus.word.Rm == 4'd15) begin
              control_signals.pc_rm_add_4 = 1'b1;
            end

            $display("ControlUnit: 2 Instr done is %b, cycle is %0d",
                     control_signals.pipeline_advance, cycle);

            `FETCH_NEXT_INSTR(control_signals)

            control_signals.pipeline_advance = 1'b1;
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
            control_signals.ALU_writeback = cpu_util_pkg::get_alu_writeback(
                alu_op_t'(decoder_bus.word.immediate.data_proc_reg_imm.opcode));
            control_signals.ALU_set_flags = decoder_bus.word.immediate.data_proc_reg_imm.set_flags;
          end

          if (decoder_bus.word.immediate.data_proc_reg_imm.shift_type == SHIFT_ROR &&
              decoder_bus.word.immediate.data_proc_reg_imm.shift_amount == 5'd0) begin
            // Register shift-immediate encoding: ROR #0 => RRX
            control_signals.shift_use_rxx = 1'b1;
          end

          `FETCH_NEXT_INSTR(control_signals)

          control_signals.pipeline_advance = 1'b1;
        end

        // ============================
        // Load / Store (offset only)
        // ============================

        ARM_INSTR_STORE, ARM_INSTR_LOAD: begin
          if (cycle == 4'd0) begin
            $display("ControlUnit: Cycle 0 of load/store instruction, calculating address");

            // Perform a fetch in this cycle
            control_signals.memory_latch_IR = 1'b1;
            control_signals.memory_read_en = 1'b1;

            // Write PC with Address + 1.
            // This ensures that we can return to the correct address after 
            // the memory access is complete.
            control_signals.incrementer_writeback = 1'b1;

            // Update the address bus to use the output of the ALU, which 
            // will is the effective address for the memory access
            control_signals.addr_bus_src = ADDR_SRC_ALU;

            // Subtract (0) or add (1) the offset to the base register depending 
            // on the U bit in the instruction.
            control_signals.ALU_op = decoder_bus.word.immediate.ls.U ? ALU_OP_ADD : ALU_OP_SUB;

            // If its pre offset we add/subtract the offset to the base register before the memory access
            if (decoder_bus.word.immediate.ls.P == ARM_LDR_STR_PRE_OFFSET) begin
              if (decoder_bus.word.immediate.ls.wt == 1'b1) begin
                // Updating the base register with the offset is enabled so we 
                // latch operand b for the writeback in the next cycle
                control_signals.ALU_latch_op_b = 1'b1;
              end
            end else begin
              // Post offset, so we don't add/subtract operand b
              // before its used to update the address bus
              control_signals.ALU_disable_op_b = 1'b1;

              // We also make sure to latch operand b so that we can 
              // use it for the writeback in the next cycle
              control_signals.ALU_latch_op_b   = 1'b1;
            end

            // Depending on the instruction, operand b can either be an immediate or 
            // a register with optional shift
            if (decoder_bus.word.immediate.ls.I == ARM_LDR_STR_IMMEDIATE) begin
              // Immediate offset with an optional rotation/shift

              control_signals.B_bus_source = B_BUS_SRC_IMM;
              control_signals.B_bus_imm = decoder_bus.word.immediate.ls.offset.imm12;

              // No shift
              control_signals.shift_type = SHIFT_LSL;
              control_signals.shift_amount = 5'd0;

            end else begin
              // We are using a register offset with an optional shift

              control_signals.B_bus_source = B_BUS_SRC_REG_RM;
              control_signals.shift_type = decoder_bus.word.immediate.ls.offset.shifted.shift_type;
              control_signals.shift_amount = decoder_bus.word.immediate.ls.offset.shifted.shift_amount;

              if (decoder_bus.word.immediate.data_proc_reg_imm.shift_type == SHIFT_ROR &&
                  decoder_bus.word.immediate.data_proc_reg_imm.shift_amount == 5'd0) begin
                // Register shift-immediate encoding: ROR #0 => RRX
                control_signals.shift_use_rxx = 1'b1;
              end
            end
          end

          if (decoder_bus.word.instr_type == ARM_INSTR_LOAD) begin

            if (cycle == 4'd1) begin

              $display(
                  "ControlUnit: Cycle 1 of load instruction, address calculation done, preparing for memory read and writeback");

              control_signals.ALU_op = decoder_bus.word.immediate.ls.U ? ALU_OP_ADD : ALU_OP_SUB;

              // Do we writeback?
              if (decoder_bus.word.condition_pass &&
                  (decoder_bus.word.immediate.ls.P == ARM_LDR_STR_POST_OFFSET 
                  || decoder_bus.word.immediate.ls.wt == 1'b1)) begin
                // Since we are writing back to the base register, 
                // we need to make sure to use the offset for the writeback
                // which we latched in the previous cycle
                control_signals.ALU_use_op_b_latch = 1'b1;
                control_signals.ALU_writeback = ALU_WB_REG_RN;

                $display("ControlUnit: Load instruction requires writeback to base register R%0d",
                         decoder_bus.word.Rn);
              end

              control_signals.memory_byte_transfer = decoder_bus.word.immediate.ls.B;

              control_signals.memory_read_en = 1'b1;

              // Load the PC back into the address bus
              control_signals.addr_bus_src = ADDR_SRC_PC;

            end

            if (cycle == 4'd2) begin
              $display(
                  "ControlUnit: Cycle 2 of load instruction, latching read data and preparing for writeback");

              control_signals.pipeline_advance = 1'b1;

              // Allows op B to pass through the ALU unmodified
              control_signals.ALU_op = ALU_OP_MOV;

              // Uses the value read from memory as the value to write 
              // back to the register file
              control_signals.B_bus_source = B_BUS_SRC_READ_DATA;

              if (decoder_bus.word.condition_pass) begin
                // Write back to Rd from the ALU output, which is the 
                // value read from memory
                control_signals.ALU_writeback = ALU_WB_REG_RD;
              end

              control_signals.memory_byte_transfer = decoder_bus.word.immediate.ls.B;

              // Load the PC back into the address bus
              control_signals.addr_bus_src = ADDR_SRC_PC;

            end
          end

          if (decoder_bus.word.instr_type == ARM_INSTR_STORE) begin
            if (cycle == 4'd1) begin
              control_signals.pipeline_advance = 1'b1;

              control_signals.B_bus_source = B_BUS_SRC_REG_RD;

              control_signals.ALU_op = decoder_bus.word.immediate.ls.U ? ALU_OP_ADD : ALU_OP_SUB;

              control_signals.memory_write_en = 1'b1;

              // Do we writeback?
              if (decoder_bus.word.condition_pass &&
                  (decoder_bus.word.immediate.ls.P == ARM_LDR_STR_POST_OFFSET 
                   || decoder_bus.word.immediate.ls.wt == 1'b1)) begin
                // Since we are writing back to the base register, 
                // we need to make sure to use the offset for the writeback
                // which we latched in the previous cycle
                control_signals.ALU_use_op_b_latch = 1'b1;
                control_signals.ALU_writeback = ALU_WB_REG_RN;

                $display("ControlUnit: Store instruction requires writeback to base register R%0d",
                         decoder_bus.word.Rn);
              end

              // Load the PC back into the address bus
              control_signals.addr_bus_src = ADDR_SRC_PC;
            end
          end
        end

        default: ;
      endcase
    end
  end

endmodule : ControlUnit
