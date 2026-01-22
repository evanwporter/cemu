`ifndef CPU_SV
`define CPU_SV 

`include "cpu/control_words.svh"
`include "cpu/cb_control_words.svh"
`include "cpu/interrupt_control_words.svh"
`include "cpu/opcodes.svh"

import cpu_types_pkg::*;
import ppu_types_pkg::*;
import gameboy_types_pkg::*;

`include "cpu/util.svh"

`include "cpu/alu_ops.svh"
`include "cpu/idu_ops.svh"

`include "util/logger.svh"

module CPU (
    input logic clk,
    input logic reset,

    output t_phase_t t_phase,

    Bus_if.Master_side bus,
    Bus_if.Slave_side interrupt_bus,
    Interrupt_if.CPU_side IF_bus
);

  /// The CPU register
  cpu_regs_t regs;

  /// Current control word; instructions being executed
  control_word_t control_word;

  /// Curent machine cycle within instruction
  cycle_count_t cycle_count;

  // TODO: Perhaps rename to `instr_finished_flag`?
  logic instr_boundary;

  /// Interrupt flags
  logic [7:0] IF;

  /// Interrupt enable register
  logic [7:0] IE;

  /// Maximum index for cycle count (5 since 0-based)
  localparam cycle_count_t MAX_CYCLE_INDEX = MAX_CYCLES_PER_INSTR - 1;

  logic halted;

  // ======================================================
  // CPU Tick Operation
  // ======================================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      {regs.pch, regs.pcl} <= 16'h0000;
      {regs.sph, regs.spl} <= 16'hFFFE;
      regs.IR <= 8'h00;
      t_phase <= T1;
      cycle_count <= '0;
      control_word <= control_words[8'h00];  // BOOT ROM start instruction
      bus.read_en <= 1'b0;
      bus.write_en <= 1'b0;
      bus.wdata <= '0;
      instr_boundary <= 1'b0;
      halted <= 1'b0;

      `LOG_INFO(("[CPU] RESET: PC=%04h SP=%04h", {regs.pch, regs.pcl}, {regs.sph, regs.spl}))

    end else begin
      `LOG_TRACE(
          ("[CPU] Phase=%s Cycle=%0d PC=%04h Addr=%04h ReadDataBus=%02h IR=%02h", 
               t_phase.name(), cycle_count, {
          regs.pch, regs.pcl}, bus.addr, bus.rdata, regs.IR))

      instr_boundary <= 1'b0;

      if (halted) begin
        bus.read_en  <= 1'b0;
        bus.write_en <= 1'b0;

        // resume condition
        if ((IF & IE & 8'b00011111) != 0) begin
          halted       <= 1'b0;

          // On resume, the next instruction is fetched
          regs.IR      <= 8'h00;
          control_word <= control_words[8'h00];
        end

        t_phase <= t_phase;
        cycle_count <= cycle_count;
      end else begin
        // Normal operation
        unique case (t_phase)
          T1: begin
            bus.addr <= {regs.pch, regs.pcl};
            unique case (control_word.cycles[cycle_count].addr_src)
              ADDR_PC:   bus.addr <= {regs.pch, regs.pcl};
              ADDR_SP:   bus.addr <= {regs.sph, regs.spl};
              ADDR_BC:   bus.addr <= {regs.b, regs.c};
              ADDR_DE:   bus.addr <= {regs.d, regs.e};
              ADDR_HL:   bus.addr <= {regs.h, regs.l};
              ADDR_WZ:   bus.addr <= {regs.w, regs.z};
              ADDR_AF:   bus.addr <= {regs.a, regs.flags};
              ADDR_FF_C: bus.addr <= {8'hFF, regs.c};
              ADDR_FF_Z: bus.addr <= {8'hFF, regs.z};
              ADDR_NONE: bus.addr <= 16'h0000;
            endcase
            t_phase <= T2;
          end

          T2: begin
            unique case (control_word.cycles[cycle_count].data_bus_op)
              DATA_BUS_OP_READ: begin
                bus.read_en  <= 1'b1;
                bus.write_en <= 1'b0;
                `LOG_TRACE(("[CPU] READ request at addr %h", bus.addr))
              end
              DATA_BUS_OP_WRITE: begin
                bus.wdata    <= pick_wdata(control_word.cycles[cycle_count].data_bus_src, regs);
                bus.write_en <= 1'b1;
                bus.read_en  <= 1'b0;
                `LOG_TRACE(("[CPU] WRITE request at addr %h data=%h", bus.addr, bus.wdata))
              end
              DATA_BUS_OP_NONE: begin
                bus.write_en <= 1'b0;
                bus.read_en  <= 1'b0;
              end
            endcase

            t_phase <= T3;
          end

          // T3 is generally the cycle where data is read from the bus or the write is completed.
          T3: begin
            if (control_word.cycles[cycle_count].data_bus_op == DATA_BUS_OP_READ) begin
              `LOAD_REG_FROM_BYTE(control_word.cycles[cycle_count].data_bus_src, bus.rdata, regs)
              `LOG_TRACE(("[CPU] READ complete: data=%h", bus.rdata))
            end
            t_phase <= T4;
          end

          T4: begin

            `DISPLAY_CONTROL_WORD(control_word, cycle_count)

            // applies the idu op to the address bus
            if (control_word.cycles[cycle_count].idu_dst == ADDR_NONE) begin
              `APPLY_IDU_OP(control_word.cycles[cycle_count].addr_src,
                            control_word.cycles[cycle_count].addr_src,
                            control_word.cycles[cycle_count].idu_op, regs)
            end else begin
              `APPLY_IDU_OP(control_word.cycles[cycle_count].addr_src,
                            control_word.cycles[cycle_count].idu_dst,
                            control_word.cycles[cycle_count].idu_op, regs)
            end

            // applies the alu op to the specified registers
            `APPLY_ALU_OP(control_word.cycles[cycle_count].alu_op,
                          control_word.cycles[cycle_count].alu_dst,
                          control_word.cycles[cycle_count].alu_src,
                          control_word.cycles[cycle_count].alu_bit, regs)

            // applies the misc op to the specified registers
            `APPLY_MISC_OP(control_word.cycles[cycle_count].misc_op,
                           control_word.cycles[cycle_count].misc_op_dst, regs, halted)

            bus.read_en  <= 1'b0;
            bus.write_en <= 1'b0;

            // If it is a conditional instruction, check the condition
            if (control_word.cycles[cycle_count].misc_op == MISC_OP_COND_CHECK &&  //
                !eval_condition(
                    control_word.cycles[cycle_count].cond, regs.flags
                )) begin

              // Condition failed; skip to 5th cycle (which has the final cycle instruction)
              cycle_count <= MAX_CYCLE_INDEX;
            end else if (cycle_count + 1 >= control_word.num_cycles) begin
              // We have reached the end of the instruction
              cycle_count <= '0;
              if (control_word.cycles[cycle_count].misc_op == MISC_OP_CB_PREFIX) begin
                // We have a CB-prefixed instruction so we keep going
                control_word <= cb_control_words[regs.IR];
                // Importantly we do not set the instruction boundary here
              end else begin
                // Normal instruction end; fetch next instruction
                control_word   <= control_words[regs.IR];
                instr_boundary <= 1'b1;

                // After completing an instruction, check for interrupts
                if (regs.IME) begin

                  logic [4:0] pending;
                  pending = IF[4:0] & IE[4:0];

                  if ((pending) != 5'b0) begin

                    // $display("[CPU] Interrupt detected: IF=%b IE=%b Pending=%b", IF, IE, pending);

                    // Interrupt detected -> take the highest priority
                    if (pending[0]) begin  // VBlank
                      IF[3'd0] <= 1'b0;
                      control_word <= interrupt_words[3'd0];
                    end else if (pending[1]) begin  // STAT
                      IF[3'd1] <= 1'b0;
                      control_word <= interrupt_words[3'd1];
                    end else if (pending[2]) begin  // Timer
                      IF[3'd2] <= 1'b0;
                      control_word <= interrupt_words[3'd2];
                    end else if (pending[3]) begin  // Serial
                      IF[3'd3] <= 1'b0;
                      control_word <= interrupt_words[3'd3];
                    end else if (pending[4]) begin  // Joypad
                      IF[3'd4] <= 1'b0;
                      control_word <= interrupt_words[3'd4];
                    end

                    // // Disable master interrupt
                    // regs.IME <= 1'b0;

                    instr_boundary <= 1'b0;  // Now executing new implicit instruction
                  end
                end
              end
            end else begin
              // We are still in the middle of the instruction
              cycle_count <= cycle_count + 1;
            end

            `LOG_TRACE(("[CPU] End of T4: Next cycle=%0d Next phase=T1 PC=%h", cycle_count, {
                       regs.pch, regs.pcl}))

            t_phase <= T1;

          end
        endcase
      end
    end
  end

  // ======================================================
  // Interrupt Read/Write Logic
  // ======================================================

  // Write
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      IF <= 8'b11100000;
      IE <= 8'd0;
    end else begin
      if (interrupt_bus.write_en) begin
        if (interrupt_bus.addr == 16'hFF0F) begin
          IF <= (interrupt_bus.wdata & 8'b00011111) | 8'b11100000;
        end else if (interrupt_bus.addr == 16'hFFFF) begin
          IE <= interrupt_bus.wdata;
        end
      end

      if (IF_bus.vblank_req) IF[0] <= 1'b1;
      if (IF_bus.stat_req) begin
        IF[1] <= 1'b1;
      end
      if (IF_bus.timer_req) IF[2] <= 1'b1;
      if (IF_bus.serial_req) IF[3] <= 1'b1;
      if (IF_bus.joypad_req) IF[4] <= 1'b1;
    end
  end

  // Read
  always_comb begin
    interrupt_bus.rdata = 8'h00;
    if (interrupt_bus.read_en) begin
      if (interrupt_bus.addr == 16'hFF0F) begin
        interrupt_bus.rdata = IF;
      end else if (interrupt_bus.addr == 16'hFFFF) begin
        interrupt_bus.rdata = IE;
      end
    end
  end

endmodule

`endif  // CPU_SV
