import cpu_types_pkg::*;

module CPU (
    input logic clk,
    input logic reset,

    Bus_if.Master_side bus
);

  word_t IR;

  //   cpu_regs_t regs;

  word_t regs[16];

  Decoder_if decoder_bus (.IR(IR));

  Decoder decoder_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (decoder_bus)
  );

  ALU_if alu_bus ();

  ALU alu_inst (.bus(alu_bus));

  // assign condition = IR[31:28];

  always_comb begin

    alu_bus.op_a = 32'd0;
    alu_bus.op_b = 32'd0;
    alu_bus.alu_op = ALU_OP_ADD;
    alu_bus.set_flags = 1'b0;

    if (decoder_bus.word.instr_type == ARM_INSTR_DATAPROC_IMM) begin
      case (decoder_bus.word.instr_type)
        ARM_INSTR_DATAPROC_IMM: begin
          alu_bus.op_a = regs[decoder_bus.word.Rn];
          alu_bus.op_b = regs[decoder_bus.word.Rm];
          alu_bus.alu_op = alu_op_t'(decoder_bus.word.immediate.data_proc_imm.opcode);
          alu_bus.set_flags = decoder_bus.word.immediate.data_proc_imm.set_flags;
        end

        default: ;
      endcase
    end
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset logic
      IR <= 32'h00000000;
    end else begin
      // Fetch instruction


    end
  end

endmodule : CPU
