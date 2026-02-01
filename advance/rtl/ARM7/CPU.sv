import cpu_types_pkg::*;

module CPU (
    input logic clk,
    input logic reset,

    Bus_if.Master_side bus
);

  word_t IR;

  cpu_regs_t regs;

  Decoder_if decoder_bus (.IR(IR));

  Decoder decoder_inst (
      .clk  (clk),
      .reset(reset),
      .bus  (decoder_bus)
  );

  // assign condition = IR[31:28];

endmodule : CPU
