`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

`define LOG_LEVEL_WARN 

`include "cpu/CPU.sv"
`include "cpu/RAM.sv"

`include "MockMMU.sv"

// `include "svlogger.sv"

module cpu_top (
    input logic clk,
    input logic reset
);

  Bus_if cpu_bus ();
  Interrupt_if IF_bus ();
  Bus_if interrupt_bus ();

  CPU cpu_inst (
      .clk(clk),
      .reset(reset),
      .bus(cpu_bus),
      .interrupt_bus(interrupt_bus),
      .IF_bus(IF_bus)
  );
  MockMMU mmu_inst (
      .clk(clk),
      .reset(reset),
      .cpu_bus(cpu_bus)
  );

endmodule

`endif  // GAMEBOY_SV
