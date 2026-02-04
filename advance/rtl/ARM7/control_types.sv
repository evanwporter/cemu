// Control model for ARM7 CPU
//  Each shared bus selects exactly one source per cycle.
//  Buses broadcast their value to all connected modules.
//  Each module independently decides whether to accept or ignore the bus
//   based on its control signals.

package control_types_pkg;

  typedef enum logic [1:0] {
    ADDR_SRC_NONE,

    /// Places the PC onto the address bus
    ADDR_SRC_PC,

    /// Places the ALU output onto the address bus
    ADDR_SRC_ALU,

    /// Increments the current address on the address bus
    ADDR_SRC_INCR
  } address_source_t;

  typedef enum logic [1:0] {
    /// No shift, output zero
    SHIFT_SRC_NONE,

    /// Shift by immediate value
    SHIFT_SRC_IMM,

    /// Shift by register value
    SHIFT_SRC_REG
  } shift_source_t;

  typedef enum logic [1:0] {
    B_BUS_SRC_NONE,

    /// Read immediate from IR
    B_BUS_SRC_IMM,

    /// Read data from memory
    B_BUS_SRC_READ_DATA,

    /// Read data from register Rm
    B_BUS_SRC_REG
  } B_bus_source_t;

  typedef struct packed {

    // ======================================================
    // Register Bank
    // ======================================================

    /// Whether to update the PC with the value from the incrementer
    logic incrementer_writeback;

    /// Write back to register Rd from ALU output
    logic alu_writeback;

    // ======================================================
    // Shift Bus
    // ======================================================

    /// The shift source selection.
    /// Can be the immediate value or a register value, or none 
    /// in which case the output is zero.
    shift_source_t shift_source;

    // ======================================================
    // B Bus
    // ======================================================

    B_bus_source_t B_bus_source;

    // ======================================================
    // Address Module
    // ======================================================

    /// Used to specify the source for the address bus
    address_source_t addr_bus_src;

    // ======================================================
    // Memory Module
    // ======================================================

    /// Whether to accept the B_bus as data to write to memory
    logic memory_write_en;


  } control_t;

endpackage : control_types_pkg
