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

  gameboy_types_pkg::t_phase_t t_phase;

  Bus_if cpu_bus ();
  Interrupt_if IF_bus ();
  Bus_if interrupt_bus ();

  CPU cpu_inst (
      .clk(clk),
      .reset(reset),
      .t_phase(t_phase),
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
