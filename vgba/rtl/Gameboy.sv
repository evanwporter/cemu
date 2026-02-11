`ifndef GAMEBOY_SV
`define GAMEBOY_SV 

module Gameboy (
    input logic clk,
    input logic reset
);

  Bus_if cpu_bus ();

  CPU cpu_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (cpu_bus)
  );

endmodule : Gameboy

`endif  // GAMEBOY_SV
