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
    // read data
    output bus_op_t mmu_bus_op,
    output logic [15:0] mmu_addr,
    output logic [7:0] mmu_write_data,
    input logic [7:0] mmu_read_data
);
  // verilog_format: off

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
  logic [15:0] new_val_q;
  logic write_enable_q;
  logic [7:0] imm8_q;
  logic [15:0] imm16_q;

  // verilog_format: on

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

              decode_read_sel(cw.src_sel, regs_q,  // full register file
                              imm8_q, imm16_q,  // immediates
                              selected_val_d,  // out: value
                              mem_addr_d,  // out: address (if memory indirect)
                              mem_read_req_d);

              mem_addr_q <= mem_addr_d;

              if (mem_read_req) begin
                mmu_bus_op <= BUS_READ;
                ex_state   <= EX_WAIT_READ;
              end else begin
                sel_val_q <= selected_val_d;
                ex_state  <= EX_OP;
              end
            end

            // ADD ANOTHER STATE CALLED WAIT TO READ

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
              ex_state <= EX_WRITE_DST;
            end

            EX_WRITE_DST: begin
              // Address we write to
              logic [15:0] mem_addr_d;

              // Data we write
              logic [7:0] mem_write_data_d;

              // Memory write request flag (do we need to write to MMU)
              logic mem_write_req_d;

              decode_write_sel(write_enable_q, cw.dst_sel, new_val_q, regs_q,  // input regs
                               imm8_q, imm16_q, regs_next,  // out: updated regs
                               mem_addr_d, mem_data_d, mem_write_req_d);

              if (mem_write_req) begin
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
                ex_state <= EX_DONE;
                state <= FETCH;
              end
            end
          endcase
        end
      endcase
    end
  end

endmodule
