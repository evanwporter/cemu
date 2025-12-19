`ifndef CPU_IDU_OPS_SVH
`define CPU_IDU_OPS_SVH

`include "cpu/opcodes.svh"

import cpu_types_pkg::*;

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

`endif // CPU_IDU_SVH