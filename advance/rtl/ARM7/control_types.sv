// Control model for ARM7 CPU
//  Each shared bus selects exactly one source per cycle.
//  Buses broadcast their value to all connected modules.
//  Each module independently decides whether to accept or ignore the bus
//   based on its control signals.

import types_pkg::*;
import cpu_types_pkg::*;

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

  typedef enum logic [2:0] {
    B_BUS_SRC_NONE,

    /// Read immediate from IR
    /// If set, then `B_bus_imm` must be assigned.
    B_BUS_SRC_IMM,

    /// Read data from memory
    B_BUS_SRC_READ_DATA,

    /// Read data from register Rm
    B_BUS_SRC_REG_RM,

    /// Read data from register Rs
    B_BUS_SRC_REG_RS,

    /// Read data from register Rd
    B_BUS_SRC_REG_RD

  } B_bus_source_t;

  typedef enum logic [3:0] {
    ALU_WB_NONE,
    ALU_WB_REG_RD,
    ALU_WB_REG_RS,
    ALU_WB_REG_RN,
    ALU_WB_REG_14
  } alu_writeback_source_t;

  typedef struct packed {

    // ======================================================
    // Register Bank
    // ======================================================

    /// Whether to update the PC with the incremented address
    logic incrementer_writeback;

    /// Write back to register Rd from ALU output
    alu_writeback_source_t alu_writeback;

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

    /// Immediate value to place on the B bus, if selected in `B_bus_source`
    logic [11:0] B_bus_imm;

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

    // ======================================================
    // ALU
    // ======================================================

    /// Whether to latch the B_bus value into the ALU for use in the next cycle
    logic ALU_latch_op_b;

    /// Whether to use the latched B_bus value in the ALU for the current cycle
    logic ALU_use_op_b_latch;

    /// Whether to use the B_bus value in the ALU for the current cycle
    /// If true, then regardless of what the B_bus value is, the ALU will use zero as its B operand
    logic ALU_disable_op_b;

    // TODO
    logic set_ALU_flags;
    alu_op_t ALU_op;

    // ======================================================
    // Barrel Shifter
    // ======================================================

    /// Whether the barrel shifter should latch the shift amount from the Rs register
    logic latch_shift_amt;

    /// Lets the barrel shifter know that the shift amount has been latched from 
    /// the Rs register, so it should use that instead of the immediate shift amount
    logic use_shift_latch;

    shift_type_t shift_type;

    logic [4:0] shift_amount;


  } control_t;

endpackage : control_types_pkg
