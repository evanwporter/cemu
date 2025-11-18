`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

`include "cpu/CPU.sv"
`include "cpu/RAM.sv"

`include "MockMMU.sv"
`include "mmu/interface.sv"

`define LOG_LEVEL_INFO 

// `include "svlogger.sv"

module cpu_top (
    input logic clk,
    input logic reset
);

  Bus_if cpu_bus ();

  CPU cpu_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (cpu_bus)
  );

  MockMMU mmu_inst (
      .clk(clk),
      .reset(reset),
      .cpu_bus(cpu_bus)
  );

endmodule

`endif  // GAMEBOY_SV
