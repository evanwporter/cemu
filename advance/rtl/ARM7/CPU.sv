import cpu_types_pkg::*;
import control_types_pkg::*;
import types_pkg::*;

module CPU (
    input logic clk,
    input logic reset,

    Bus_if.Master_side bus
);

  control_t control_signals;

  word_t IR;

  word_t regs[16];

  Decoder_if decoder_bus (.IR(IR));

  Decoder decoder_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (decoder_bus)
  );

  ALU_if alu_bus ();
  Shifter_if shifter_bus ();

  ALU alu_inst (
      .bus(alu_bus),
      .shifter_bus(shifter_bus)
  );

  BarrelShifter shifter_inst (.bus(shifter_bus));

  word_t B_bus;

  always_comb begin
    // Default control signals
    control_signals.incrementer_writeback = 1'b0;
    control_signals.alu_writeback         = 1'b0;
  end

  always_comb begin
    unique case (control_signals.B_bus_source)
      B_BUS_SRC_NONE: begin
        B_bus = 32'd0;
      end

      B_BUS_SRC_IMM: begin
        B_bus = 32'd0;
      end

      B_BUS_SRC_READ_DATA: begin
        B_bus = bus.rdata;
      end

      B_BUS_SRC_REG: begin
        B_bus = regs[decoder_bus.word.Rm];
      end
    endcase
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
    end else begin
      if (control_signals.incrementer_writeback) begin
        // PC = PC + 4
        regs[15] <= regs[15] + 32'd4;
      end

      if (control_signals.alu_writeback) begin
        // Write back ALU result to Rd
        regs[decoder_bus.word.Rd] <= alu_bus.result;
      end

      unique case (control_signals.addr_bus_src)
        ADDR_SRC_NONE: begin
          bus.addr <= 32'd0;
        end

        ADDR_SRC_INCR: begin
          bus.addr <= bus.addr + 32'd4;
        end

        ADDR_SRC_ALU: begin
          bus.addr <= alu_bus.result;
        end

        ADDR_SRC_PC: begin
          // PC
          bus.addr <= regs[15];
        end
      endcase
    end
  end

  always_comb begin

    unique case (control_signals.shift_source)
      SHIFT_SRC_NONE: begin
        shifter_bus.Rm = 32'd0;
      end

      SHIFT_SRC_IMM: begin
        shifter_bus.Rm = {27'd0, decoder_bus.word.immediate.data_proc_reg_imm.shift_amount};
      end

      SHIFT_SRC_REG: begin
        shifter_bus.Rm = regs[decoder_bus.word.Rs];
      end
    endcase

    alu_bus.op_a = 32'd0;
    alu_bus.alu_op = ALU_OP_ADD;
    alu_bus.set_flags = 1'b0;

    shifter_bus.Rm = 32'd0;
    shifter_bus.shift_amount = 5'd0;
    shifter_bus.shift_type = SHIFT_LSL;


    case (decoder_bus.word.instr_type)
      ARM_INSTR_DATAPROC_IMM: begin
        shifter_bus.Rm = {24'd0, decoder_bus.word.immediate.data_proc_imm.imm8};
        shifter_bus.shift_type = SHIFT_ROR;
        shifter_bus.shift_amount = decoder_bus.word.immediate.data_proc_imm.rotate << 1;

        alu_bus.op_a = regs[decoder_bus.word.Rn];

        alu_bus.alu_op = alu_op_t'(decoder_bus.word.immediate.data_proc_imm.opcode);
        alu_bus.set_flags = decoder_bus.word.immediate.data_proc_imm.set_flags;
      end

      ARM_INSTR_DATAPROC_REG_IMM: begin
        shifter_bus.shift_amount = decoder_bus.word.immediate.data_proc_reg_imm.shift_amount;
        shifter_bus.shift_type = decoder_bus.word.immediate.data_proc_reg_imm.shift_type;
        shifter_bus.Rm = regs[decoder_bus.word.Rm];

        alu_bus.op_a = regs[decoder_bus.word.Rn];

        alu_bus.alu_op = alu_op_t'(decoder_bus.word.immediate.data_proc_reg_imm.opcode);
        alu_bus.set_flags = decoder_bus.word.immediate.data_proc_reg_imm.set_flags;
      end

      ARM_INSTR_DATAPROC_REG_REG: begin
        shifter_bus.shift_amount = regs[decoder_bus.word.Rs][4:0];
        shifter_bus.shift_type = decoder_bus.word.immediate.data_proc_reg_reg.shift_type;
        shifter_bus.Rm = regs[decoder_bus.word.Rm];

        alu_bus.op_a = regs[decoder_bus.word.Rn];

        alu_bus.alu_op = alu_op_t'(decoder_bus.word.immediate.data_proc_reg_reg.opcode);
        alu_bus.set_flags = decoder_bus.word.immediate.data_proc_reg_reg.set_flags;
      end

      ARM_INSTR_LOAD: begin
        word_t EA;
        word_t writeback_value;

        // Offset generation (ALWAYS through shifter)
        if (decoder_bus.word.immediate.ls.I == ARM_LDR_STR_IMMEDIATE) begin
          shifter_bus.Rm = {20'd0, decoder_bus.word.immediate.ls.offset.imm12};
          shifter_bus.shift_type = SHIFT_LSL;
          shifter_bus.shift_amount = 5'd0;
        end else begin
          shifter_bus.Rm = regs[decoder_bus.word.Rm];
          shifter_bus.shift_type = decoder_bus.word.immediate.ls.offset.shifted.shift_type;
          shifter_bus.shift_amount = decoder_bus.word.immediate.ls.offset.shifted.shift_amount;
        end

        // --------------------------------------------------------
        // ALU computes Rn ± offset
        // --------------------------------------------------------
        alu_bus.op_a = regs[decoder_bus.word.Rn];

        alu_bus.alu_op = decoder_bus.word.immediate.ls.U ? ALU_OP_ADD : ALU_OP_SUB;

        alu_bus.set_flags = 1'b0;

        // --------------------------------------------------------
        // Pre/Post indexing EA select
        // --------------------------------------------------------
        if (decoder_bus.word.immediate.ls.P == ARM_LDR_STR_PRE_OFFSET) begin
          EA = alu_bus.result;
          writeback_value = alu_bus.result;
        end else begin
          EA = regs[decoder_bus.word.Rn];
          writeback_value = alu_bus.result;
        end
      end

      default: ;
    endcase
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset logic
      IR <= 32'd0;
    end else begin
      // Fetch instruction


    end
  end

endmodule : CPU
