`ifndef MMU_SV
`define MMU_SV 

import types_pkg::*;

module MockMMU (
    input logic clk,
    input logic reset,

    Bus_if.Slave_side cpu_bus
);

  typedef struct {
    logic [1:0]  kind;  // 0=instr read, 1=data read, 2=write
    logic [1:0]  size;  // 1,2,4 encoded
    logic [31:0] addr;
    logic [31:0] data;
  } transaction_t;

  (* maybe_unused *)
  word_t base_addr, opcode  /* verilator public_flat_rw */;

  (* maybe_unused *)
  transaction_t expected[0:31]  /* verilator public_flat_rw */;

  (* maybe_unused *)
  integer expected_count  /* verilator public_flat_rw */;

  integer txn_index  /* verilator public_flat_rw */;

  always_comb begin
    cpu_bus.rdata = 32'd0;

    if (cpu_bus.read_en) begin
      transaction_t t = expected[txn_index];

      if (t.kind == 2'd0) begin
        // Instruction read
        if (cpu_bus.addr == base_addr) cpu_bus.rdata = opcode;
        else cpu_bus.rdata = cpu_bus.addr;
      end else begin
        // Data read
        cpu_bus.rdata = t.data;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (reset) begin
      txn_index <= 0;
    end else if (cpu_bus.read_en || cpu_bus.write_en) begin
      transaction_t t = expected[txn_index];

      $display("MMU: Using tx data=%0d addr=%0d expected_kind=%0d", t.data, t.addr, t.kind);


      if (cpu_bus.write_en) begin
        $display("MMU: Received write transaction: addr=0x%08x, data=0x%08x", cpu_bus.addr,
                 cpu_bus.wdata);
        $fflush();
      end

      if (cpu_bus.read_en) begin
        $display("MMU: Received read transaction: addr=0x%0d, data=0x%0d", cpu_bus.addr,
                 cpu_bus.rdata);
        $fflush();
      end

      $display("MMU: Completed transaction %0d/%0d", txn_index + 1, expected_count);
      $fflush();
      txn_index <= txn_index + 1;
    end
  end
endmodule

`endif  // MMU_SV
