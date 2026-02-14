import types_pkg::*;
import cpu_types_pkg::*;

package cpu_decoder_types_pkg;

  typedef enum logic {
    ARM_LDR_STR_WORD,
    ARM_LDR_STR_BYTE
  } bit_length_flag_t;

  /// TODO verify order
  typedef enum logic {
    /// Immediate Offset
    /// Offset it by an immediate value encoded in the instruction
    ARM_LDR_STR_IMMEDIATE,

    /// Shifted Register Offset
    /// Offset it by a register value (Rm)
    ARM_LDR_STR_SHIFTED
  } mem_offset_flag_t;

  typedef enum logic {
    ARM_LDR_STR_POST_OFFSET,
    ARM_LDR_STR_PRE_OFFSET
  } pre_post_offset_flag_t;

  typedef union packed {

    // ======================================================
    // Data Processing
    // ======================================================

    /// Data Processing Immediate (ARM_INSTR_DATAPROC_IMM)
    struct packed {
      logic [6:0] _pad;

      // Bits 24-21
      logic [3:0] opcode;

      // Bit 20
      logic set_flags;

      // Bits 11-8
      logic [3:0] rotate;

      // Bits 7-0
      logic [7:0] imm8;
    } data_proc_imm;

    /// Data Processing Register Immediate Shift (ARM_INSTR_DATAPROC_REG_IMM)
    struct packed {
      logic [11:0] _pad;

      // Bits 24-21
      logic [3:0] opcode;

      // Bit 20
      logic set_flags;

      // Bits 11-7
      logic [4:0] shift_amount;

      // Bits 6-5
      shift_type_t shift_type;
    } data_proc_reg_imm;

    /// Data Processing Register Register Shift (ARM_INSTR_DATAPROC_REG_REG)
    struct packed {
      logic [16:0] _pad;

      // Bits 24-21
      logic [3:0] opcode;

      // Bit 20
      logic set_flags;

      // Bits 11-8
      // The rotate amount is stored wholly within Rs
      // logic [3:0] rotate;

      // Bits 6-5
      shift_type_t shift_type;
    } data_proc_reg_reg;


    // ======================================================
    // Single Data Transfer (Word / Byte / Halfword)
    // ======================================================

    /// ARM_INSTR_LOAD / ARM_INSTR_STORE
    struct packed {
      logic [6:0] _pad;

      // Bit 25
      mem_offset_flag_t I;

      // Bit 24
      pre_post_offset_flag_t P;

      // Bit 23
      logic U;

      // Byte / Word bit (0=transfer 32bit/word, 1=transfer 8bit/byte)
      // Bit 22
      bit_length_flag_t B;

      // Bit 21
      logic wt;

      // Rn
      // Rd

      union packed {

        struct packed {
          logic [4:0] _pad;

          // Bits 11-7
          logic [4:0] shift_amount;

          // Bits 6-5
          shift_type_t shift_type;
        } shifted;

        logic [11:0] imm12;
      } offset;

      // Uses Rm as offset register
    } ls;

    // ======================================================
    // Block Data Transfer
    // ======================================================

    /// ARM_INSTR_LDM / ARM_INSTR_STM
    // https://mgba-emu.github.io/gbatek/#opcode-format-5
    struct packed {
      logic [3:0] _pad;

      // Bit 24
      pre_post_offset_flag_t P;

      // Bit 23
      logic U;

      // PSR & force user bit (0=No, 1=load PSR or force user mode)
      // Bit 22
      logic S;

      // Bit 21
      // Writeback bit (1) writeback; (0) no writeback
      logic W;

      // Bits 15-0
      logic [15:0] reg_list;
    } block;


    // ======================================================
    // Branch
    // ======================================================

    /// ARM_INSTR_BRANCH / ARM_INSTR_BRANCH_LINK
    struct packed {
      // Bits 23-0
      logic [23:0] imm24;
    } branch;


    // ======================================================
    // PSR Transfer
    // ======================================================

    /// MSR (immediate form)
    struct packed {
      logic [11:0] _pad;

      // Bits 11-8
      logic [3:0] rotate;

      // Bits 7-0
      logic [7:0] imm8;
    } psr_imm;


    // ======================================================
    // Software Interrupt
    // ======================================================

    /// ARM_INSTR_SWI
    struct packed {
      // Bits 23-0
      logic [23:0] comment;
    } swi;
  } extra_t;


  typedef struct {
    arm_instr_t instr_type;

    // Bits 31-28
    /// Whether the condition code check passed and the 
    /// instruction should be executed. This is computed in 
    /// the Decoder and used in the Control Unit to determine 
    /// whether to execute the instruction or treat it as a NOP.
    logic condition_pass;

    // Bits 15-12
    logic [3:0] Rd;

    // Bits 19-16
    logic [3:0] Rn;

    // Bits 3-0
    logic [3:0] Rm;

    // Bits 11-8
    logic [3:0] Rs;

    /// TODO Debug only
    word_t IR;

    extra_t immediate;
  } decoded_word_t;

endpackage : cpu_decoder_types_pkg
