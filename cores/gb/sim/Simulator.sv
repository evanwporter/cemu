import gb_mmu_addresses_pkg::*;

module Simulator (
    input logic clk,
    input logic reset
);

  GB_Bus_if ram_bus ();
  GB_Bus_if hram_bus ();

  Memory #(
      .START_ADDR(HRAM_start),
      .END_ADDR  (HRAM_end),
      .SIZE      (HRAM_len)
  ) hram_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (hram_bus)
  );

  Memory #(
      .START_ADDR(WRAM_start),
      .END_ADDR  (WRAM_end),
      .SIZE      (WRAM_len)
  ) wram_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (ram_bus)
  );

  Gameboy gb (
      .clk  (clk),
      .reset(reset)
  );

endmodule : Simulator
