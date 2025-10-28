`ifndef MMU_SV
`define MMU_SV 

`include "types.sv"

module MMU (
    input logic clk,
    input logic reset,

    // request
    input bus_op_t req_op,
    input bus_size_t req_size,
    input logic [15:0] req_addr,
    input logic [15:0] req_write_data,

    // response
    output logic resp_done,
    output logic [15:0] resp_read_data
);

  // TODO I need to add a port for PPU access

  //  64 KB block RAM 
  logic [7:0] mem[0:16'hFFFF];

  initial begin
    foreach (mem[i]) mem[i] = 8'h00;
  end

  typedef enum logic [2:0] {
    S_IDLE,
    S_READ_LOW,
    S_READ_HIGH,
    S_WRITE_LOW,
    S_WRITE_HIGH
  } mmu_state_t;

  mmu_state_t state;
  logic [15:0] addr_q;
  logic [15:0] wdata_q;
  logic [7:0] rdata_q;
  bus_op_t op_q;
  bus_size_t size_q;

  always_ff @(posedge clk) begin
    if (reset) begin
      state          <= S_IDLE;
      resp_done      <= 1'b0;
      resp_read_data <= '0;
      addr_q         <= '0;
      wdata_q        <= '0;
      op_q           <= BUS_OP_IDLE;
      size_q         <= BUS_SIZE_BYTE;
    end else begin
      resp_done <= 1'b0;

      unique case (state)
        S_IDLE: begin
          if (req_op != BUS_OP_IDLE) begin
            addr_q  <= req_addr;
            wdata_q <= req_write_data;
            op_q    <= req_op;
            size_q  <= req_size;

            unique case (req_op)
              BUS_OP_READ:  state <= S_READ_LOW;
              BUS_OP_WRITE: state <= S_WRITE_LOW;
              default:      state <= S_IDLE;
            endcase
          end
        end

        S_READ_LOW: begin
          rdata_q <= mem[addr_q];
          if (size_q == BUS_SIZE_WORD) begin
            state <= S_READ_HIGH;
          end else begin
            // this also clears out whatever is in the high byte of the read data
            resp_read_data <= {8'h00, mem[addr_q]};
            resp_done      <= 1'b1;
            state          <= S_IDLE;
          end
        end

        S_READ_HIGH: begin
          resp_read_data <= {mem[addr_q+1], rdata_q};
          resp_done <= 1'b1;
          state <= S_IDLE;
        end

        S_WRITE_LOW: begin
          mem[addr_q] <= wdata_q[7:0];
          if (size_q == BUS_SIZE_WORD) begin
            state <= S_WRITE_HIGH;
          end else begin
            resp_done <= 1'b1;
            state     <= S_IDLE;
          end
        end

        S_WRITE_HIGH: begin
          mem[addr_q+1] <= wdata_q[15:8];
          resp_done     <= 1'b1;
          state         <= S_IDLE;
        end
      endcase
    end
  end

endmodule

`endif  // MMU_SV
