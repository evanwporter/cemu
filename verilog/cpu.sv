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

  // CPU Registers
  logic [7:0] reg_a, reg_f;
  logic [7:0] reg_b, reg_c;
  logic [7:0] reg_d, reg_e;
  logic [7:0] reg_h, reg_l;
  logic [15:0] reg_sp;  // Stack Pointer
  logic [15:0] reg_pc;  // Program Counter

  // Derived 16-bit pairs
  wire [15:0] reg_af = {reg_a, reg_f};
  wire [15:0] reg_bc = {reg_b, reg_c};
  wire [15:0] reg_de = {reg_d, reg_e};
  wire [15:0] reg_hl = {reg_h, reg_l};

  state_t state;
  fetch_state_t fetch_state;
  execute_state_t ex_state;

  // Temporary data
  logic [7:0] opcode;

  control_word_t control_rom[0:255];

  // current control word
  control_word_t cw;

  // Temporaries that must persist across ex states
  logic [15:0] sel_val_q;
  logic [15:0] mem_addr_q;
  logic [7:0]  mmu_read_latch;
  logic [15:0] new_val_q;
  logic        write_enable_q;
  logic [7:0]  imm8_q;
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
                opcode <= mmu_read_data;
                mmu_bus_op <= BUS_IDLE;
                fetch_state <= FETCH_REQUEST;
                state <= DECODE;
              end
            end
          endcase
        end

        DECODE: begin
          cw <= control_rom[opcode];
          reg_pc <= reg_pc + 1;
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

              decode_read_sel(cw.src_sel,  //
                              reg_a, reg_b, reg_c, reg_d, reg_e, reg_h, reg_l, reg_sp, reg_pc,
                              immediate_data, immediate_data16,  //
                              selected_val_d, mem_addr_d, mem_read_req);

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
              logic [ 7:0] mem_wdata_d;

              // Memory write request flag (do we need to write to MMU)
              logic        mem_write_req_d;

              decode_write_sel(clk, write_enable, cw.dst_sel, new_val, reg_a, reg_b, reg_c, reg_d,
                               reg_e, reg_h, reg_l, reg_sp, reg_pc, immediate_data,
                               immediate_data16, addr, data_out, mem_write_req);

              if (mem_write_req) begin
                mmu_bus_op <= BUS_WRITE;
                ex_state   <= EX_WAIT_WRITE;
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
