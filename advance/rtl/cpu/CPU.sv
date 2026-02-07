import types_pkg::*;
import cpu_types_pkg::*;
import control_types_pkg::*;

`include "cpu/util.svh"

module CPU (
    input logic clk,
    input logic reset,

    Bus_if.Master_side bus
);

  /// TODO: Remove
  control_t control_signals;

  word_t IR;

  cpu_regs_t regs;

  word_t A_bus;
  word_t B_bus;

  Decoder_if decoder_bus (.IR(IR));

  ALU_if alu_bus (.op_a(A_bus));
  Shifter_if shifter_bus (.R_in(B_bus));

  assign shifter_bus.latch_shift_amt = control_signals.latch_shift_amt;
  assign shifter_bus.use_shift_latch = control_signals.use_shift_latch;
  assign shifter_bus.shift_amount = control_signals.shift_amount;

  assign alu_bus.alu_op = control_signals.ALU_op;
  assign alu_bus.use_op_b_latch = control_signals.ALU_use_op_b_latch;
  assign alu_bus.disable_op_b = control_signals.ALU_disable_op_b;
  assign alu_bus.latch_op_b = control_signals.ALU_latch_op_b;

  assign bus.read_en  = control_signals.memory_read_en;
  assign bus.write_en = control_signals.memory_write_en;
  assign bus.wdata    = B_bus;

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
      .control_signals(control_signals)
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
  assign A_bus = regs.user[decoder_bus.word.Rn];

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
        B_bus = 32'(control_signals.B_bus_imm);
      end

      B_BUS_SRC_READ_DATA: begin
        B_bus = bus.rdata;
      end

      B_BUS_SRC_REG_RM: begin
        B_bus = regs.user[decoder_bus.word.Rm];
      end

      B_BUS_SRC_REG_RS: begin
        B_bus = regs.user[decoder_bus.word.Rs];
      end

      B_BUS_SRC_REG_RD: begin
        B_bus = regs.user[decoder_bus.word.Rd];
      end
    endcase
  end

  always_ff @(posedge clk) begin
    `DISPLAY_CONTROL(control_signals)
  end

  // ======================================================
  // Memory Module
  // ======================================================
  always_ff @(posedge clk) begin
    if (reset) begin
      IR <= 32'd0;
    end else begin
      `TRACE_CPU

      // `DISPLAY_CONTROL(control_signals)

      assert (!(control_signals.memory_write_en && control_signals.memory_read_en))
      else $fatal(1, "Both memory_read_en and memory_write_en asserted!");

      // if (control_signals.memory_write_en) begin
      //   $display("Memory Write: addr=0x%08x, data=0x%08x", bus.addr, bus.wdata);
      //   $fflush();

      //   bus.write_en <= control_signals.memory_write_en;
      //   bus.wdata <= B_bus;
      // end

      // if (control_signals.memory_read_en) begin
      //   $display("Memory Read: addr=0x%08x", bus.addr);
      //   $fflush();

      //   bus.read_en <= control_signals.memory_read_en;
      // end

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
      if (control_signals.incrementer_writeback) begin
        // PC = PC + 4
        regs.user[15] <= regs.user[15] + 32'd4;
        $display("Incrementing PC to: 0x%0d", regs.user[15] + 32'd4);
        $fflush();
      end

      if (control_signals.ALU_set_flags) begin
        regs.CPSR[31] <= alu_bus.flags_out.n;
        regs.CPSR[30] <= alu_bus.flags_out.z;
        regs.CPSR[29] <= alu_bus.flags_out.c;
        regs.CPSR[28] <= alu_bus.flags_out.v;
      end

      unique case (control_signals.alu_writeback)
        ALU_WB_NONE:   ;
        ALU_WB_REG_RD: regs.user[decoder_bus.word.Rd] <= alu_bus.result;
        ALU_WB_REG_RS: regs.user[decoder_bus.word.Rs] <= alu_bus.result;
        ALU_WB_REG_RN: regs.user[decoder_bus.word.Rn] <= alu_bus.result;
        ALU_WB_REG_14: regs.user[14] <= alu_bus.result;
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
          $display("Setting address bus to PC value: 0x%08x", regs.user[15]);
          bus.addr <= regs.user[15];
        end

        ADDR_SRC_INCR: begin
          bus.addr <= bus.addr + 32'd4;
        end
      endcase
    end
  end

endmodule : CPU
