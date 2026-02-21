`ifndef CPU_ALU_SVH
`define CPU_ALU_SVH

import gb_cpu_opcodes_pkg::*;
import gb_cpu_types_pkg::*;

typedef struct packed {
  logic [7:0] result;  // The ALU output value
  logic [7:0] flags;  // The full F register (Z N H C ----)
} alu_result_t;

function automatic alu_result_t apply_alu_op(input alu_op_t op, input alu_src_t dst_sel,
                                             input alu_src_t src_sel, input alu_bit_t bit_index,
                                             ref cpu_regs_t regs);
  alu_result_t res;

  // temporary values
  logic [7:0] src_val, dst_val;
  logic [8:0] tmp;  // for carry
  logic zero_flag, carry_flag, half_flag, sub_flag;
  logic [4:0] half_sum;
  logic signed [7:0] signed_val;

  zero_flag  = regs.flags[7];
  sub_flag   = regs.flags[6];
  half_flag  = regs.flags[5];
  carry_flag = regs.flags[4];

  // Select source and destination register values
  unique case (src_sel)
    ALU_SRC_A: src_val = regs.a;
    ALU_SRC_B: src_val = regs.b;
    ALU_SRC_C: src_val = regs.c;
    ALU_SRC_D: src_val = regs.d;
    ALU_SRC_E: src_val = regs.e;
    ALU_SRC_H: src_val = regs.h;
    ALU_SRC_L: src_val = regs.l;

    ALU_SRC_W: src_val = regs.w;
    ALU_SRC_Z: src_val = regs.z;

    ALU_SRC_SP_HIGH: src_val = regs.sph;
    ALU_SRC_SP_LOW:  src_val = regs.spl;

    ALU_SRC_PC_HIGH: src_val = regs.pch;
    ALU_SRC_PC_LOW:  src_val = regs.pcl;

    ALU_SRC_NONE: src_val = 8'h00;
  endcase

  unique case (dst_sel)
    ALU_SRC_A: dst_val = regs.a;
    ALU_SRC_B: dst_val = regs.b;
    ALU_SRC_C: dst_val = regs.c;
    ALU_SRC_D: dst_val = regs.d;
    ALU_SRC_E: dst_val = regs.e;
    ALU_SRC_H: dst_val = regs.h;
    ALU_SRC_L: dst_val = regs.l;

    ALU_SRC_W: dst_val = regs.w;
    ALU_SRC_Z: dst_val = regs.z;

    ALU_SRC_SP_HIGH: dst_val = regs.sph;
    ALU_SRC_SP_LOW:  dst_val = regs.spl;

    ALU_SRC_PC_HIGH: dst_val = regs.pch;
    ALU_SRC_PC_LOW:  dst_val = regs.pcl;

    ALU_SRC_NONE: dst_val = 8'h00;
  endcase

  // Perform operation
  case (op)
    ALU_OP_COPY: dst_val = src_val;

    ALU_OP_ADD: begin
      half_sum      = {1'b0, dst_val[3:0]} + {1'b0, src_val[3:0]};
      half_flag     = half_sum[4];

      tmp           = {1'b0, dst_val} + {1'b0, src_val};
      dst_val       = tmp[7:0];
      carry_flag    = tmp[8];

      sub_flag      = 1'b0;
      zero_flag     = (dst_val == 8'h00);
    end

    ALU_OP_ADC: begin
      half_sum   = {1'b0, dst_val[3:0]} + {1'b0, src_val[3:0]} + {4'b0, regs.flags[4]};
      half_flag  = half_sum[4];

      tmp        = {1'b0, dst_val} + {1'b0, src_val} + {8'b0, regs.flags[4]};
      dst_val    = tmp[7:0];
      carry_flag = tmp[8];

      sub_flag   = 1'b0;
      zero_flag  = (dst_val == 8'h00);
    end

    ALU_OP_SUB: begin
      tmp        = {1'b0, dst_val} - {1'b0, src_val};
      carry_flag = tmp[8];
      half_flag  = ((dst_val[3:0]) < (src_val[3:0]));
      sub_flag   = 1'b1;
      dst_val    = tmp[7:0];
      zero_flag  = (dst_val == 8'h00);
    end

    ALU_OP_SBC: begin
      tmp = {1'b0, dst_val} - {1'b0, src_val} - {8'b0, regs.flags[4]};
      carry_flag = tmp[8];
      half_sum = {1'b0, dst_val[3:0]}
               - {1'b0, src_val[3:0]}
               - {4'b0, regs.flags[4]};
      half_flag = half_sum[4];
      sub_flag = 1'b1;
      dst_val = tmp[7:0];
      zero_flag = (dst_val == 8'h00);
    end

    ALU_OP_AND: begin
      dst_val = dst_val & src_val;
      carry_flag = 1'b0;
      half_flag = 1'b1;
      sub_flag = 1'b0;
      zero_flag = (dst_val == 8'h00);
    end

    ALU_OP_OR: begin
      dst_val    = dst_val | src_val;
      carry_flag = 1'b0;
      half_flag  = 1'b0;
      sub_flag   = 1'b0;
      zero_flag  = (dst_val == 8'h00);
    end

    ALU_OP_XOR: begin
      dst_val    = dst_val ^ src_val;
      carry_flag = 1'b0;
      half_flag  = 1'b0;
      sub_flag   = 1'b0;
      zero_flag  = (dst_val == 8'h00);
    end

    ALU_OP_INC: begin
      dst_val   = dst_val + 8'd1;
      half_flag = ((dst_val[3:0] == 4'h0));  // overflow from bit3->4
      sub_flag  = 1'b0;
      zero_flag = (dst_val == 8'h00);
    end

    ALU_OP_DEC: begin
      dst_val   = dst_val - 8'd1;
      half_flag = ((dst_val[3:0] == 4'hF));  // borrow into bit4
      sub_flag  = 1'b1;
      zero_flag = (dst_val == 8'h00);
    end

    ALU_OP_RR: begin
      carry_flag = dst_val[0];
      dst_val    = {regs.flags[4], dst_val[7:1]};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag = (dst_val == 8'h00);
    end

    ALU_OP_RRC: begin
      carry_flag = dst_val[0];
      dst_val    = {dst_val[0], dst_val[7:1]};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag = (dst_val == 8'h00);
    end

    ALU_OP_RL: begin
      carry_flag = dst_val[7];
      dst_val    = {dst_val[6:0], regs.flags[4]};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag = (dst_val == 8'h00);
    end

    ALU_OP_RLC: begin
      carry_flag = dst_val[7];
      dst_val    = {dst_val[6:0], dst_val[7]};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag = (dst_val == 8'h00);
    end

    ALU_OP_RRA: begin
      carry_flag = dst_val[0];
      dst_val    = {regs.flags[4], dst_val[7:1]};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag = 1'b0;
    end

    ALU_OP_RRCA: begin
      carry_flag = dst_val[0];
      dst_val    = {dst_val[0], dst_val[7:1]};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag = 1'b0;
    end

    ALU_OP_RLA: begin
      carry_flag = dst_val[7];
      dst_val    = {dst_val[6:0], regs.flags[4]};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag = 1'b0;
    end

    ALU_OP_RLCA: begin
      carry_flag = dst_val[7];
      dst_val    = {dst_val[6:0], dst_val[7]};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag = 1'b0;
    end

    ALU_OP_CP: begin
      tmp        = {1'b0, dst_val} - {1'b0, src_val};
      carry_flag = tmp[8];
      half_flag  = ((dst_val[3:0]) < (src_val[3:0]));
      sub_flag   = 1'b1;
      zero_flag  = (tmp[7:0] == 8'h00);
    end

    ALU_OP_ADD_LOW: begin
      half_sum   = {1'b0, dst_val[3:0]} + {1'b0, src_val[3:0]};
      half_flag  = half_sum[4];

      tmp        = {1'b0, dst_val} + {1'b0, src_val};
      dst_val    = tmp[7:0];
      carry_flag = tmp[8];
      sub_flag   = 1'b0;
    end

    ALU_OP_ADD_HIGH: begin
      tmp        = {1'b0, dst_val} + {1'b0, src_val} + {8'b0, regs.flags[4]};
      half_sum   = {1'b0, dst_val[3:0]} + {1'b0, src_val[3:0]} + {4'b0, regs.flags[4]};
      dst_val    = tmp[7:0];
      carry_flag = tmp[8];
      half_flag  = half_sum[4];
      sub_flag   = 1'b0;
    end

    ALU_OP_ADD_SIGNED_LOW: begin
      regs.e8_sign = dst_val[7];

      half_sum   = {1'b0, dst_val[3:0]} + {1'b0, src_val[3:0]};
      half_flag  = half_sum[4];

      tmp        = {1'b0, dst_val} + {1'b0, src_val};
      dst_val    = tmp[7:0];
      carry_flag = tmp[8];
      
      sub_flag   = 1'b0;
      zero_flag  = 1'b0;
    end

    ALU_OP_ADD_SIGNED_HIGH: begin
      tmp = {1'b0, src_val} - {1'b0, regs.e8_sign ? 8'h01 : 8'h00} + {8'b0, carry_flag};

      dst_val = tmp[7:0];
    end

    ALU_OP_SCF: begin
      carry_flag = 1'b1;
      half_flag  = 1'b0;
      sub_flag   = 1'b0;
    end

    ALU_OP_CCF: begin
      carry_flag = ~regs.flags[4];
      half_flag  = 1'b0;
      sub_flag   = 1'b0;
    end

    ALU_OP_SLA: begin
      carry_flag = dst_val[7];
      dst_val    = {dst_val[6:0], 1'b0};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag  = (dst_val == 8'h00);
    end

    ALU_OP_SRA: begin
      carry_flag = dst_val[0];
      dst_val    = {dst_val[7], dst_val[7:1]};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag  = (dst_val == 8'h00);
    end

    ALU_OP_SRL: begin
      carry_flag = dst_val[0];
      dst_val    = {1'b0, dst_val[7:1]};
      sub_flag   = 1'b0;
      half_flag  = 1'b0;
      zero_flag  = (dst_val == 8'h00);
    end

    ALU_OP_SWAP: begin
      dst_val    = {dst_val[3:0], dst_val[7:4]};
      carry_flag = 1'b0;
      half_flag  = 1'b0;
      sub_flag   = 1'b0;
      zero_flag  = (dst_val == 8'h00);
    end

    ALU_OP_BIT: begin
      logic bitval;
      bitval = src_val[bit_index];
      zero_flag = (bitval == 1'b0);
      sub_flag = 1'b0;
      half_flag = 1'b1;
    end

    ALU_OP_RES: begin
      dst_val = src_val & ~(8'd1 << bit_index);
    end

    ALU_OP_SET: begin
      dst_val = src_val | (8'd1 << bit_index);
    end

    ALU_OP_CPL: begin
      dst_val   = ~src_val;
      sub_flag  = 1'b1;
      half_flag = 1'b1;
    end

    ALU_OP_DAA: begin
      logic [7:0] correction;
      correction = 8'h00;

      if (!sub_flag) begin
        if (carry_flag || dst_val > 8'h99) begin
          correction |= 8'h60;
          carry_flag = 1'b1;
        end
        if (half_flag || (dst_val[3:0] > 4'h9)) begin
          correction |= 8'h06;
        end
        dst_val = dst_val + correction;
      end else begin
        if (carry_flag) correction |= 8'h60;
        if (half_flag)  correction |= 8'h06;
        dst_val = dst_val - correction;
      end

      zero_flag = (dst_val == 8'h00);
      half_flag = 1'b0;
    end

    ALU_OP_NONE: ;  // do nothing

    // TODO: Remove default
    default: ;  // ALU_OP_NONE
  endcase

  res.result = dst_val;
  res.flags  = {zero_flag, sub_flag, half_flag, carry_flag, 4'b0000};
  return res;
endfunction

`define APPLY_ALU_OP(OP, DST_SEL, SRC_SEL, BIT, REGS) \
  begin : apply_alu_op_block \
    alu_result_t __alu_res; \
    __alu_res = apply_alu_op(OP, DST_SEL, SRC_SEL, BIT, REGS); \
    `LOG_TRACE(("[CPU] Applying ALU op %s to %s from %s", \
             (OP).name(), (DST_SEL).name(), (SRC_SEL).name())); \
    unique case (DST_SEL) \
      ALU_SRC_A: (REGS).a <= __alu_res.result; \
      ALU_SRC_B: (REGS).b <= __alu_res.result; \
      ALU_SRC_C: (REGS).c <= __alu_res.result; \
      ALU_SRC_D: (REGS).d <= __alu_res.result; \
      ALU_SRC_E: (REGS).e <= __alu_res.result; \
      ALU_SRC_H: (REGS).h <= __alu_res.result; \
      ALU_SRC_L: (REGS).l <= __alu_res.result; \
      ALU_SRC_W: (REGS).w <= __alu_res.result; \
      ALU_SRC_Z: (REGS).z <= __alu_res.result; \
      ALU_SRC_SP_HIGH: (REGS).sph <= __alu_res.result; \
      ALU_SRC_SP_LOW:  (REGS).spl <= __alu_res.result; \
      ALU_SRC_PC_HIGH: (REGS).pch <= __alu_res.result; \
      ALU_SRC_PC_LOW:  (REGS).pcl <= __alu_res.result; \
      ALU_SRC_NONE: ; \
    endcase \
    (REGS).flags <= __alu_res.flags; \
  end

`endif
