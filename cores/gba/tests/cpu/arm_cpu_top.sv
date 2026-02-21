`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

`define LOG_LEVEL_WARN 

// `include "ARM7/CPU.sv"

`include "MockMMU.sv"

module arm_cpu_top (
    input logic clk,
    input logic reset
);

  GBA_Bus_if bus ();

  ARM7TMDI cpu_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (bus)
  );

  MockMMU mmu_inst (
      .clk(clk),
      .reset(reset),
      .cpu_bus(bus)
  );

endmodule

`endif  // GAMEBOY_SV
