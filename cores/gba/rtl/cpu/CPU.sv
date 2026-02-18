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

  logic flush_req;
  logic flush_req_pending;

  cpu_regs_t regs;

  word_t A_bus;
  word_t B_bus;

  cpu_mode_t cpu_mode;

  /// Data that has been latched from the read bus
  word_t read_data;

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
  assign shifter_bus.carry_in = regs.CPSR[29];  // CPSR.C
  assign shifter_bus.shift_use_rxx = control_signals.shift_use_rxx;

  assign alu_bus.alu_op = control_signals.ALU_op;
  assign alu_bus.use_op_b_latch = control_signals.ALU_use_op_b_latch;
  assign alu_bus.disable_op_b = control_signals.ALU_disable_op_b;
  assign alu_bus.latch_op_b = control_signals.ALU_latch_op_b;
  assign alu_bus.flags_in = regs.CPSR[31:28];  // N,Z,C,V

  assign bus.read_en = control_signals.memory_read_en;
  assign bus.write_en = control_signals.memory_write_en;
  assign bus.instruction_fetch = control_signals.memory_latch_IR;

  always_comb begin
    bus.wdata = B_bus;
    if (control_signals.memory_byte_transfer) begin
      bus.wdata = {24'd0, B_bus[7:0]};
    end else if (control_signals.memory_halfword_transfer) begin
      bus.wdata = {16'd0, B_bus[15:0]};
    end
  end

  /// TODO: Debug signal
  (* maybe_unused *)
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
      .flush_req(flush_req)
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
  always_comb begin
    if (control_signals.A_bus_source == A_BUS_SRC_RN) begin
      $display("Driving A bus with value from Rn (R%d): %0d", decoder_bus.word.Rn, read_reg(
               regs, cpu_mode, decoder_bus.word.Rn));
      if (control_signals.pc_rn_add_4) begin
        A_bus = read_reg(regs, cpu_mode, decoder_bus.word.Rn) + 32'd4;
      end else begin
        A_bus = read_reg(regs, cpu_mode, decoder_bus.word.Rn);
      end
    end else begin  // A_BUS_SRC_IMM
      $display("Driving A bus with value from imm (%0d)", control_signals.A_bus_imm);
      A_bus = word_t'(control_signals.A_bus_imm);
    end
  end


  function automatic word_t ror32(word_t x, int unsigned sh);
    ror32 = (x >> sh) | (x << (32 - sh));
  endfunction

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
        B_bus = {20'b0, control_signals.B_bus_imm};
      end

      B_BUS_SRC_READ_DATA: begin
        B_bus = read_data;
        $display("Driving B bus with read_data value: 0x%08x", read_data);
      end

      B_BUS_SRC_REG_RM: begin
        $display("Driving B bus with value from Rm (R%0d): %0d", decoder_bus.word.Rm, read_reg(
                 regs, cpu_mode, decoder_bus.word.Rm));
        B_bus = control_signals.pc_rm_add_4 ? (read_reg(regs, cpu_mode, decoder_bus.word.Rm) + 32'd4
            ) : read_reg(regs, cpu_mode, decoder_bus.word.Rm);
      end

      B_BUS_SRC_REG_RS: begin
        B_bus = control_signals.pc_rs_add_4 ? (read_reg(regs, cpu_mode, decoder_bus.word.Rs) + 32'd4
            ) : read_reg(regs, cpu_mode, decoder_bus.word.Rs);
      end

      B_BUS_SRC_REG_RD: begin
        B_bus = read_reg(regs, cpu_mode, decoder_bus.word.Rd);
      end

      B_BUS_SRC_REG_RN: begin
        $display("Driving B bus with value from Rn (R%0d): %0d", decoder_bus.word.Rn, read_reg(
                 regs, cpu_mode, decoder_bus.word.Rn));
        B_bus = read_reg(regs, cpu_mode, decoder_bus.word.Rn);
      end

      B_BUS_SRC_REG_RP: begin
        $display("Driving B bus with value from Rp (R%0d): %0d", control_signals.Rp_imm, read_reg(
                 regs, cpu_mode, control_signals.Rp_imm));
        B_bus = read_reg(regs, control_signals.force_user_mode ? MODE_USR : cpu_mode,
                         control_signals.Rp_imm);
      end
    endcase
  end

  always_ff @(posedge clk) begin
    `DISPLAY_CONTROL(control_signals)

    instr_boundary <= control_signals.pipeline_advance;
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

      if (control_signals.memory_read_en) begin
        if (control_signals.memory_latch_IR) begin
          IR <= bus.rdata;
          $display("Latching IR with value: 0x%08x", bus.rdata);
          $fflush();

        end else begin
          if (control_signals.memory_byte_transfer) begin
            read_data <= {24'd0, bus.rdata[7:0]};

            $display("Performing byte read, bus.rdata=0x%08x, B_bus[7:0]=0x%02x", bus.rdata,
                     bus.rdata[7:0]);
          end else if (control_signals.memory_halfword_transfer) begin

            read_data <= {16'd0, bus.rdata[15:0]};

            // ARM7TDMI unaligned halfword rotate quirk
            if (bus.addr[0] == 1'b1) begin
              read_data <= ror32(bus.rdata, 8);
              $display("Unaligned LDRH: rotating right by 8");
            end

            $display("Performing halfword read, bus.rdata=0x%08x, B_bus[15:0]=0x%04x", bus.rdata,
                     bus.rdata[15:0]);
          end else if (control_signals.memory_signed_halfword_transfer) begin
            read_data <= {{16{bus.rdata[15]}}, bus.rdata[15:0]};

            $display("Performing signed halfword read, bus.rdata=0x%08x, B_bus[15:0]=0x%04x",
                     bus.rdata, bus.rdata[15:0]);
          end else begin
            $display("Performing word read, bus.rdata=0x%08x", bus.rdata);
            read_data <= bus.rdata;

            // Misaligned word-load rotate quirk (ARM7TDMI)
            if (decoder_bus.word.instr_type == ARM_INSTR_LOAD && 
              !control_signals.memory_byte_transfer) begin
              logic [1:0] a;
              a = bus.addr[1:0];
              if (a != 2'b00) begin
                $display("Misaligned word with a=%b, rotate=%d, prior=%d", a, ror32(
                         bus.rdata, 32'({a, 3'b000})), bus.rdata);
                read_data <= ror32(bus.rdata, 32'({a, 3'b000}));  // (a*8)
              end
            end
          end
        end
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
      flush_req <= 1'b0;

      if (control_signals.pipeline_advance && flush_req_pending) begin
        $display("Pipeline gba, checking for writebacks and flushes");
        $fflush();

        flush_req_pending <= 1'b0;
        flush_req <= 1'b1;
      end

      if ((control_signals.ALU_writeback == ALU_WB_REG_RD && decoder_bus.word.Rd == 4'd15) ||
          (control_signals.ALU_writeback == ALU_WB_REG_RN && decoder_bus.word.Rn == 4'd15) ||
          (control_signals.ALU_writeback == ALU_WB_REG_RP && control_signals.Rp_imm == 4'd15)) begin

        $display("ALU writeback to PC (R15) detected. ALU_writeback=%0d, Rd=%0d, Rn=%0d",
                 control_signals.ALU_writeback, decoder_bus.word.Rd, decoder_bus.word.Rn);

        if (control_signals.pipeline_advance) begin
          flush_req <= 1'b1;
          $display("Requesting pipeline flush due to writeback to PC (R15)");
        end else begin
          flush_req_pending <= 1'b1;
          $display("Setting flush_req_pending to ensure flush on next cycle.");
        end
      end else if (control_signals.incrementer_writeback) begin
        // PC = PC + 4

        `WRITE_REG(regs, cpu_mode, 15, read_reg(regs, cpu_mode, 15) + 32'd4)
        $display("Incrementing PC to: %0d", read_reg(regs, cpu_mode, 15) + 32'd4);
        $fflush();
      end

      $display("[CPU] Checking ALU flags writeback. ALU_set_flags=%b, restore_cpsr_from_spsr=%b",
               control_signals.ALU_set_flags, control_signals.restore_cpsr_from_spsr);

      if (control_signals.restore_cpsr_from_spsr) begin
        regs.CPSR <= read_spsr(regs, cpu_mode);
        $display("Restoring CPSR from SPSR_%0d: 0x%08x", cpu_mode, read_spsr(regs, cpu_mode));
      end

      if (control_signals.ALU_set_flags && control_signals.pipeline_advance) begin

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

      unique case (control_signals.ALU_writeback)
        ALU_WB_NONE:   ;
        ALU_WB_REG_RD: begin
          `WRITE_REG(regs, cpu_mode, decoder_bus.word.Rd, alu_bus.result)
          $display("Writing back ALU result %0d to Rd (R%d)", alu_bus.result, decoder_bus.word.Rd);
        end
        ALU_WB_REG_RS: `WRITE_REG(regs, cpu_mode, decoder_bus.word.Rs, alu_bus.result)
        ALU_WB_REG_RN: begin
          $display("Writing back ALU result %0d to Rn (R%d)", alu_bus.result, decoder_bus.word.Rn);
          `WRITE_REG(regs, control_signals.force_user_mode ? MODE_USR : cpu_mode,
                     decoder_bus.word.Rn, alu_bus.result)
        end
        ALU_WB_REG_14: `WRITE_REG(regs, cpu_mode, 14, alu_bus.result)
        ALU_WB_REG_RP: begin
          `WRITE_REG(regs, control_signals.force_user_mode ? MODE_USR : cpu_mode,
                     control_signals.Rp_imm, alu_bus.result)
        end
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
      $display("[CPU] addr=%0d", bus.addr);

      unique case (control_signals.addr_bus_src)
        ADDR_SRC_NONE: begin
          // bus.addr <= 32'd0;
        end

        ADDR_SRC_ALU: begin
          $display("[CPU] Driving address bus with ALU result: %0d", alu_bus.result);
          bus.addr <= alu_bus.result;
        end

        ADDR_SRC_PC: begin
          $display("Setting address bus to PC value: 0x%08x", read_reg(regs, cpu_mode, 15));
          bus.addr <= read_reg(regs, cpu_mode, 15);
        end

        ADDR_SRC_INCR: begin
          bus.addr <= bus.addr + 32'd4;
        end
      endcase
    end
  end

endmodule : CPU
