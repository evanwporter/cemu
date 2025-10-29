`ifndef CPU_SV
`define CPU_SV 

`include "types.sv"
`include "opcodes.sv"
`include "control_words.sv"

`define DEFINE_REG_PAIR(PAIR, HI, LO) \
  function automatic logic [15:0] get_``PAIR``(cpu_regs_t regs); \
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

    // MMU request
    output bus_op_t mmu_req_op,
    output bus_size_t mmu_req_size,
    output logic [15:0] mmu_req_addr,  // we put the address we want to read/write here
    output logic [15:0] mmu_req_wdata,  // data to write to MMU

    // MMU response
    input logic mmu_resp_done,
    input logic [15:0] mmu_resp_rdata  // data to read from MMU
);

  typedef enum logic [1:0] {
    FETCH,
    DECODE,
    EXECUTE
  } state_t;

  typedef enum logic {
    FETCH_REQUEST,
    FETCH_WAIT
  } fetch_state_t;

  typedef enum logic [3:0] {
    EX_READ_SRC,
    EX_WAIT_READ_IMM,
    EX_WAIT_READ_ADDR,
    EX_OP,
    EX_WRITE_DST,
    EX_WAIT_WRITE_IMM,
    EX_WAIT_WRITE_ADDR,
    EX_DONE
  } execute_state_t;

  cpu_regs_t regs;

  state_t state;
  fetch_state_t fetch_state;
  execute_state_t ex_state;

  // Temporary data
  logic [7:0] opcode_q;

  // current control word
  control_word_t cw;

  // Temporaries that must persist across ex states

  // selected value from source
  // this is the value that we perform operations on
  logic [15:0] selected_val_q;

  logic [15:0] mem_addr_q;
  logic mem_read_req_q;
  logic [7:0] mmu_read_latch;

  logic write_enable_q;

  // Basic fetch loop
  always_ff @(posedge clk) begin
    if (reset) begin
      regs.pc <= 16'h0100;
      regs.sp <= 16'hFFFE;
      state <= FETCH;
      fetch_state <= FETCH_REQUEST;
      ex_state <= EX_READ_SRC;
      // TODO: clear regs
    end else begin

      unique case (state)
        FETCH: begin
          // Fetch next opcode
          unique case (fetch_state)
            FETCH_REQUEST: begin
              if (mmu_req_op == BUS_OP_IDLE) begin
                mmu_req_addr <= regs.pc;
                mmu_req_op   <= BUS_OP_READ;
                fetch_state  <= FETCH_WAIT;
              end
            end

            FETCH_WAIT: begin
              if (mmu_resp_done) begin
                opcode_q <= mmu_resp_rdata[7:0];
                regs.pc <= regs.pc + 1;
                fetch_state <= FETCH_REQUEST;
                state <= DECODE;
              end
            end
          endcase
        end

        DECODE: begin
          cw <= control_words[opcode_q];
          state <= EXECUTE;
        end

        EXECUTE: begin

          unique case (ex_state)
            EX_READ_SRC: begin
              logic [15:0] selected_val_d;

              // memory address we need to use if source is an address
              logic [15:0] mem_addr_d;

              enum logic [1:0] {
                EX_NEXT_OP,
                EX_NEXT_IMM,
                EX_NEXT_ADDR
              } ex_next_state;

              // we either read from the register or from memory
              // in the first case we place the value directly into selected_val_q
              // in the second case we set mem_addr_d and mem_read_req
              unique case (cw.src_sel)
                // Immediate address modes need to fetch data first
                REG_IMM8:
                REG_ADDR_IMM8 : begin
                  mmu_req_size  <= BUS_SIZE_BYTE;
                  ex_next_state <= EX_NEXT_IMM;
                end

                REG_IMM16:
                REG_ADDR_IMM16 : begin
                  mmu_req_addr  <= regs.pc;
                  ex_next_state <= EX_NEXT_IMM;
                end

                REG_A: begin
                  selected_val_q <= {8'h00, regs.a};
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_B: begin
                  selected_val_q <= {8'h00, regs.b};
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_C: begin
                  selected_val_q <= {8'h00, regs.c};
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_D: begin
                  selected_val_q <= {8'h00, regs.d};
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_E: begin
                  selected_val_q <= {8'h00, regs.e};
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_H: begin
                  selected_val_q <= {8'h00, regs.h};
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_L: begin
                  selected_val_q <= {8'h00, regs.l};
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_FLAGS: begin
                  selected_val_q <= {8'h00, regs.flags};
                  ex_next_state  <= EX_NEXT_OP;
                end

                REG_AF: begin
                  selected_val_q <= get_af(regs);
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_BC: begin
                  selected_val_q <= get_bc(regs);
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_DE: begin
                  selected_val_q <= get_de(regs);
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_HL: begin
                  selected_val_q <= get_hl(regs);
                  ex_next_state  <= EX_NEXT_OP;
                end

                REG_SP: begin
                  selected_val_q <= regs.sp;
                  ex_next_state  <= EX_NEXT_OP;
                end
                REG_PC: begin
                  selected_val_q <= regs.pc;
                  ex_next_state  <= EX_NEXT_OP;
                end


                // Memory-indirects
                REG_ADDR_HL: begin
                  mmu_req_addr  <= get_hl(regs);
                  ex_next_state <= EX_NEXT_ADDR;
                end

                REG_ADDR_BC: begin
                  mmu_req_addr  <= get_bc(regs);
                  ex_next_state <= EX_NEXT_ADDR;
                end

                REG_ADDR_DE: begin
                  mmu_req_addr  <= get_de(regs);
                  ex_next_state <= EX_NEXT_ADDR;
                end

                REG_ADDR_SP: begin
                  mmu_req_addr  <= regs.sp;
                  ex_next_state <= EX_NEXT_ADDR;
                end

                REG_NONE: begin
                  selected_val_q <= 16'b0;
                  ex_next_state  <= EX_NEXT_OP;
                end

                default: ex_next_state <= EX_NEXT_OP;
              endcase

              // TODO: We need to move the IMM8, IMM16, ADDR_IMM8, ADDR_IMM16 handling
              // outside of the decode_read_sel function. Then when these modes are triggered
              // we need to read the value from memory here first before proceeding.
              // The same needs to be done for the write side as well.

              // TODO: Add a 16bit read mode to MMU.

              // TODO: Allow selected value to be 8bit or 16bit depending on operation
              // The only time we need 16bit reads is for immediate 16bit values which
              // is for loading values directly into registers.
              // This should also be done for the write side as well.

              unique case (ex_next_state)
                EX_NEXT_IMM: begin
                  // configure MMU to read immediate byte
                  mmu_req_addr <= regs.pc;
                  mmu_req_op   <= BUS_OP_READ;
                  ex_state     <= EX_WAIT_READ_IMM;
                end

                EX_NEXT_ADDR: begin
                  // configure MMU to read address from memory
                  mmu_req_op <= BUS_OP_READ;
                  ex_state   <= EX_WAIT_READ_ADDR;
                end

                EX_NEXT_OP: begin
                  ex_state <= EX_OP;
                end

              endcase
            end

            EX_WAIT_READ_IMM: begin
              if (mmu_resp_done) begin
                if (cw.src_sel == REG_IMM8 || cw.src_sel == REG_IMM16) begin
                  selected_val_q <= mmu_resp_rdata;
                  ex_state <= EX_OP;
                end else if (cw.src_sel == REG_ADDR_IMM8) begin
                  mmu_req_addr <= {8'hFF, mmu_resp_rdata[7:0]};
                  mmu_req_size <= BUS_SIZE_BYTE;
                  mmu_req_op <= BUS_OP_READ;
                  ex_state <= EX_WAIT_READ_ADDR;
                end else if (cw.src_sel == REG_ADDR_IMM16) begin
                  mmu_req_addr <= mmu_resp_rdata;
                  mmu_req_size <= BUS_SIZE_WORD;
                  mmu_req_op <= BUS_OP_READ;
                  ex_state <= EX_WAIT_READ_ADDR;
                end
              end
            end

            // TODO: ADD ANOTHER STATE CALLED WAIT TO READ

            // We wait here for the MMU to finish reading
            EX_WAIT_READ_ADDR: begin
              if (mmu_resp_done) begin
                // Capture read data
                selected_val_q <= mmu_resp_rdata;
                ex_state <= EX_OP;
              end
            end

            EX_OP: begin
              // Perform operation here using selected_val and cw
              ex_state <= EX_WRITE_DST;
              selected_val_q <= 16'b0;  // result of operation
            end

            EX_WRITE_DST: begin
              // Local temporaries
              logic [15:0] mem_addr_d;
              logic [7:0] mem_write_data_d;
              logic mem_write_req_d;

              // Next step after decoding write
              enum logic [1:0] {
                EX_NEXT_OP,
                EX_NEXT_IMM,
                EX_NEXT_ADDR
              } ex_next_state;

              // Determine write destination
              unique case (cw.dst_sel)
                // TODO: Check whether its possible to write a full 16bit 
                // value to an immediate address
                // Check whether its possible for there to be 8 bit immediate
                // address writes

                // Immediate destinations — need to read address from instruction first
                REG_IMM8: begin
                  mem_addr_d <= regs.pc;
                  mem_write_data_d <= selected_val_q[7:0];
                  mem_write_req_d <= 1'b1;
                  ex_next_state <= EX_NEXT_ADDR;
                end

                REG_ADDR_IMM16: begin
                  mmu_req_addr <= regs.pc;
                  mmu_req_size <= BUS_SIZE_WORD;
                  mmu_req_op <= BUS_OP_READ;
                  ex_next_state <= EX_NEXT_IMM;
                end

                // Register writes (no memory access)
                REG_A: begin
                  regs.a <= selected_val_q[7:0];
                  ex_next_state <= EX_NEXT_OP;
                end
                REG_B: begin
                  regs.b <= selected_val_q[7:0];
                  ex_next_state <= EX_NEXT_OP;
                end
                REG_C: begin
                  regs.c <= selected_val_q[7:0];
                  ex_next_state <= EX_NEXT_OP;
                end
                REG_D: begin
                  regs.d <= selected_val_q[7:0];
                  ex_next_state <= EX_NEXT_OP;
                end
                REG_E: begin
                  regs.e <= selected_val_q[7:0];
                  ex_next_state <= EX_NEXT_OP;
                end
                REG_H: begin
                  regs.h <= selected_val_q[7:0];
                  ex_next_state <= EX_NEXT_OP;
                end
                REG_L: begin
                  regs.l <= selected_val_q[7:0];
                  ex_next_state <= EX_NEXT_OP;
                end

                REG_AF: begin
                  set_af(regs, selected_val_q);
                  ex_next_state <= EX_NEXT_OP;
                end
                REG_BC: begin
                  set_bc(regs, selected_val_q);
                  ex_next_state <= EX_NEXT_OP;
                end
                REG_DE: begin
                  set_de(regs, selected_val_q);
                  ex_next_state <= EX_NEXT_OP;
                end
                REG_HL: begin
                  set_hl(regs, selected_val_q);
                  ex_next_state <= EX_NEXT_OP;
                end

                REG_SP: begin
                  regs.sp <= selected_val_q;
                  ex_next_state <= EX_NEXT_OP;
                end
                REG_PC: begin
                  regs.pc <= selected_val_q;
                  ex_next_state <= EX_NEXT_OP;
                end

                // Memory-indirects
                REG_ADDR_HL: begin
                  mem_addr_d       <= get_hl(regs);
                  mem_write_data_d <= selected_val_q[7:0];
                  mem_write_req_d  <= 1'b1;
                  ex_next_state    <= EX_NEXT_ADDR;
                end
                REG_ADDR_BC: begin
                  mem_addr_d       <= get_bc(regs);
                  mem_write_data_d <= selected_val_q[7:0];
                  mem_write_req_d  <= 1'b1;
                  ex_next_state    <= EX_NEXT_ADDR;
                end
                REG_ADDR_DE: begin
                  mem_addr_d       <= get_de(regs);
                  mem_write_data_d <= selected_val_q[7:0];
                  mem_write_req_d  <= 1'b1;
                  ex_next_state    <= EX_NEXT_ADDR;
                end
                REG_ADDR_SP: begin
                  mem_addr_d       <= regs.sp;
                  mem_write_data_d <= selected_val_q[7:0];
                  mem_write_req_d  <= 1'b1;
                  ex_next_state    <= EX_NEXT_ADDR;
                end

                REG_IMM_S8, REG_ADDR_IMM8, REG_IMM16, REG_NONE: ex_next_state <= EX_NEXT_OP;

                default: ex_next_state <= EX_NEXT_OP;

              endcase

              // Determine what happens next
              unique case (ex_next_state)
                EX_NEXT_IMM: begin
                  ex_state <= EX_WAIT_WRITE_IMM;
                end
                EX_NEXT_ADDR: begin
                  mmu_req_addr  <= mem_addr_d;
                  mmu_req_wdata <= {8'h00, mem_write_data_d};
                  mmu_req_op    <= BUS_OP_WRITE;
                  ex_state      <= EX_WAIT_WRITE_ADDR;
                end
                EX_NEXT_OP: begin
                  ex_state <= EX_DONE;
                end
              endcase
            end

            EX_WAIT_WRITE_IMM: begin
              if (mmu_resp_done) begin
                if (cw.src_sel == REG_IMM8 || cw.src_sel == REG_IMM16) begin
                  selected_val_q <= mmu_resp_rdata;
                  ex_state <= EX_OP;
                end  // We fetched immediate address to write to
                else if (cw.dst_sel == REG_ADDR_IMM8) begin
                  mmu_req_addr  <= {8'hFF, mmu_resp_rdata[7:0]};
                  mmu_req_wdata <= {8'h00, selected_val_q[7:0]};
                  mmu_req_op    <= BUS_OP_WRITE;
                  ex_state      <= EX_WAIT_WRITE_ADDR;
                end else if (cw.dst_sel == REG_ADDR_IMM16) begin
                  mmu_req_addr  <= mmu_resp_rdata;
                  mmu_req_wdata <= {8'h00, selected_val_q[7:0]};
                  mmu_req_op    <= BUS_OP_WRITE;
                  ex_state      <= EX_WAIT_WRITE_ADDR;
                end
              end
            end

            EX_WAIT_WRITE_ADDR: begin
              if (mmu_resp_done) begin
                mmu_req_op <= BUS_OP_IDLE;
                ex_state   <= EX_DONE;
              end
            end

            EX_DONE: begin
              // Operation complete, go back to fetch
              state <= FETCH;
            end
          endcase
        end
      endcase
    end
  end

endmodule

`endif
