`ifndef CPU_UTIL_SV
`define CPU_UTIL_SV 

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

    DATA_BUS_SRC_W: pick_wdata = r.w;
    DATA_BUS_SRC_Z: pick_wdata = r.z;

    DATA_BUS_SRC_SP_HIGH: pick_wdata = r.sph;
    DATA_BUS_SRC_SP_LOW:  pick_wdata = r.spl;

    DATA_BUS_SRC_PC_HIGH: pick_wdata = r.pch;
    DATA_BUS_SRC_PC_LOW: pick_wdata = r.pcl;
    DATA_BUS_SRC_NONE: pick_wdata = 8'hFF;
  endcase
endfunction

`define APPLY_IDU_OP(SRC, OP, REGS) \
  begin \
    $display("[%0t] Applying IDU op %s to %s", $time, (OP).name(), (SRC).name()); \
    unique case (OP) \
      IDU_OP_INC: begin \
        unique case (SRC) \
          ADDR_NONE: ; \
          ADDR_PC: {(REGS).pch, (REGS).pcl} <= {(REGS).pch, (REGS).pcl} + 16'd1; \
          ADDR_SP: {(REGS).sph, (REGS).spl} <= {(REGS).sph, (REGS).spl} + 16'd1; \
          ADDR_HL: {(REGS).h, (REGS).l} <= {(REGS).h, (REGS).l} + 16'd1; \
          ADDR_BC: {(REGS).b, (REGS).c} <= {(REGS).b, (REGS).c} + 16'd1; \
          ADDR_DE: {(REGS).d, (REGS).e} <= {(REGS).d, (REGS).e} + 16'd1; \
          ADDR_AF: {(REGS).a, (REGS).flags} <= {(REGS).a, (REGS).flags} + 16'd1; \
          ADDR_WZ: {(REGS).w, (REGS).z} <= {(REGS).w, (REGS).z} + 16'd1; \
        endcase \
      end \
      IDU_OP_DEC: ; \
      default: ; \
    endcase \
  end

function automatic logic [7:0] apply_alu_op(input alu_op_t op, input alu_src_t dst_sel,
                                            input alu_src_t src_sel, ref cpu_regs_t regs);
  // temporary values
  logic [7:0] src_val, dst_val;
  logic [8:0] tmp;  // for carry

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

    ALU_SRC_NONE: dst_val = 8'h00;
  endcase

  // Perform operation
  case (op)
    ALU_OP_COPY: dst_val = src_val;

    ALU_OP_ADD: begin
      tmp     = {1'b0, dst_val} + {1'b0, src_val};
      dst_val = tmp[7:0];
    end

    ALU_OP_ADC: begin
      tmp     = {1'b0, dst_val} + {1'b0, src_val} + {8'b0, regs.flags[4]};  // carry
      dst_val = tmp[7:0];
    end

    ALU_OP_SUB: begin
      tmp     = {1'b0, dst_val} - {1'b0, src_val};
      dst_val = tmp[7:0];
    end

    ALU_OP_SBC: begin
      tmp     = {1'b0, dst_val} - {1'b0, src_val} - {8'b0, regs.flags[4]};
      dst_val = tmp[7:0];
    end

    ALU_OP_AND: dst_val = dst_val & src_val;
    ALU_OP_OR:  dst_val = dst_val | src_val;
    ALU_OP_XOR: dst_val = dst_val ^ src_val;
    ALU_OP_INC: dst_val = dst_val + 8'd1;
    ALU_OP_DEC: dst_val = dst_val - 8'd1;

    default: ;  // ALU_OP_NONE
  endcase

  return dst_val;
endfunction

`define APPLY_ALU_OP(OP, DST_SEL, SRC_SEL, REGS) \
  begin \
    logic [7:0] __alu_result; \
    __alu_result = apply_alu_op(OP, DST_SEL, SRC_SEL, REGS); \
    $display("[%0t] Applying ALU op %s to %s from %s", \
          $time, (OP).name(), (DST_SEL).name(), (SRC_SEL).name()); \
    unique case (DST_SEL) \
      ALU_SRC_A: (REGS).a <= __alu_result; \
      ALU_SRC_B: (REGS).b <= __alu_result; \
      ALU_SRC_C: (REGS).c <= __alu_result; \
      ALU_SRC_D: (REGS).d <= __alu_result; \
      ALU_SRC_E: (REGS).e <= __alu_result; \
      ALU_SRC_H: (REGS).h <= __alu_result; \
      ALU_SRC_L: (REGS).l <= __alu_result; \
      ALU_SRC_W: (REGS).w <= __alu_result; \
      ALU_SRC_Z: (REGS).z <= __alu_result; \
      ALU_SRC_NONE: ; \
    endcase \
  end

// Load data bus into selected 8-bit register
`define LOAD_REG_FROM_BYTE(DST_SEL, DATA_BUS, REGS) \
  begin \
    $display("[%0t] Loading data 0x%h into %s", $time, (DATA_BUS), (DST_SEL).name()); \
    unique case (DST_SEL) \
      DATA_BUS_SRC_NONE: ; \
      DATA_BUS_SRC_A: (REGS).a <= (DATA_BUS); \
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

`define APPLY_MISC_OP(OP, DST, REGS) \
  begin \
    unique case (OP) \
      MISC_OP_IME_ENABLE: begin \
        (REGS).IME <= 8'd1; \
      end \
      MISC_OP_IME_DISABLE: begin \
        (REGS).IME <= 8'd0; \
      end \
      MISC_OP_R16_COPY: begin \
        $display("[%0t] Writing 0x%h to %s", $time, {(REGS).w, (REGS).z}, (DST).name()); \
        unique case (DST) \
          MISC_OP_DST_NONE: ; /* nothing to do */ \
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
        endcase \
      end \
      default: ; /* nothing to do */ \
    endcase \
  end

`endif  // CPU_UTIL_SV
