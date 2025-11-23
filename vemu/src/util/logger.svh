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

integer __log_fd = 0;

`define __SVLOG_PRINT(level, msg) \
  if (__log_fd == 32'd0) begin \
    $display("[%s] [%0t] %s", level, $time, $sformatf msg); \
  end else begin \
    $fdisplay(__log_fd, "[%s] [%0t] %s", level, $time, $sformatf msg); \
  end

`define LOG_FATAL(msg) \
  if (__log_fd != 32'd0) \
    $fdisplay(__log_fd, "[FATAL] [%0t] %s", $time, $sformatf msg); \
  $fatal("[FATAL] [%0t] %s", $time, $sformatf msg);

`define __SVLOG_ERROR(msg) \
  if (__log_fd != 32'd0) \
    $fdisplay(__log_fd, "[ERROR] [%0t] %s", $time, $sformatf msg); \
  $error("[ERROR] [%0t] %s", $time, $sformatf msg);

`define __SVLOG_WARN(msg) \
  if (__log_fd == 32'd0) begin \
    $display("[WARN] [%0t] %s", $time, $sformatf msg); \
  end else begin \
    $fdisplay(__log_fd, "[WARN] [%0t] %s", $time, $sformatf msg); \
  end

`define __SVLOG_INFO(msg) \
  if (__log_fd == 32'd0) begin \
    $display("[INFO] [%0t] %s", $time, $sformatf msg); \
  end else begin \
    $fdisplay(__log_fd, "[INFO] [%0t] %s", $time, $sformatf msg); \
  end

`define __SVLOG_TRACE(msg) \
  if (__log_fd == 32'd0) begin \
    $display("[TRACE] [%0t] %s", $time, $sformatf msg); \
  end else begin \
    $fdisplay(__log_fd, "[TRACE] [%0t] %s", $time, $sformatf msg); \
  end

`ifdef LOG_LEVEL_NONE

`define LOG_TRACE(msg) 
`define LOG_INFO(msg) 
`define LOG_WARN(msg) 
`define LOG_ERROR(msg) 

`elsif LOG_LEVEL_ERROR

`define LOG_TRACE(msg) 
`define LOG_INFO(msg) 
`define LOG_WARN(msg) 
`define LOG_ERROR(msg) `__SVLOG_ERROR(msg)

`elsif LOG_LEVEL_WARN

`define LOG_TRACE(msg) 
`define LOG_INFO(msg) 
`define LOG_WARN(msg) `__SVLOG_WARN(msg)
`define LOG_ERROR(msg) `__SVLOG_ERROR(msg)

`elsif LOG_LEVEL_INFO

`define LOG_TRACE(msg) 
`define LOG_INFO(msg) `__SVLOG_INFO(msg)
`define LOG_WARN(msg) `__SVLOG_WARN(msg)
`define LOG_ERROR(msg) `__SVLOG_ERROR(msg)

`elsif LOG_LEVEL_TRACE

`define LOG_TRACE(msg) `__SVLOG_TRACE(msg)
`define LOG_INFO(msg) `__SVLOG_INFO(msg)
`define LOG_WARN(msg) `__SVLOG_WARN(msg)
`define LOG_ERROR(msg) `__SVLOG_ERROR(msg)

`endif

`endif  // UTIL_LOGGER_SV
