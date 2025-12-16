`ifndef CPU_UTIL_SV
`define CPU_UTIL_SV 

`include "cpu/opcodes.svh"

import cpu_types_pkg::*;

`define DISPLAY_CONTROL_WORD(CW, i) \
  begin \
    `LOG_TRACE(("--------------------------------------------------")); \
    `LOG_TRACE(("CONTROL WORD DEBUG")); \
    `LOG_TRACE(("  num_cycles = %0d", (CW).num_cycles)); \
    `LOG_TRACE(("  M-Cycle %0d:", i)); \
    `LOG_TRACE(("    addr_src     = %s", (CW).cycles[i].addr_src.name())); \
    `LOG_TRACE(("    data_bus_src = %s", (CW).cycles[i].data_bus_src.name())); \
    `LOG_TRACE(("    data_bus_op  = %s", (CW).cycles[i].data_bus_op.name())); \
    `LOG_TRACE(("    idu_op       = %s", (CW).cycles[i].idu_op.name())); \
    `LOG_TRACE(("    alu_op       = %s", (CW).cycles[i].alu_op.name())); \
    `LOG_TRACE(("    alu_dst      = %s", (CW).cycles[i].alu_dst.name())); \
    `LOG_TRACE(("    alu_src      = %s", (CW).cycles[i].alu_src.name())); \
    `LOG_TRACE(("    alu_bit      = %s", (CW).cycles[i].alu_bit.name())); \
    `LOG_TRACE(("    misc_op      = %s", (CW).cycles[i].misc_op.name())); \
    `LOG_TRACE(("    misc_op_dst  = %s", (CW).cycles[i].misc_op_dst.name())); \
    `LOG_TRACE(("    cond         = %s", (CW).cycles[i].cond.name())); \
    `LOG_TRACE(("--------------------------------------------------")); \
  end

`define DEFINE_REG_PAIR(PAIR, HI, LO) \
  function automatic logic [15:0] get_``PAIR``(ref cpu_regs_t regs); \
    return {regs.``HI``, regs.``LO``}; \
  endfunction \
  \
  function automatic void set_``PAIR``(ref cpu_regs_t regs, logic [15:0] val); \
    regs.``HI`` = val[15:8]; \
    regs.``LO`` = val[7:0]; \
  endfunction

`DEFINE_REG_PAIR(af, a, flags)
`DEFINE_REG_PAIR(bc, b, c)
`DEFINE_REG_PAIR(de, d, e)
`DEFINE_REG_PAIR(hl, h, l)
`DEFINE_REG_PAIR(wz, w, z)
`undef DEFINE_REG_PAIR

function automatic logic [15:0] pick_addr(input address_src_t s, input cpu_regs_t r);
  unique case (s)
    ADDR_NONE: pick_addr = 16'h0000;

    ADDR_PC: pick_addr = {r.pch, r.pcl};
    ADDR_SP: pick_addr = {r.sph, r.spl};

    ADDR_AF: pick_addr = {r.a, r.flags};
    ADDR_HL: pick_addr = {r.h, r.l};
    ADDR_BC: pick_addr = {r.b, r.c};
    ADDR_DE: pick_addr = {r.d, r.e};

    ADDR_WZ: pick_addr = {r.w, r.z};

    ADDR_FF_C: pick_addr = {8'hFF, r.c};
    ADDR_FF_Z: pick_addr = {8'hFF, r.z};
  endcase
endfunction

function automatic logic [7:0] pick_wdata(data_bus_src_t s, cpu_regs_t r);
  unique case (s)
    DATA_BUS_SRC_IR: pick_wdata = r.IR;

    DATA_BUS_SRC_A: pick_wdata = r.a;
    DATA_BUS_SRC_B: pick_wdata = r.b;
    DATA_BUS_SRC_C: pick_wdata = r.c;
    DATA_BUS_SRC_D: pick_wdata = r.d;
    DATA_BUS_SRC_E: pick_wdata = r.e;
    DATA_BUS_SRC_H: pick_wdata = r.h;
    DATA_BUS_SRC_L: pick_wdata = r.l;
    DATA_BUS_SRC_FLAGS: pick_wdata = r.flags;

    DATA_BUS_SRC_W: pick_wdata = r.w;
    DATA_BUS_SRC_Z: pick_wdata = r.z;

    DATA_BUS_SRC_SP_HIGH: pick_wdata = r.sph;
    DATA_BUS_SRC_SP_LOW:  pick_wdata = r.spl;

    DATA_BUS_SRC_PC_HIGH: pick_wdata = r.pch;
    DATA_BUS_SRC_PC_LOW: pick_wdata = r.pcl;
    DATA_BUS_SRC_NONE: pick_wdata = 8'hFF;
  endcase
endfunction

`define APPLY_IDU_OP(SRC, DST, OP, REGS) \
  begin \
    logic [15:0] __idu_tmp; \
    `LOG_TRACE(("[CPU] Applying IDU op %s from %s to %s", (OP).name(), (SRC).name(), (DST).name())); \
    \
    unique case (SRC) \
      ADDR_NONE:   __idu_tmp = 16'h0000; \
      ADDR_PC:     __idu_tmp = {(REGS).pch, (REGS).pcl}; \
      ADDR_SP:     __idu_tmp = {(REGS).sph, (REGS).spl}; \
      ADDR_HL:     __idu_tmp = {(REGS).h, (REGS).l}; \
      ADDR_BC:     __idu_tmp = {(REGS).b, (REGS).c}; \
      ADDR_DE:     __idu_tmp = {(REGS).d, (REGS).e}; \
      ADDR_AF:     __idu_tmp = {(REGS).a, (REGS).flags}; \
      ADDR_WZ:     __idu_tmp = {(REGS).w, (REGS).z}; \
      ADDR_FF_C, \
      ADDR_FF_Z:   __idu_tmp = 16'h0000; \
    endcase \
    \
    unique case (OP) \
      IDU_OP_INC: __idu_tmp = __idu_tmp + 16'd1; \
      IDU_OP_DEC: __idu_tmp = __idu_tmp - 16'd1; \
      IDU_OP_NONE: ; \
    endcase \
    \
    unique case (DST) \
      ADDR_NONE: ; \
      ADDR_PC: {(REGS).pch, (REGS).pcl} <= __idu_tmp; \
      ADDR_SP: {(REGS).sph, (REGS).spl} <= __idu_tmp; \
      ADDR_HL: {(REGS).h, (REGS).l}     <= __idu_tmp; \
      ADDR_BC: {(REGS).b, (REGS).c}     <= __idu_tmp; \
      ADDR_DE: {(REGS).d, (REGS).e}     <= __idu_tmp; \
      ADDR_AF: {(REGS).a, (REGS).flags} <= __idu_tmp; \
      ADDR_WZ: {(REGS).w, (REGS).z}     <= __idu_tmp; \
      ADDR_FF_C, \
      ADDR_FF_Z: ; \
    endcase \
  end


typedef struct packed {
  logic [7:0] result;  // The ALU output value
  logic [7:0] flags;  // The full F register (Z N H C ----)
  logic alu_carry;  // Carry out of the operation
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

    ALU_OP_ADD_SIGNED_HIGH: begin
      tmp = {1'b0, src_val} + {1'b0, regs.z[7] ? 8'hFF : 8'h00} + {8'b0, regs.alu_carry};

      dst_val = tmp[7:0];
      res.alu_carry = 1'b0;
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
      logic [7:0] a;
      a = dst_val;

      if (!sub_flag) begin
        // After ADD / ADC
        if (carry_flag || src_val > 8'h99) begin
          dst_val = src_val + 8'h60;
          carry_flag = 1'b1;
        end
        if (half_flag || (src_val[3:0] > 4'h9)) begin
          dst_val = src_val + 8'h06;
        end
      end else begin
        // After SUB / SBC
        if (carry_flag) begin
          dst_val = src_val - 8'h60;
        end
        if (half_flag) begin
          dst_val = src_val - 8'h06;
        end
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
    (REGS).alu_carry <= __alu_res.alu_carry; \
  end


// Load data bus into selected 8-bit register
`define LOAD_REG_FROM_BYTE(DST_SEL, DATA_BUS, REGS) \
  begin \
    `LOG_TRACE(("[CPU] Loading data 0x%h into %s", (DATA_BUS), (DST_SEL).name())); \
    unique case (DST_SEL) \
      DATA_BUS_SRC_NONE: ; \
      DATA_BUS_SRC_A: (REGS).a <= (DATA_BUS); \
      DATA_BUS_SRC_FLAGS: (REGS).flags <= (DATA_BUS); \
      DATA_BUS_SRC_B: (REGS).b <= (DATA_BUS); \
      DATA_BUS_SRC_C: (REGS).c <= (DATA_BUS); \
      DATA_BUS_SRC_D: (REGS).d <= (DATA_BUS); \
      DATA_BUS_SRC_E: (REGS).e <= (DATA_BUS); \
      DATA_BUS_SRC_H: (REGS).h <= (DATA_BUS); \
      DATA_BUS_SRC_L: (REGS).l <= (DATA_BUS); \
      DATA_BUS_SRC_W: (REGS).w <= (DATA_BUS); \
      DATA_BUS_SRC_Z: (REGS).z <= (DATA_BUS); \
      DATA_BUS_SRC_IR: (REGS).IR <= (DATA_BUS); \
      DATA_BUS_SRC_SP_HIGH: (REGS).sph <= (DATA_BUS); \
      DATA_BUS_SRC_SP_LOW:  (REGS).spl <= (DATA_BUS); \
      DATA_BUS_SRC_PC_HIGH: (REGS).pch <= (DATA_BUS); \
      DATA_BUS_SRC_PC_LOW:  (REGS).pcl <= (DATA_BUS); \
    endcase \
  end

function automatic logic eval_condition(input cond_t cond, input logic [7:0] flags);
  logic zero_flag, carry_flag;
  zero_flag  = flags[7];
  carry_flag = flags[4];

  unique case (cond)
    COND_NONE: eval_condition = 1'b1;
    COND_NZ:   eval_condition = ~zero_flag;
    COND_Z:    eval_condition =  zero_flag;
    COND_NC:   eval_condition = ~carry_flag;
    COND_C:    eval_condition =  carry_flag;
    default:   eval_condition = 1'b1;
  endcase
endfunction

localparam logic [15:0] INTERRUPT_VECTOR_TABLE[0:4] = '{
    'd0: 16'h0040,  // 0: VBlank
    'd1: 16'h0048,  // 1: STAT
    'd2: 16'h0050,  // 2: Timer
    'd3: 16'h0058,  // 3: Serial
    'd4: 16'h0060  // 4: Joypad
};

`define APPLY_MISC_OP(OP, DST, REGS) \
  begin \
    unique case (OP) \
      MISC_OP_IME_ENABLE: begin \
        (REGS).IME <= 1'd1; \
      end \
      MISC_OP_IME_DISABLE: begin \
        (REGS).IME <= 1'd0; \
      end \
      MISC_OP_R16_WZ_COPY: begin \
        `LOG_TRACE(("[CPU] Writing 0x%h to %s", {(REGS).w, (REGS).z}, (DST).name())); \
        unique case (DST) \
          MISC_OP_DST_NONE: ; \
          MISC_OP_DST_PC: begin \
            (REGS).pch <= (REGS).w; \
            (REGS).pcl <= (REGS).z; \
          end \
          MISC_OP_DST_SP: begin \
            (REGS).sph <= (REGS).w; \
            (REGS).spl <= (REGS).z; \
          end \
          MISC_OP_DST_BC: begin \
            (REGS).b <= (REGS).w; \
            (REGS).c <= (REGS).z; \
          end \
          MISC_OP_DST_DE: begin \
            (REGS).d <= (REGS).w; \
            (REGS).e <= (REGS).z; \
          end \
          MISC_OP_DST_HL: begin \
            (REGS).h <= (REGS).w; \
            (REGS).l <= (REGS).z; \
          end \
          MISC_OP_DST_AF: begin \
            (REGS).a <= (REGS).w; \
            (REGS).flags <= (REGS).z & 8'hF0; \
          end \
        endcase \
      end \
      MISC_OP_JR_SIGNED: begin \
        logic signed [7:0] offset; \
        logic [15:0] new_pc; \
        offset = (REGS).z; \
        new_pc = { (REGS).pch, (REGS).pcl } + {{8{offset[7]}}, offset}; \
        (REGS).pch <= new_pc[15:8]; \
        (REGS).pcl <= new_pc[7:0]; \
        `LOG_TRACE(("[CPU] JR signed offset %0d to PC=%04h", offset, new_pc)); \
      end \
      MISC_OP_SET_PC_CONST: begin \
        {(REGS).pch, (REGS).pcl} <= {8'h00, ((REGS).IR & 8'h38)}; \
      end \
      MISC_OP_SP_HL_COPY: begin \
        {(REGS).sph, (REGS).spl} <= {(REGS).h, (REGS).l}; \
      end \
      MISC_OP_CB_PREFIX: /* handled elsewhere */ ; \
      MISC_OP_SET_PC_INTERRUPT_VEC: begin \
        (REGS).pch <= INTERRUPT_VECTOR_TABLE[DST][15:8]; \
        (REGS).pcl <= INTERRUPT_VECTOR_TABLE[DST][7:0]; \
      end \
      default: ; /* nothing to do */ \
    endcase \
  end

`endif  // CPU_UTIL_SV
