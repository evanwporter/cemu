import cpu_types_pkg::*;
import control_types_pkg::*;
import types_pkg::*;

module CPU (
    input logic clk,
    input logic reset,

    Bus_if.Master_side bus
);

  /// TODO: Remove
  control_t control_signals;

  word_t IR;

  word_t regs[16];

  word_t A_bus;
  word_t B_bus;

  Decoder_if decoder_bus (.IR(IR));

  ALU_if alu_bus (.op_a(A_bus));
  Shifter_if shifter_bus (.R_in(B_bus));

  assign shifter_bus.latch_shift_amt = control_signals.latch_shift_amt;
  assign shifter_bus.use_shift_latch = control_signals.use_shift_latch;
  assign shifter_bus.shift_amount = control_signals.shift_amount;

  assign alu_bus.alu_op = control_signals.ALU_op;
  assign alu_bus.set_flags = control_signals.set_ALU_flags;
  assign alu_bus.use_op_b_latch = control_signals.ALU_use_op_b_latch;
  assign alu_bus.disable_op_b = control_signals.ALU_disable_op_b;
  assign alu_bus.latch_op_b = control_signals.ALU_latch_op_b;

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
  assign A_bus = regs[decoder_bus.word.Rn];

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
        B_bus = regs[decoder_bus.word.Rm];
      end

      B_BUS_SRC_REG_RS: begin
        B_bus = regs[decoder_bus.word.Rs];
      end

      B_BUS_SRC_REG_RD: begin
        B_bus = regs[decoder_bus.word.Rd];
      end
    endcase
  end

  // ======================================================
  // Memory Module
  // ======================================================
  always_ff @(posedge clk) begin
    if (reset) begin
    end else begin
      bus.write_en <= 1'b0;

      if (control_signals.memory_write_en) begin
        bus.write_en <= 1'b1;
        bus.wdata <= B_bus;
      end
    end
  end

  // ======================================================
  // Perform Register Writebacks
  // ======================================================
  always_ff @(posedge clk) begin
    if (reset) begin
    end else begin
      if (control_signals.incrementer_writeback) begin
        // PC = PC + 4
        regs[15] <= regs[15] + 32'd4;
      end

      unique case (control_signals.alu_writeback)
        ALU_WB_NONE:   ;
        ALU_WB_REG_RD: regs[decoder_bus.word.Rd] <= alu_bus.result;
        ALU_WB_REG_RS: regs[decoder_bus.word.Rs] <= alu_bus.result;
        ALU_WB_REG_RN: regs[decoder_bus.word.Rn] <= alu_bus.result;
        ALU_WB_REG_14: regs[14] <= alu_bus.result;
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

        ADDR_SRC_INCR: begin
          bus.addr <= bus.addr + 32'd4;
        end

        ADDR_SRC_ALU: begin
          bus.addr <= alu_bus.result;
        end

        ADDR_SRC_PC: begin
          // PC
          bus.addr <= regs[15];
        end
      endcase
    end
  end

  always_ff @(posedge clk) begin
    if (reset) begin
      IR <= 32'd0;
    end else begin
      if (control_signals.memory_latch_IR) begin
        IR <= bus.rdata;
      end
    end
  end

endmodule : CPU
