`ifndef CPU_SV
`define CPU_SV 

`include "cpu/types.sv"
`include "cpu/opcodes.sv"
`include "cpu/control_words.sv"
`include "cpu/util.sv"

`include "util/logger.svh"

`include "mmu/interface.sv"

module CPU (
    input logic clk,
    input logic reset,

    Bus_if.CPU_side bus
);

  /// The CPU register
  cpu_regs_t regs;

  /// Current control word; instructions being executed
  control_word_t control_word;

  /// Curent machine cycle within instruction
  cycle_count_t cycle_count;

  /// Current t-cycle within machine cycle
  t_phase_t t_phase;

  logic instr_boundary;

  localparam cycle_count_t MAX_CYCLE_INDEX = MAX_CYCLES_PER_INSTR - 1;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      {regs.pch, regs.pcl} <= 16'h0000;
      {regs.sph, regs.spl} <= 16'hFFFE;
      t_phase <= T1;
      cycle_count <= '0;
      control_word <= control_words[0];  // NOP
      bus.read_en <= 1'b0;
      bus.write_en <= 1'b0;
      bus.wdata <= '0;
      instr_boundary <= 1'b0;

      `LOG_INFO(("[CPU] RESET: PC=%04h SP=%04h", {regs.pch, regs.pcl}, {regs.sph, regs.spl}));

    end else begin
      `LOG_TRACE(
          ("[CPU] Phase=%s Cycle=%0d PC=%04h Addr=%04h ReadDataBus=%02h IR=%02h", 
               t_phase.name(), cycle_count, {
          regs.pch, regs.pcl}, bus.addr, bus.rdata, regs.IR));

      instr_boundary <= 1'b0;
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
              `LOG_TRACE(("[CPU] READ request at addr %h", bus.addr));
            end
            DATA_BUS_OP_WRITE: begin
              bus.wdata    <= pick_wdata(control_word.cycles[cycle_count].data_bus_src, regs);
              bus.write_en <= 1'b1;
              bus.read_en  <= 1'b0;
              `LOG_TRACE(("[CPU] WRITE request at addr %h data=%h", bus.addr, bus.wdata));
            end
            DATA_BUS_OP_NONE: begin
              bus.write_en <= 1'b0;
              bus.read_en  <= 1'b0;
            end
          endcase

          t_phase <= T3;
        end

        /// T3 is generally the cycle where data is read from the bus or the write is completed.
        T3: begin
          if (control_word.cycles[cycle_count].data_bus_op == DATA_BUS_OP_READ) begin
            `LOAD_REG_FROM_BYTE(control_word.cycles[cycle_count].data_bus_src, bus.rdata, regs);
            `LOG_TRACE(("[CPU] READ complete: data=%h", bus.rdata));
          end
          t_phase <= T4;
        end

        T4: begin

          `DISPLAY_CONTROL_WORD(control_word, cycle_count);

          // applies the idu op to the address bus
          if (control_word.cycles[cycle_count].idu_dst == ADDR_NONE) begin
            `APPLY_IDU_OP(control_word.cycles[cycle_count].addr_src,
                          control_word.cycles[cycle_count].addr_src,
                          control_word.cycles[cycle_count].idu_op, regs);
          end else begin
            `APPLY_IDU_OP(control_word.cycles[cycle_count].addr_src,
                          control_word.cycles[cycle_count].idu_dst,
                          control_word.cycles[cycle_count].idu_op, regs);
          end

          // applies the alu op to the specified registers
          `APPLY_ALU_OP(control_word.cycles[cycle_count].alu_op,
                        control_word.cycles[cycle_count].alu_dst,
                        control_word.cycles[cycle_count].alu_src, regs);

          // applies the misc op to the specified registers
          `APPLY_MISC_OP(control_word.cycles[cycle_count].misc_op,
                         control_word.cycles[cycle_count].misc_op_dst, regs);

          bus.read_en  <= 1'b0;
          bus.write_en <= 1'b0;

          if (control_word.cycles[cycle_count].misc_op == MISC_OP_COND_CHECK &&  //
              !eval_condition(
                  control_word.cycles[cycle_count].cond, regs.flags
              )) begin
            // Condition failed; skip to 5th cycle (which has the final cycle instruction)
            cycle_count <= MAX_CYCLE_INDEX;
          end else if (cycle_count + 1 >= control_word.num_cycles) begin
            cycle_count <= '0;
            control_word <= control_words[regs.IR];
            instr_boundary <= 1'b1;
          end else begin
            cycle_count <= cycle_count + 1;
          end

          `LOG_TRACE(("[CPU] End of T4: Next cycle=%0d Next phase=T1 PC=%h", cycle_count, {
                     regs.pch, regs.pcl}));

          t_phase <= T1;

        end
      endcase
    end
  end

endmodule

`endif  // CPU_SV
