`ifndef UTIL_LOGGER_SV
`define UTIL_LOGGER_SV 

`define DISPLAY_CONTROL_WORD(CW, i) \
  begin \
    $display("--------------------------------------------------"); \
    $display("CONTROL WORD DEBUG @ %0t", $time); \
    $display("  num_cycles = %0d", (CW).num_cycles); \
    $display("  M-Cycle %0d:", i); \
    $display("    addr_src     = %s", (CW).cycles[i].addr_src.name()); \
    $display("    data_bus_src = %s", (CW).cycles[i].data_bus_src.name()); \
    $display("    data_bus_op  = %s", (CW).cycles[i].data_bus_op.name()); \
    $display("    idu_op       = %s", (CW).cycles[i].idu_op.name()); \
    $display("    alu_op       = %s", (CW).cycles[i].alu_op.name()); \
    $display("    alu_dst      = %s", (CW).cycles[i].alu_dst.name()); \
    $display("    alu_src      = %s", (CW).cycles[i].alu_src.name()); \
    $display("    misc_op      = %s", (CW).cycles[i].misc_op.name()); \
    $display("    misc_op_dst  = %s", (CW).cycles[i].misc_op_dst.name()); \
    $display("    cond         = %s", (CW).cycles[i].cond.name()); \
    $display("--------------------------------------------------"); \
  end

`endif  // UTIL_LOGGER_SV
