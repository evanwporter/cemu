import cpu_types_pkg::*;
import types_pkg::*;

module Decoder (
    input logic clk,
    input logic reset,
    Decoder_if.Decoder_side bus
);

  always_ff @(posedge clk) begin
    if (reset) begin
      // Reset logic here
    end else begin
      if (bus.enable) begin
        bus.word.condition <= condition_t'(bus.IR[31:28]);

        bus.word.Rn <= bus.IR[19:16];
        bus.word.Rd <= bus.IR[15:12];
        bus.word.Rs <= bus.IR[11:8];
        bus.word.Rm <= bus.IR[3:0];

        bus.word.IR <= bus.IR;

        $display("Decoder: Decoding instruction 0x%08x", bus.IR);

        priority casez (bus.IR)
          /// Branch and Branch Exchange
          32'b????_0001_0010_1111_1111_1111_0001_????: begin
            $display("Decoder: Detected BX instruction with IR=0x%08x", bus.IR);
          end

          /// Block Data Transfer
          32'b????_100?_????_????_????_????_????_????: begin
            $display("Decoder: Detected block data transfer instruction with IR=0x%08x", bus.IR);
          end

          /// Branch
          32'b????_1010_????_????_????_????_????_????: begin
            $display("Decoder: Detected B instruction with IR=0x%08x", bus.IR);

          end

          /// Branch with Link
          32'b????_1011_????_????_????_????_????_????: begin
            $display("Decoder: Detected BL instruction with IR=0x%08x", bus.IR);
          end

          /// Software Interrupt
          32'b????_1111_????_????_????_????_????_????: begin
            $display("Decoder: Detected SWI instruction with IR=0x%08x", bus.IR);
          end

          /// Single Data Transfer
          32'b????_011?_????_????_????_????_???1_????: begin
            $display("Decoder: Detected single data transfer instruction with IR=0x%08x", bus.IR);
          end

          /// Single Data Swap
          32'b????_0001_0???_????_????_0000_1001_????: begin
            $display("Decoder: Detected single data swap instruction with IR=0x%08x", bus.IR);
          end

          /// Multiply
          32'b????_0000_0???_????_????_????_1001_????: begin
            $display("Decoder: Detected multiply instruction with IR=0x%08x", bus.IR);
          end

          /// Multiply Long
          32'b????_0000_1???_????_????_????_1001_????: begin
            $display("Decoder: Detected multiply long instruction with IR=0x%08x", bus.IR);
          end

          // Halfword Data Transfer Register
          32'b????_000?_?0??_????_????_0000_1??1_????: begin
            $display("Decoder: Detected halfword data transfer register instruction with IR=0x%08x",
                     bus.IR);
          end

          /// Halfword Data Transfer Immediate
          32'b????_000?_?1??_????_????_????_1??1_????: begin
            $display(
                "Decoder: Detected halfword data transfer immediate instruction with IR=0x%08x",
                bus.IR);
          end

          /// PSR Transfer MSR
          32'b????_0001_0?00_1111_????_????_????_????: begin
            $display("Decoder: Detected MSR instruction with IR=0x%08x", bus.IR);
          end

          /// PSR Transfer MRS
          32'b????_00?1_0?10_????_1111_????_????_????: begin
            $display("Decoder: Detected MRS instruction with IR=0x%08x", bus.IR);
          end

          /// Data Processing
          32'b????_00??_????_????_????_????_????_????: begin

            $display("Decoder: Detected data processing instruction with IR=0x%08x", bus.IR);
            $fflush();

            // Notable bits
            // 2nd Operand
            // 25 (I): indicates whether its an immediate value or a register value
            //  (1) = immediate, (0) = register
            // 4 (R): Shift by register or immediate
            //   (0) = immediate, (1) = register

            // Forms:
            // I=0 R=0: Register with immediate shift
            // I=0 R=1: Register with register shift
            // I=1: Immediate value with rotate

            if (bus.IR[25] == 1'b1) begin
              // Immediate value with rotate
              bus.word.immediate.data_proc_imm.imm8 <= bus.IR[7:0];
              bus.word.immediate.data_proc_imm.rotate <= bus.IR[11:8];
              bus.word.immediate.data_proc_imm.set_flags <= bus.IR[20];
              bus.word.immediate.data_proc_imm.opcode <= bus.IR[24:21];
              bus.word.instr_type <= ARM_INSTR_DATAPROC_IMM;
              $display(
                  "Decoded data processing immediate instruction with opcode=%0d, set_flags=%0b, imm8=0x%02x, rotate=0x%01x",
                  bus.word.immediate.data_proc_imm.opcode,
                  bus.word.immediate.data_proc_imm.set_flags,
                  bus.word.immediate.data_proc_imm.imm8, bus.word.immediate.data_proc_imm.rotate);
            end else if (bus.IR[4] == 1'b0) begin  // bus.IR[25] == 1'b0 is implied
              // Register with immediate shift
              bus.word.immediate.data_proc_reg_imm.shift_amount <= bus.IR[11:7];
              bus.word.immediate.data_proc_reg_imm.shift_type <= shift_type_t'(bus.IR[6:5]);
              bus.word.immediate.data_proc_reg_imm.set_flags <= bus.IR[20];
              bus.word.immediate.data_proc_reg_imm.opcode <= bus.IR[24:21];
              bus.word.instr_type <= ARM_INSTR_DATAPROC_REG_IMM;
            end else begin
              // Register with register shift
              bus.word.immediate.data_proc_reg_reg.shift_type <= shift_type_t'(bus.IR[6:5]);
              bus.word.immediate.data_proc_reg_reg.opcode <= bus.IR[24:21];
              bus.word.immediate.data_proc_reg_reg.set_flags <= bus.IR[20];
              bus.word.instr_type <= ARM_INSTR_DATAPROC_REG_REG;
            end

            bus.word.Rn <= bus.IR[19:16];
            bus.word.Rd <= bus.IR[15:12];
            bus.word.Rs <= bus.IR[11:8];
            bus.word.Rm <= bus.IR[3:0];
          end

          default: begin
            $display("Decoder: Unrecognized instruction with IR=0x%08x", bus.IR);
          end
        endcase
      end
    end
  end

endmodule : Decoder
