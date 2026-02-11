`ifndef MMU_SV
`define MMU_SV 

import types_pkg::*;

module MockMMU (
    input logic clk,
    input logic reset,

    Bus_if.Slave_side cpu_bus
);

  typedef struct {
    logic [1:0]  kind;  // 0 = instruction read, 1 = data read, 2 = write
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

  function automatic logic signed [5:0] find_match(input logic kind, input logic [31:0] addr);
    for (logic [4:0] i = 0; i < expected_count; i++) begin
      $display("MMU: Checking expected transaction %0d: kind=%0d addr=%0d", i, expected[i].kind,
               expected[i].addr);
      if (expected[i].kind == kind && expected[i].addr == addr) begin
        $display("MMU: Found match for kind=%0d addr=%0d at index %0d", kind, addr, i);
        return i;
      end
    end
    return -1;
  endfunction

  always_comb begin
    cpu_bus.rdata = 32'd0;

    if (cpu_bus.read_en) begin
      if (cpu_bus.addr == base_addr) begin
        cpu_bus.rdata = opcode;
        $display("MMU: Providing opcode %0d for read at base address %0d", opcode, base_addr);
      end else begin
        logic signed [5:0] match;
        transaction_t t;

        if (!cpu_bus.instruction_fetch) begin
          match = find_match(1, cpu_bus.addr);
          if (match == -1) begin
            $display("MMU: No match found for read transaction at addr=%0d", cpu_bus.addr);
            $fflush();
          end else begin
            t = expected[match];
            cpu_bus.rdata = t.data;
            $display("MMU: Providing data=%0d for read transaction at addr=%0d kind=%0d match=%0d",
                     t.data, cpu_bus.addr, t.kind, match);
            $fflush();
          end
        end else if (cpu_bus.addr == base_addr) begin
          cpu_bus.rdata = opcode;
          $display("MMU: Providing opcode %0d for read at base address %0d", opcode, base_addr);
        end else begin
          cpu_bus.rdata = cpu_bus.addr;
          $display("MMU: Providing data=%0d for read transaction at addr=%0d kind=%0d match=%0d",
                   cpu_bus.rdata, cpu_bus.addr, t.kind, match);
          $fflush();
        end
      end
    end
  end

  always_ff @(posedge clk) begin
    if (reset) begin
      txn_index <= 0;
    end else if (cpu_bus.read_en || cpu_bus.write_en) begin
      transaction_t t;
      logic signed [5:0] match;
      match = find_match(cpu_bus.write_en ? 1 : 0, cpu_bus.addr);
      t = expected[match];

      if (match == -1) begin
        $display("MMU: No match found for transaction kind=%0d addr=%0d", cpu_bus.write_en ? 1 : 0,
                 cpu_bus.addr);
        $fflush();
      end else begin
        $display("MMU: Using tx data=%0d addr=%0d expected_kind=%0d", t.data, t.addr, t.kind);

        if (cpu_bus.write_en) begin
          $display("MMU: Received write transaction: addr=%0d, data=%0d", cpu_bus.addr,
                   cpu_bus.wdata);
          $fflush();
        end

        if (cpu_bus.read_en) begin
          $display("MMU: Received read transaction: addr=%0d, data=%0d", cpu_bus.addr,
                   cpu_bus.rdata);
          $fflush();
        end

        $display("MMU: Completed transaction %0d/%0d", txn_index + 1, expected_count);
        $fflush();
        txn_index <= txn_index + 1;
      end
    end
  end
endmodule

`endif  // MMU_SV
