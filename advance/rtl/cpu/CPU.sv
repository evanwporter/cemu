import types_pkg::*;
import cpu_types_pkg::*;
import control_types_pkg::*;
import cpu_util_pkg::*;

`include "cpu/util.svh"

module CPU (
    input logic clk,
    input logic reset,

    Bus_if.Master_side bus
);

  /// TODO: Remove
  control_t control_signals;

  word_t IR;

  logic flush_request;

  cpu_regs_t regs;

  word_t A_bus;
  word_t B_bus;

  cpu_mode_t cpu_mode;

  always_comb begin
    unique casez (regs.CPSR[4:0])

      5'b0??00: cpu_mode = MODE_USR;  // Old User
      5'b0??01: cpu_mode = MODE_FIQ;  // Old FIQ
      5'b0??10: cpu_mode = MODE_IRQ;  // Old IRQ
      5'b0??11: cpu_mode = MODE_SVC;  // Old Supervisor

      5'b10000: cpu_mode = MODE_USR;  // User
      5'b10001: cpu_mode = MODE_FIQ;  // FIQ
      5'b10010: cpu_mode = MODE_IRQ;  // IRQ
      5'b10011: cpu_mode = MODE_SVC;  // Supervisor
      5'b10111: cpu_mode = MODE_ABT;  // Abort
      5'b11011: cpu_mode = MODE_UND;  // Undefined
      5'b11111: cpu_mode = MODE_SYS;  // System

      default: begin
        cpu_mode = MODE_USR;
        $warning("Illegal CPSR mode encoding: %b", regs.CPSR[4:0]);
      end
    endcase
  end

  Decoder_if decoder_bus (
      .IR(IR),
      .flags(regs.CPSR[31:28])
  );

  ALU_if alu_bus (.op_a(A_bus));
  Shifter_if shifter_bus (.R_in(B_bus));

  assign shifter_bus.shift_latch_amt = control_signals.shift_latch_amt;
  assign shifter_bus.shift_use_latch = control_signals.shift_use_latch;
  assign shifter_bus.shift_amount = control_signals.shift_amount;
  assign shifter_bus.shift_type = control_signals.shift_type;
  assign shifter_bus.carry_in = regs.CPSR[29]; // CPSR.C
  assign shifter_bus.shift_use_rxx = control_signals.shift_use_rxx;

  assign alu_bus.alu_op = control_signals.ALU_op;
  assign alu_bus.use_op_b_latch = control_signals.ALU_use_op_b_latch;
  assign alu_bus.disable_op_b = control_signals.ALU_disable_op_b;
  assign alu_bus.latch_op_b = control_signals.ALU_latch_op_b;
  assign alu_bus.flags_in = regs.CPSR[31:28]; // N,Z,C,V

  assign bus.read_en  = control_signals.memory_read_en;
  assign bus.write_en = control_signals.memory_write_en;
  assign bus.wdata    = B_bus;

  /// TODO: Debug signal
  logic instr_boundary;

  // assign decoder_bus.IR = IR;

  ALU alu_inst (
      .clk(clk),
      .reset(reset),
      .bus(alu_bus),
      .shifter_bus(shifter_bus)
  );

  Decoder decoder_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (decoder_bus)
  );

  ControlUnit controlUnit (
      .clk(clk),
      .reset(reset),
      .decoder_bus(decoder_bus),
      .control_signals(control_signals),
      .flush_req(flush_request)
  );

  BarrelShifter shifter_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (shifter_bus)
  );

  // ======================================================
  // Assign A Bus
  // ======================================================

  // This may get more complicated in the future
  assign A_bus = read_reg(regs, cpu_mode, decoder_bus.word.Rn);

  // ======================================================
  // Assign B Bus
  // ======================================================
  always_comb begin
    B_bus = 32'd0;

    unique case (control_signals.B_bus_source)
      B_BUS_SRC_NONE: begin
        B_bus = 32'd0;
      end

      B_BUS_SRC_IMM: begin
        B_bus = {24'b0, decoder_bus.word.immediate.data_proc_imm.imm8};
      end

      B_BUS_SRC_READ_DATA: begin
        B_bus = bus.rdata;
      end

      B_BUS_SRC_REG_RM: begin
        B_bus = read_reg(regs, cpu_mode, decoder_bus.word.Rm);
      end

      B_BUS_SRC_REG_RS: begin
        B_bus = read_reg(regs, cpu_mode, decoder_bus.word.Rs);
      end

      B_BUS_SRC_REG_RD: begin
        B_bus = read_reg(regs, cpu_mode, decoder_bus.word.Rd);
      end
    endcase
  end

  always_ff @(posedge clk) begin
    `DISPLAY_CONTROL(control_signals)

    instr_boundary <= control_signals.instr_done;
  end

  // ======================================================
  // Memory Module
  // ======================================================
  always_ff @(posedge clk) begin
    if (reset) begin
      IR <= 32'd0;
    end else begin
      `TRACE_CPU

      assert (!(control_signals.memory_write_en && control_signals.memory_read_en))
      else $fatal(1, "Both memory_read_en and memory_write_en asserted!");

      if (control_signals.memory_latch_IR) begin
        IR <= bus.rdata;
        $display("Latching IR with value: 0x%08x", bus.rdata);
        $fflush();
      end
    end
  end

  // ======================================================
  // Perform Register Writebacks
  // ======================================================
  always_ff @(posedge clk) begin
    if (reset) begin
      regs.user <= '{default: 32'd0};
    end else begin
      flush_request <= 1'b0;
      if (control_signals.alu_writeback == ALU_WB_REG_RD && decoder_bus.word.Rd == 4'd15) begin
        flush_request <= 1'b1;
      end else if (control_signals.incrementer_writeback) begin
        // PC = PC + 4
        regs.user.r15 <= regs.user.r15 + 32'd4;
        $display("Incrementing PC to: 0x%0d", regs.user.r15 + 32'd4);
        $fflush();
      end

      if (control_signals.ALU_set_flags && control_signals.instr_done) begin
        if ((decoder_bus.word.Rd == 4'd15) && mode_has_spsr(cpu_mode)) begin
          regs.CPSR <= read_spsr(regs, cpu_mode);

          $display("Restoring CPSR from SPSR_%0d: 0x%08x", cpu_mode, read_spsr(regs, cpu_mode));
          $fflush();
        end else begin
          $display("Setting flags: N=%b, Z=%b, C=%b, V=%b", alu_bus.flags_out.n,
                   alu_bus.flags_out.z, alu_bus.flags_out.c, alu_bus.flags_out.v);

          regs.CPSR[31] <= alu_bus.flags_out.n;
          regs.CPSR[30] <= alu_bus.flags_out.z;
          regs.CPSR[29] <= alu_bus.flags_out.c;
          regs.CPSR[28] <= alu_bus.flags_out.v;

          $display("ALU op was %0d, setting C flag to %b", control_signals.ALU_op,
                   alu_bus.flags_out.c);
          $fflush();
        end
      end

      unique case (control_signals.alu_writeback)
        ALU_WB_NONE:   ;
        ALU_WB_REG_RD: begin
          `WRITE_REG(regs, cpu_mode, decoder_bus.word.Rd, alu_bus.result)
          $display("Writing back ALU result %0d to Rd (R%d)", alu_bus.result, decoder_bus.word.Rd);
        end
        ALU_WB_REG_RS: `WRITE_REG(regs, cpu_mode, decoder_bus.word.Rs, alu_bus.result)
        ALU_WB_REG_RN: `WRITE_REG(regs, cpu_mode, decoder_bus.word.Rn, alu_bus.result)
        ALU_WB_REG_14: `WRITE_REG(regs, cpu_mode, 14, alu_bus.result)
      endcase
    end
  end

  // ======================================================
  // Address Module
  // ======================================================
  // Calculate address bus value
  always_ff @(posedge clk) begin
    if (reset) begin
    end else begin
      unique case (control_signals.addr_bus_src)
        ADDR_SRC_NONE: begin
          bus.addr <= 32'd0;
        end

        ADDR_SRC_ALU: begin
          bus.addr <= alu_bus.result;
        end

        ADDR_SRC_PC: begin
          // PC
          $display("Setting address bus to PC value: 0x%08x", regs.user.r15);
          bus.addr <= regs.user.r15;
        end

        ADDR_SRC_INCR: begin
          bus.addr <= bus.addr + 32'd4;
        end
      endcase
    end
  end

endmodule : CPU
