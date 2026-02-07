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
    output control_t control_signals
);

  logic [3:0] cycle;

  logic [2:0] flush_cnt;

  wire flushing = flush_cnt != 3'd0;

  logic instr_done;

  /// We only enable the decoder when we are ready to fetch a new instruction.
  assign decoder_bus.enable = instr_done;

  always_ff @(posedge clk) begin
    if (reset) begin
      cycle <= 4'd0;
    end else begin
      if (instr_done) begin
        cycle <= 4'd0;
      end else begin
        cycle <= cycle + 4'd1;
      end
    end
  end

  logic reset_phase;

  always_ff @(posedge clk) begin
    if (reset) begin
      /// Start with a flush so we can fetch the first instruction
      /// This will start flushing next cycle.
      reset_phase <= 1'b1;

      flush_cnt   <= 3'd0;
      $display("ControlUnit: Reset, starting flush");
    end else if (reset_phase) begin
      /// We wait one cycle after reset to start the flush so that we can ensure the system is in a known state before we start flushing instructions.
      flush_cnt   <= 3'd2;
      reset_phase <= 1'b0;
      $display("ControlUnit: Starting flush");
    end else if (flushing) begin
      flush_cnt <= flush_cnt - 3'd1;
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

  always_comb begin
    control_signals = '0;

    instr_done = 1'b0;

    // decoder_bus.enable = 1'b1;

    if (reset_phase) begin
      control_signals.memory_read_en  = 1;
      control_signals.memory_latch_IR = 1;
      control_signals.addr_bus_src    = ADDR_SRC_PC;

    end else if (flush_cnt == 3'd2) begin
      /// Plan for fetch and decode next cycle.
      control_signals.memory_read_en  = 1;
      control_signals.memory_latch_IR = 1;
      control_signals.addr_bus_src    = ADDR_SRC_PC;
      instr_done = 1'b1;

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
            control_signals.alu_writeback =
                get_alu_writeback(alu_op_t'(decoder_bus.word.immediate.data_proc_imm.opcode));

            control_signals.B_bus_source = B_BUS_SRC_IMM;
            control_signals.B_bus_imm = 12'(decoder_bus.word.immediate.data_proc_imm.imm8);

            control_signals.shift_amount = {decoder_bus.word.immediate.data_proc_imm.rotate, 1'b0};

            control_signals.shift_type = SHIFT_ROR;

            control_signals.ALU_op = alu_op_t'(decoder_bus.word.immediate.data_proc_imm.opcode);
            control_signals.ALU_set_flags = decoder_bus.word.immediate.data_proc_imm.set_flags;

            control_signals.memory_latch_IR = 1'b1;
            control_signals.memory_read_en = 1'b1;
            control_signals.incrementer_writeback = 1'b1;
            control_signals.addr_bus_src = ADDR_SRC_PC;

            $display("HERE");
            $fflush();

            instr_done = 1'b1;
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

            control_signals.latch_shift_amt = 1'b1;

          end

          if (cycle == 4'd1) begin
            control_signals.use_shift_latch = 1'b1;

            control_signals.B_bus_source = B_BUS_SRC_REG_RM;

            control_signals.alu_writeback = ALU_WB_REG_RD;

            control_signals.ALU_op = alu_op_t'(decoder_bus.word.immediate.data_proc_imm.opcode);
            control_signals.ALU_set_flags = decoder_bus.word.immediate.data_proc_imm.set_flags;

            `FETCH_NEXT_INSTR(control_signals)

            instr_done = 1'b1;
          end
        end

        // ============================
        // Data Processing (Reg + Imm)
        // ============================

        ARM_INSTR_DATAPROC_REG_IMM: begin
          control_signals.alu_writeback = ALU_WB_REG_RD;

          control_signals.B_bus_source = B_BUS_SRC_REG_RM;

          control_signals.shift_type = decoder_bus.word.immediate.data_proc_reg_imm.shift_type;
          control_signals.shift_amount = decoder_bus.word.immediate.data_proc_reg_imm.shift_amount;

          control_signals.ALU_op = alu_op_t'(decoder_bus.word.immediate.data_proc_reg_imm.opcode);
          control_signals.ALU_set_flags = decoder_bus.word.immediate.data_proc_reg_imm.set_flags;

          `FETCH_NEXT_INSTR(control_signals)

          instr_done = 1'b1;
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

      control_signals.memory_latch_IR = instr_done;

      // `DISPLAY_CONTROL(control_signals)
    end
  end

endmodule : ControlUnit
