`ifndef CPU_UTIL_SV
`define CPU_UTIL_SV 

function automatic logic [15:0] pick_addr(input address_src_t s, input cpu_regs_t r);
  unique case (s)
    ADDR_PC: pick_addr = r.pc;
    ADDR_SP: pick_addr = r.sp;
    ADDR_HL: pick_addr = {r.h, r.l};
    ADDR_BC: pick_addr = {r.b, r.c};
    ADDR_DE: pick_addr = {r.d, r.e};
    default: pick_addr = 16'h0000;
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
    // TODO: SPH/SPL, W/Z
    default: pick_wdata = 8'hFF;
  endcase
endfunction

task automatic apply_idu_op(input address_src_t s, input idu_op_t op, inout cpu_regs_t r);
  unique case (op)
    IDU_OP_INC: begin
      unique case (s)
        ADDR_PC: r.pc <= r.pc + 16'd1;
        ADDR_SP: r.sp <= r.sp + 16'd1;
        ADDR_HL: {r.h, r.l} <= {r.h, r.l} + 16'd1;
        ADDR_BC: {r.b, r.c} <= {r.b, r.c} + 16'd1;
        ADDR_DE: {r.d, r.e} <= {r.d, r.e} + 16'd1;
        default: ;
      endcase
    end
    IDU_OP_DEC: ;
    default: ;
  endcase
endtask


function automatic void apply_alu_op(input alu_op_t op, input alu_src_t dst_sel,
                                     input alu_src_t src_sel, inout cpu_regs_t regs);
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
    default:   src_val = 8'h00;
  endcase

  unique case (dst_sel)
    ALU_SRC_A: dst_val = regs.a;
    ALU_SRC_B: dst_val = regs.b;
    ALU_SRC_C: dst_val = regs.c;
    ALU_SRC_D: dst_val = regs.d;
    ALU_SRC_E: dst_val = regs.e;
    ALU_SRC_H: dst_val = regs.h;
    ALU_SRC_L: dst_val = regs.l;
    default:   dst_val = 8'h00;
  endcase

  // Perform operation
  case (op)
    ALU_OP_COPY: dst_val = src_val;

    ALU_OP_ADD: begin
      tmp     = dst_val + src_val;
      dst_val = tmp[7:0];
      // You can later set regs.flags bits from tmp[8] etc.
    end

    ALU_OP_ADC: begin
      tmp     = dst_val + src_val + regs.flags[4];  // Carry bit placeholder
      dst_val = tmp[7:0];
    end

    ALU_OP_SUB: begin
      tmp     = {1'b0, dst_val} - src_val;
      dst_val = tmp[7:0];
    end

    ALU_OP_SBC: begin
      tmp     = {1'b0, dst_val} - src_val - regs.flags[4];
      dst_val = tmp[7:0];
    end

    ALU_OP_AND: dst_val = dst_val & src_val;
    ALU_OP_OR:  dst_val = dst_val | src_val;
    ALU_OP_XOR: dst_val = dst_val ^ src_val;
    ALU_OP_INC: dst_val = dst_val + 8'd1;
    ALU_OP_DEC: dst_val = dst_val - 8'd1;

    default: ;  // ALU_OP_NONE
  endcase

  // Write back to destination register
  unique case (dst_sel)
    ALU_SRC_A: regs.a <= dst_val;
    ALU_SRC_B: regs.b <= dst_val;
    ALU_SRC_C: regs.c <= dst_val;
    ALU_SRC_D: regs.d <= dst_val;
    ALU_SRC_E: regs.e <= dst_val;
    ALU_SRC_H: regs.h <= dst_val;
    ALU_SRC_L: regs.l <= dst_val;
    default:   ;  // do nothing
  endcase
endfunction


// Load data bus into selected 8-bit register
task automatic load_reg_from_byte(input data_bus_src_t dst_sel, input logic [7:0] data_bus,
                                  ref cpu_regs_t regs);
  unique case (dst_sel)
    DATA_BUS_SRC_A: regs.a <= data_bus;
    DATA_BUS_SRC_B: regs.b <= data_bus;
    DATA_BUS_SRC_C: regs.c <= data_bus;
    DATA_BUS_SRC_D: regs.d <= data_bus;
    DATA_BUS_SRC_E: regs.e <= data_bus;
    DATA_BUS_SRC_H: regs.h <= data_bus;
    DATA_BUS_SRC_L: regs.l <= data_bus;
    default: ;
  endcase
endtask

function automatic logic eval_condition(input cond_t cond, input logic [7:0] flags);
  logic zero_flag, carry_flag;
  zero_flag  = flags[7];
  carry_flag = flags[4];

  unique case (cond)
    COND_NONE: eval_condition = 1'b1;     // always true
    COND_NZ:   eval_condition = ~zero_flag;
    COND_Z:    eval_condition =  zero_flag;
    COND_NC:   eval_condition = ~carry_flag;
    COND_C:    eval_condition =  carry_flag;
    default:   eval_condition = 1'b1;
  endcase
endfunction


`endif  // CPU_UTIL_SV
