import control_types_pkg::*;

package control_util_pkg;

  // TODO: Think about setting incrementer_writeback here as well, 
  // since every time we fetch an instruction, we want to increment 
  // the PC for the next instruction.
  function automatic control_t fetch_next_instr();
    control_t s = '0;

    s.memory_read_en  = 1'b1;
    s.memory_latch_IR = 1'b1;

    return s;
  endfunction : fetch_next_instr

endpackage : control_util_pkg
