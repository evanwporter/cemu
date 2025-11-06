`ifndef CPU_SV
`define CPU_SV 

`include "types.sv"
`include "cpu/opcodes.sv"
`include "cpu/control_words.sv"
`include "cpu/util.sv"
`include "util/logger.sv"

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
`undef DEFINE_REG_PAIR

module CPU (
    input logic clk,
    input logic reset,

    output logic [15:0] addr_bus,
    inout  logic [ 7:0] data_bus,

    output logic MMU_req_read,
    output logic MMU_req_write
);

  /// The CPU register
  cpu_regs_t regs;

  /// Current control word; instructions being executed
  control_word_t control_word;

  /// Curent machine cycle within instruction
  cycle_count_t cycle_count;

  /// Current t-cycle within machine cycle
  t_phase_t t_phase;

  // CPU-side bus control
  logic cpu_drive_data;
  logic [7:0] cpu_wdata;
  logic [7:0] cpu_rdata;

  localparam cycle_count_t MAX_CYCLE_INDEX = MAX_CYCLES_PER_INSTR - 1;

  // CPU drives bus only on writes; otherwise Hi-Z and MMU can drive
  assign data_bus = cpu_drive_data ? cpu_wdata : 'z;

  always_ff @(posedge clk) begin
    if (reset) begin
      regs.pc <= 16'h0000;
      regs.sp <= 16'hFFFE;
      t_phase <= T1;
      cycle_count <= '0;
      control_word <= control_words[0];  // NOP
      MMU_req_read <= 1'b0;
      MMU_req_write <= 1'b0;
      cpu_drive_data <= 1'b0;
      cpu_wdata <= '0;

      $display("[%0t] CPU RESET: PC=%h SP=%h", $time, regs.pc, regs.sp);

    end else begin
      $display("[%0t] Phase=%s Cycle=%0d PC=%h Addr=%h DataBus=%h IR=%h", $time, t_phase.name(),
               cycle_count, regs.pc, addr_bus, data_bus, regs.IR);
      unique case (t_phase)
        T1: begin
          addr_bus <= regs.pc;
          unique case (control_word.cycles[cycle_count].addr_src)
            ADDR_PC: addr_bus <= regs.pc;
            ADDR_SP: addr_bus <= regs.sp;
            default: begin
            end
          endcase
          t_phase <= T2;
        end

        T2: begin
          unique case (control_word.cycles[cycle_count].data_bus_op)
            DATA_BUS_OP_READ: begin
              MMU_req_read   <= 1'b1;
              MMU_req_write  <= 1'b0;
              cpu_drive_data <= 1'b0;  // MMU will drive
              $display("[%0t] READ request at addr %h", $time, addr_bus);
            end
            DATA_BUS_OP_WRITE: begin
              cpu_wdata      <= pick_wdata(control_word.cycles[cycle_count].data_bus_src, regs);
              MMU_req_write  <= 1'b1;
              MMU_req_read   <= 1'b0;
              cpu_drive_data <= 1'b1;  // CPU drives for write
              $display("[%0t] WRITE request at addr %h data=%h", $time, addr_bus, cpu_wdata);
            end
            DATA_BUS_OP_NONE: begin
              MMU_req_write  <= 1'b0;
              MMU_req_read   <= 1'b0;
              cpu_drive_data <= 1'b0;  // No bus activity
            end
          endcase

          t_phase <= T3;
        end

        T3: begin
          if (control_word.cycles[cycle_count].data_bus_op == DATA_BUS_OP_READ) begin
            `LOAD_REG_FROM_BYTE(control_word.cycles[cycle_count].data_bus_src, data_bus, regs);
            $display("[%0t] READ complete: data=%h", $time, data_bus);
          end
          t_phase <= T4;
        end

        T4: begin

          `DISPLAY_CONTROL_WORD(control_word);

          // applies the idu op to the address bus
          `APPLY_IDU_OP(control_word.cycles[cycle_count].addr_src,
                        control_word.cycles[cycle_count].idu_op, regs);

          // applies the alu op to the specified registers
          apply_alu_op(control_word.cycles[cycle_count].alu_op,
                       control_word.cycles[cycle_count].alu_dst,
                       control_word.cycles[cycle_count].alu_src, regs);

          // applies the misc op to the specified registers
          `APPLY_MISC_OP(control_word.cycles[cycle_count].misc_op, regs);

          MMU_req_read  <= 1'b0;
          MMU_req_write <= 1'b0;

          if (control_word.cycles[cycle_count].misc_op == MISC_OP_COND_CHECK &&  //
              !eval_condition(
                  control_word.cycles[cycle_count].cond, regs.flags
              ))
            // Condition failed; skip to 5th cycle (which has the final cycle instruction)
            cycle_count <= MAX_CYCLE_INDEX;
          else if (cycle_count >= control_word.num_cycles) cycle_count <= '0;
          else cycle_count <= cycle_count + 1;

          $display("[%0t] End of T4: Next cycle=%0d Next phase=T1 PC=%h", $time, cycle_count,
                   regs.pc);

          t_phase <= T1;

        end
      endcase
    end
  end

endmodule

`endif  // CPU_SV
