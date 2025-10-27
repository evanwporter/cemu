typedef enum logic [1:0] {
  FETCH,
  DECODE,
  EXECUTE
} state_t;

typedef enum logic {
  FETCH_REQUEST,
  FETCH_WAIT
} fetch_state_t;

typedef enum logic [2:0] {
  EX_READ_SRC,
  EX_WAIT_READ,
  EX_OP,
  EX_WRITE_DST,
  EX_WAIT_WRITE,
  EX_DONE
} execute_state_t;

typedef struct packed {
  logic [7:0]  a;
  logic [7:0]  f;
  logic [7:0]  b;
  logic [7:0]  c;
  logic [7:0]  d;
  logic [7:0]  e;
  logic [7:0]  h;
  logic [7:0]  l;
  logic [15:0] sp;
  logic [15:0] pc;
} cpu_regs_t;

// AF pair
function automatic logic [15:0] get_af(cpu_regs_t regs);
  return {regs.a, regs.f};
endfunction

function automatic void set_af(ref cpu_regs_t regs, logic [15:0] val);
  regs.a = val[15:8];
  regs.f = val[7:0];
endfunction

// BC pair
function automatic logic [15:0] get_bc(cpu_regs_t regs);
  return {regs.b, regs.c};
endfunction

function automatic void set_bc(ref cpu_regs_t regs, logic [15:0] val);
  regs.b = val[15:8];
  regs.c = val[7:0];
endfunction

// DE pair
function automatic logic [15:0] get_de(cpu_regs_t regs);
  return {regs.d, regs.e};
endfunction

function automatic void set_de(ref cpu_regs_t regs, logic [15:0] val);
  regs.d = val[15:8];
  regs.e = val[7:0];
endfunction

// HL pair
function automatic logic [15:0] get_hl(cpu_regs_t regs);
  return {regs.h, regs.l};
endfunction

function automatic void set_hl(ref cpu_regs_t regs, logic [15:0] val);
  regs.h = val[15:8];
  regs.l = val[7:0];
endfunction

module CPU (
    input logic clk,
    input logic reset,

    // MMU interface
    output bus_op_t mmu_bus_op,

    // we put the address we want to read/write here
    output logic [15:0] mmu_addr,

    // data to write to MMU
    output logic [7:0] mmu_write_data,

    // data to read from MMU
    input logic [7:0] mmu_read_data
);

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
  logic [15:0] sel_val_q;
  logic [15:0] mem_addr_q;
  logic [7:0] mmu_read_latch;

  // This will be the output of the execute stage
  // eventually this is written into dst
  logic [15:0] new_val_q;

  logic write_enable_q;

  // Immediate values
  logic [7:0] imm8_q;
  logic [15:0] imm16_q;

  // Basic fetch loop
  always_ff @(posedge clk) begin
    if (reset) begin
      reg_pc <= 16'h0100;
      reg_sp <= 16'hFFFE;
      state <= FETCH_REQ;
      ex_state <= EX_READ_SRC;
      // TODO: clear regs
    end else begin

      unique case (state)
        FETCH: begin
          // Fetch next opcode
          unique case (fetch_state)
            FETCH_REQUEST: begin
              if (mmu_bus_op == BUS_IDLE) begin
                mmu_addr <= reg_pc;
                mmu_bus_op <= BUS_READ;
                fetch_state <= FETCH_WAIT;
              end
            end

            FETCH_WAIT: begin
              if (mmu_bus_op == BUS_FINISHED_OP) begin
                opcode_q <= mmu_read_data;
                mmu_bus_op <= BUS_IDLE;
                reg_pc <= reg_pc + 1;
                fetch_state <= FETCH_REQUEST;
                state <= DECODE;
              end
            end
          endcase
        end

        DECODE: begin
          cw <= control_rom[opcode];
          read_en <= 1'b0;
          state <= EXECUTE;
        end

        EXECUTE: begin

          unique case (ex_state)
            EX_READ_SRC: begin
              // selected value from source (if we don't need memory read, this is ready immediately)
              logic [15:0] selected_val_d;

              // memory address we need to use if source is an address
              logic [15:0] mem_addr_d;

              // boolean indicating whether a memory read is required
              logic mem_read_req;

              // we either read from the register or from memory
              // in the first case we place the value directly into selected_val_d
              // in the second case we set mem_addr_d and mem_read_req
              decode_read_sel(cw.src_sel, regs_q,  //
                              imm8_q, imm16_q,  // 
                              selected_val_d,  // 
                              mem_addr_d,  //
                              mem_read_req_d);

              // TODO: We need to move the IMM8, IMM16, ADDR_IMM8, ADDR_IMM16 handling
              // outside of the decode_read_sel function. Then when these modes are triggered
              // we need to read the value from memory here first before proceeding.

              // TODO: Add a 16bit read mode to MMU.

              // TODO: Allow selected value to be 8bit or 16bit depending on operation


              if (mem_read_req_d) begin
                // TODO: Check if MMU is idle if its not then we have to wait
                mmu_bus_op <= BUS_READ;
                ex_state   <= EX_WAIT_READ;

                // we place the address into a global state here so 
                // we can use it on the next cycle (if needed)
                mem_addr_q <= mem_addr_d;
              end else begin
                // we place the selected value directly into the sel_val_q
                // so we can use it in the next state/cycle
                sel_val_q <= selected_val_d;

                ex_state  <= EX_OP;
              end
            end

            // ADD ANOTHER STATE CALLED WAIT TO READ

            // We wait here for the MMU to finish reading
            EX_WAIT_READ: begin
              if (mmu_bus_op == BUS_FINISHED_OP) begin
                // Capture read data
                sel_val_q  <= mmu_rdata;
                mmu_bus_op <= BUS_IDLE;
                ex_state   <= EX_OP;
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
                               regs_q,  // 
                               imm8_q, imm16_q, regs_next,  //
                               // outputs
                               mem_addr_d, mem_write_data_d, mem_write_req_d);

              if (mem_write_req_d) begin
                mmu_addr <= mem_addr_d;
                mmu_write_data <= mem_write_data_d;
                mmu_bus_op <= BUS_WRITE;
                ex_state <= EX_WAIT_WRITE;
              end else begin
                ex_state <= EX_DONE;
              end
            end

            EX_WAIT_WRITE: begin
              if (mmu_bus_op == BUS_FINISHED_OP) begin
                mmu_bus_op <= BUS_IDLE;
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
