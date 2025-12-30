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

/// Load data bus into selected 8-bit register
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
        offset = $signed((REGS).z); \
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
