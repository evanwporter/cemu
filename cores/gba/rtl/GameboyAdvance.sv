`ifndef GAMEBOY_ADVANCE_SV
`define GAMEBOY_ADVANCE_SV 

module GameboyAdvance (
    input logic clk,
    input logic reset
);

  GBA_Bus_if cpu_bus ();

  ARM7TMDI cpu_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (cpu_bus)
  );

endmodule : GameboyAdvance

`endif  // GAMEBOY_ADVANCE_SV
