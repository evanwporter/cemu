`include "types.sv"
`include "opcodes.sv"

`define DEFINE_REG_PAIR(PAIR, HI, LO) \
  function automatic logic [15:0] get_``PAIR``(cpu_regs_t regs); \
    return {regs.``HI``, regs.``LO``}; \
  endfunction \
  \
  function automatic void set_``PAIR``(ref cpu_regs_t regs, logic [15:0] val); \
    regs.``HI`` = val[15:8]; \
    regs.``LO`` = val[7:0]; \
  endfunction

`DEFINE_REG_PAIR(af, a, f)
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
    EX_FETCH_IMM,
    EX_WAIT_READ_ADDR,
    EX_OP,
    EX_WRITE_DST,
    EX_WAIT_WRITE,
    EX_WRITE_ADDR,
    EX_DONE
  } execute_state_t;

  cpu_regs_t regs;

  state_t state;
  fetch_state_t fetch_state;
  execute_state_t ex_state;

  // Temporary data
  logic [7:0] opcode_q;

  control_word_t control_rom[0:255];

  // current control word
  control_word_t cw;

  // Temporaries that must persist across ex states

  // selected value from source
  // this is the value that we perform operations on
  logic [15:0] selected_val_q;

  logic [15:0] mem_addr_q;
  logic mem_read_req_q;
  logic [7:0] mmu_read_latch;

  // This will be the output of the execute stage
  // eventually this is written into dst
  logic [15:0] new_val_q;

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
                opcode_q <= mmu_resp_rdata;
                regs.pc <= regs.pc + 1;
                fetch_state <= FETCH_REQUEST;
                state <= DECODE;
              end
            end
          endcase
        end

        DECODE: begin
          cw <= control_rom[opcode_q];
          state <= EXECUTE;
        end

        EXECUTE: begin

          unique case (ex_state)
            EX_READ_SRC: begin
              logic [15:0] selected_val_d;

              // memory address we need to use if source is an address
              logic [15:0] mem_addr_d;

              // boolean indicating whether a memory read is required
              logic mem_read_req_d;

              // we either read from the register or from memory
              // in the first case we place the value directly into selected_val_q
              // in the second case we set mem_addr_d and mem_read_req
              unique case (cw.src_sel)
                // Immediate address modes need to fetch data first
                REG_IMM8:
                REG_ADDR_IMM8 : begin
                  if (mmu_req_op == BUS_OP_IDLE) begin
                    mmu_req_addr <= regs.pc;
                    mmu_req_size <= BUS_SIZE_BYTE;
                    mmu_req_op <= BUS_OP_READ;
                    ex_state <= EX_WAIT_READ_ADDR;
                  end
                end

                REG_IMM16:
                REG_ADDR_IMM16 : begin
                  if (mmu_req_op == BUS_OP_IDLE) begin
                    mmu_req_addr <= regs.pc;
                    mmu_req_size <= BUS_SIZE_WORD;
                    mmu_req_op <= BUS_OP_READ;
                    ex_state <= EX_WAIT_READ_ADDR;
                  end
                end

                REG_A: selected_val_q <= {8'h00, regs.a};
                REG_B: selected_val_q <= {8'h00, regs.b};
                REG_C: selected_val_q <= {8'h00, regs.c};
                REG_D: selected_val_q <= {8'h00, regs.d};
                REG_E: selected_val_q <= {8'h00, regs.e};
                REG_H: selected_val_q <= {8'h00, regs.h};
                REG_L: selected_val_q <= {8'h00, regs.l};

                REG_AF: selected_val_q <= get_af(regs);
                REG_BC: selected_val_q <= get_bc(regs);
                REG_DE: selected_val_q <= get_de(regs);
                REG_HL: selected_val_q <= get_hl(regs);
                REG_SP: selected_val_q <= regs.sp;
                REG_PC: selected_val_q <= regs.pc;

                // Memory-indirects
                REG_ADDR_HL: begin
                  mmu_req_addr   <= get_hl(regs);
                  mem_read_req_d <= 1'b1;
                end

                REG_ADDR_BC: begin
                  mmu_req_addr   <= get_bc(regs);
                  mem_read_req_d <= 1'b1;
                end

                REG_ADDR_DE: begin
                  mmu_req_addr   <= get_de(regs);
                  mem_read_req_d <= 1'b1;
                end

                REG_ADDR_SP: begin
                  mmu_req_addr   <= regs.sp;
                  mem_read_req_d <= 1'b1;
                end
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

              if (mem_read_req_d) begin
                // TODO: Check if MMU is idle if its not then we have to wait

                // configure MMU to read address from memory
                mmu_req_op <= BUS_OP_READ;
                mmu_req_size <= BUS_SIZE_BYTE;
                mmu_req_addr <= mem_addr_d;

                ex_state <= EX_WAIT_READ_ADDR;

              end else begin
                // No memory read required, proceed to operation
                ex_state <= EX_OP;
              end
            end

            EX_FETCH_IMM: begin
              if (mmu_resp_done) begin
                if (cw.src_sel == REG_IMM8 || cw.src_sel == REG_IMM16) begin
                  selected_val_q <= mmu_resp_rdata;
                  ex_state <= EX_OP;
                end else if (cw.src_sel == REG_ADDR_IMM8) begin
                  mmu_req_addr <= {8'hFF, mmu_resp_rdata};
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
              ex_state  <= EX_WRITE_DST;
              new_val_q <= 16'b0;  /* result of operation */
            end

            EX_WRITE_DST: begin
              // Address we write to
              logic [15:0] mem_addr_d;

              // Data we write
              logic [7:0] mem_write_data_d;

              // Memory write request flag (do we need to write to MMU?)
              logic mem_write_req_d;

              // we either write to the register or to memory
              decode_write_sel(write_enable_q,  //
                               cw.dst_sel,  //
                               new_val_q,  //
                               regs,  // 
                               // outputs
                               mem_addr_d, mem_write_data_d, mem_write_req_d);

              if (mem_write_req_d) begin
                mmu_req_addr <= mem_addr_d;
                mmu_req_wdata <= mem_write_data_d;
                mmu_req_op <= BUS_OP_WRITE;
                ex_state <= EX_WAIT_WRITE;
              end else begin
                ex_state <= EX_DONE;
              end
            end

            EX_WAIT_WRITE: begin
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
