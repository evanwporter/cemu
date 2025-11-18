`ifndef UTIL_LOGGER_SV
`define UTIL_LOGGER_SV 

`ifndef SVLOG_NONE
`ifndef SVLOG_ERROR
`ifndef SVLOG_WARN
`ifndef SVLOG_INFO
`define SVLOG_NONE 
`endif
`endif
`endif
`endif

`define __SVLOG_PREFIX(level) \
    {"[", level, "] [", $sformatf("%0t", $time), "] "}

`define __SVLOG_FMT(msg) $sformatf msg

`define LOG_FATAL(msg) \
        $fatal(1, {`__SVLOG_PREFIX("FATAL"), `__SVLOG_FMT(msg)})

`ifdef SVLOG_NONE

`define LOG_INFO(msg) 
`define LOG_WARN(msg) 
`define LOG_ERROR(msg) 

`elsif SVLOG_ERROR

`define LOG_INFO(msg) 
`define LOG_WARN(msg) 
`define LOG_ERROR(msg) $error({`__SVLOG_PREFIX("ERROR"), `__SVLOG_FMT(msg)})

`elsif SVLOG_WARN

`define LOG_INFO(msg) 
`define LOG_WARN(msg) $display({`__SVLOG_PREFIX("WARN"), `__SVLOG_FMT(msg)})
`define LOG_ERROR(msg) $error({`__SVLOG_PREFIX("ERROR"), `__SVLOG_FMT(msg)})

`elsif SVLOG_INFO

`define LOG_INFO(msg) $display({`__SVLOG_PREFIX("INFO"), `__SVLOG_FMT(msg)})
`define LOG_WARN(msg) $display({`__SVLOG_PREFIX("WARN"), `__SVLOG_FMT(msg)})
`define LOG_ERROR(msg) $error({`__SVLOG_PREFIX("ERROR"), `__SVLOG_FMT(msg)})

`endif

`endif  // UTIL_LOGGER_SV
