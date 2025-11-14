`ifndef CPU_ALU_SV
`define CPU_ALU_SV 

module ALU (
    input  logic    [7:0] src_val,
    input  logic    [7:0] dst_val,
    input  alu_op_t       op,
    input  logic    [7:0] flags_in,
    output logic    [7:0] result,
    output logic    [7:0] flags_out,
    output logic          carry_out
);
  always_comb begin
    logic [8:0] tmp;  // for carry
    logic zero_flag, carry_flag, half_flag, sub_flag;
    logic [4:0] half_sum;
    logic signed [7:0] signed_val;

    zero_flag  = flags_in[7];
    sub_flag   = flags_in[6];
    half_flag  = flags_in[5];
    carry_flag = flags_in[4];

    result    = 8'h00;
    flags_out = flags_in;
    carry_out = 1'b0;

    unique case (op)
      ALU_OP_COPY: dst_val = src_val;

      ALU_OP_ADD: begin
        half_sum      = {1'b0, dst_val[3:0]} + {1'b0, src_val[3:0]};
        half_flag     = half_sum[4];

        tmp           = {1'b0, dst_val} + {1'b0, src_val};
        dst_val       = tmp[7:0];
        carry_flag    = tmp[8];

        sub_flag      = 1'b0;
        zero_flag     = (dst_val == 8'h00);

        res.alu_carry = carry_flag;
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
        tmp        = {1'b0, dst_val} - {1'b0, src_val} - {8'b0, regs.flags[4]};
        carry_flag = tmp[8];
        half_flag  = (dst_val[3:0] < (src_val[3:0] + {3'b000, regs.flags[4]}));
        sub_flag   = 1'b1;
        dst_val    = tmp[7:0];
        zero_flag  = (dst_val == 8'h00);
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
        // carry_flag unchanged
      end

      ALU_OP_DEC: begin
        dst_val   = dst_val - 8'd1;
        half_flag = ((dst_val[3:0] == 4'hF));  // borrow into bit4
        sub_flag  = 1'b1;
        zero_flag = (dst_val == 8'h00);
        // carry_flag unchanged
      end

      ALU_OP_RR: begin
        carry_flag = dst_val[0];
        dst_val    = {regs.flags[4], dst_val[7:1]};
        sub_flag   = 1'b0;
        half_flag  = 1'b0;
        if (dst_sel == ALU_SRC_A) zero_flag = 1'b0;
        else zero_flag = (dst_val == 8'h00);
      end

      ALU_OP_RRC: begin
        carry_flag = dst_val[0];
        dst_val    = {dst_val[0], dst_val[7:1]};
        sub_flag   = 1'b0;
        half_flag  = 1'b0;
        if (dst_sel == ALU_SRC_A) zero_flag = 1'b0;
        else zero_flag = (dst_val == 8'h00);
      end

      ALU_OP_RL: begin
        carry_flag = dst_val[7];
        dst_val    = {dst_val[6:0], regs.flags[4]};
        sub_flag   = 1'b0;
        half_flag  = 1'b0;
        if (dst_sel == ALU_SRC_A) zero_flag = 1'b0;
        else zero_flag = (dst_val == 8'h00);
      end

      ALU_OP_RLC: begin
        carry_flag = dst_val[7];
        dst_val    = {dst_val[6:0], dst_val[7]};
        sub_flag   = 1'b0;
        half_flag  = 1'b0;

        // RLCA special case (Z always 0)
        if (dst_sel == ALU_SRC_A) zero_flag = 1'b0;
        else zero_flag = (dst_val == 8'h00);
      end

      ALU_OP_ADD_SIGNED: begin
        // For LD HL,SP+e8 high byte add: SPH + sign(Z) + carry
        tmp           = {1'b0, dst_val} + {1'b0, {8{regs.z[7]}}} + {8'b0, regs.alu_carry};
        dst_val       = tmp[7:0];
        res.alu_carry = tmp[8];
      end

      ALU_OP_CP: begin
        tmp        = {1'b0, dst_val} - {1'b0, src_val};
        carry_flag = tmp[8];
        half_flag  = ((dst_val[3:0]) < (src_val[3:0]));
        sub_flag   = 1'b1;
        zero_flag  = (tmp[7:0] == 8'h00);
      end

      ALU_OP_ADD_LOW: begin
        tmp        = {1'b0, dst_val} + {1'b0, src_val};
        half_sum   = {1'b0, dst_val[3:0]} + {1'b0, src_val[3:0]};
        half_flag  = half_sum[4];
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

      ALU_OP_NONE: ;  // do nothing

      // TODO: Remove default
      default: ;  // ALU_OP_NONE
    endcase

    result = dst_val;
    flags_out = {zero_flag, sub_flag, half_flag, carry_flag, 4'b0000};
  end
endmodule

`endif  // CPU_ALU_SV
