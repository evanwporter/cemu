`ifndef UTIL_LOGGER_SV
`define UTIL_LOGGER_SV 

`ifndef SVLOG_ENABLE
`define SVLOG_ENABLE 1   // override via +define+SVLOG_ENABLE=0
`endif

`define SVLOG_PREFIX(level) \
    {"[", level, "] [", $sformatf("%0t", $time), "] "}

`define SVLOG_FMT(msg) $sformatf msg

`ifdef SVLOG_ENABLE

`define LOG_INFO(msg) \
        $display({`SVLOG_PREFIX("INFO"), `SVLOG_FMT(msg)})

`define LOG_WARN(msg) \
        $display({`SVLOG_PREFIX("WARN"), `SVLOG_FMT(msg)})

`define LOG_ERROR(msg) \
        $error({`SVLOG_PREFIX("ERROR"), `SVLOG_FMT(msg)})

`define LOG_FATAL(msg) \
        $fatal(1, {`SVLOG_PREFIX("FATAL"), `SVLOG_FMT(msg)})

`else

// Logging disabled – macros expand to nothing
`define LOG_INFO(msg) 
`define LOG_WARN(msg) 
`define LOG_ERROR(msg) 
`define LOG_FATAL(msg) 

`endif

`define DISPLAY_CONTROL_WORD(CW, i) \
  begin \
    `LOG_INFO(("--------------------------------------------------")); \
    `LOG_INFO(("CONTROL WORD DEBUG @ %0t", $time)); \
    `LOG_INFO(("  num_cycles = %0d", (CW).num_cycles)); \
    `LOG_INFO(("  M-Cycle %0d:", i)); \
    `LOG_INFO(("    addr_src     = %s", (CW).cycles[i].addr_src.name())); \
    `LOG_INFO(("    data_bus_src = %s", (CW).cycles[i].data_bus_src.name())); \
    `LOG_INFO(("    data_bus_op  = %s", (CW).cycles[i].data_bus_op.name())); \
    `LOG_INFO(("    idu_op       = %s", (CW).cycles[i].idu_op.name())); \
    `LOG_INFO(("    alu_op       = %s", (CW).cycles[i].alu_op.name())); \
    `LOG_INFO(("    alu_dst      = %s", (CW).cycles[i].alu_dst.name())); \
    `LOG_INFO(("    alu_src      = %s", (CW).cycles[i].alu_src.name())); \
    `LOG_INFO(("    misc_op      = %s", (CW).cycles[i].misc_op.name())); \
    `LOG_INFO(("    misc_op_dst  = %s", (CW).cycles[i].misc_op_dst.name())); \
    `LOG_INFO(("    cond         = %s", (CW).cycles[i].cond.name())); \
    `LOG_INFO(("--------------------------------------------------")); \
  end

`endif  // UTIL_LOGGER_SV
