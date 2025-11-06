`ifndef UTIL_LOGGER_SV
`define UTIL_LOGGER_SV 

`define DISPLAY_CONTROL_WORD(CW) \
  begin \
    $display("--------------------------------------------------"); \
    $display("CONTROL WORD DEBUG @ %0t", $time); \
    $display("  num_cycles = %0d", (CW).num_cycles); \
    for (int i = 0; i < (CW).num_cycles; i++) begin \
      automatic cycle_t c = (CW).cycles[i]; \
      $display("  M-Cycle %0d:", i); \
      $display("    addr_src     = %s", (CW).cycles[i].addr_src.name()); \
      $display("    data_bus_src = %s", c.data_bus_src.name()); \
      $display("    data_bus_op  = %s", c.data_bus_op.name()); \
      $display("    idu_op       = %s", c.idu_op.name()); \
      $display("    alu_op       = %s", c.alu_op.name()); \
      $display("    alu_dst      = %s", c.alu_dst.name()); \
      $display("    alu_src      = %s", c.alu_src.name()); \
      $display("    misc_op      = %s", c.misc_op.name()); \
      $display("    cond         = %s", c.cond.name()); \
    end \
    $display("--------------------------------------------------"); \
  end

`endif  // DISPLAY_CONTROL_WORD_SV
