`ifndef UTIL_LOGGER_SV
`define UTIL_LOGGER_SV 

`ifndef LOG_LEVEL_NONE
`ifndef LOG_LEVEL_ERROR
`ifndef LOG_LEVEL_WARN
`ifndef LOG_LEVEL_INFO
`ifndef LOG_LEVEL_TRACE
`define LOG_LEVEL_NONE 
`endif
`endif
`endif
`endif
`endif

`define __SVLOG_PREFIX(level) \
    {"[", level, "] [", $sformatf("%0t", $time), "] "}

`define __SVLOG_FMT(msg) $sformatf msg

`define LOG_FATAL(msg) \
        $fatal(1, {`__SVLOG_PREFIX("FATAL"), `__SVLOG_FMT(msg)})

`ifdef LOG_LEVEL_NONE

`define LOG_TRACE(msg) 
`define LOG_INFO(msg) 
`define LOG_WARN(msg) 
`define LOG_ERROR(msg) 

`elsif LOG_LEVEL_ERROR

`define LOG_TRACE(msg) 
`define LOG_INFO(msg) 
`define LOG_WARN(msg) 
`define LOG_ERROR(msg) $error({`__SVLOG_PREFIX("ERROR"), `__SVLOG_FMT(msg)})

`elsif LOG_LEVEL_WARN

`define LOG_TRACE(msg) 
`define LOG_INFO(msg) 
`define LOG_WARN(msg) $display({`__SVLOG_PREFIX("WARN"), `__SVLOG_FMT(msg)})
`define LOG_ERROR(msg) $error({`__SVLOG_PREFIX("ERROR"), `__SVLOG_FMT(msg)})

`elsif LOG_LEVEL_INFO

`define LOG_TRACE(msg) 
`define LOG_INFO(msg) $display({`__SVLOG_PREFIX("INFO"), `__SVLOG_FMT(msg)})
`define LOG_WARN(msg) $display({`__SVLOG_PREFIX("WARN"), `__SVLOG_FMT(msg)})
`define LOG_ERROR(msg) $error({`__SVLOG_PREFIX("ERROR"), `__SVLOG_FMT(msg)})

`elsif LOG_LEVEL_TRACE

`define LOG_TRACE(msg) $display({`__SVLOG_PREFIX("TRACE"), `__SVLOG_FMT(msg)})
`define LOG_INFO(msg) $display({`__SVLOG_PREFIX("INFO"), `__SVLOG_FMT(msg)})
`define LOG_WARN(msg) $display({`__SVLOG_PREFIX("WARN"), `__SVLOG_FMT(msg)})
`define LOG_ERROR(msg) $error({`__SVLOG_PREFIX("ERROR"), `__SVLOG_FMT(msg)})

`endif

`endif  // UTIL_LOGGER_SV
