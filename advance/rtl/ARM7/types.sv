import types_pkg::*;

package cpu_types_pkg;

  /**
    From: https://mgba-emu.github.io/gbatek/#overview-11

    System/User FIQ       Supervisor Abort     IRQ       Undefined
    --------------------------------------------------------------
    R0          R0        R0         R0        R0        R0
    R1          R1        R1         R1        R1        R1
    R2          R2        R2         R2        R2        R2
    R3          R3        R3         R3        R3        R3
    R4          R4        R4         R4        R4        R4
    R5          R5        R5         R5        R5        R5
    R6          R6        R6         R6        R6        R6
    R7          R7        R7         R7        R7        R7
    --------------------------------------------------------------
    R8          R8_fiq    R8         R8        R8        R8
    R9          R9_fiq    R9         R9        R9        R9
    R10         R10_fiq   R10        R10       R10       R10
    R11         R11_fiq   R11        R11       R11       R11
    R12         R12_fiq   R12        R12       R12       R12
    R13 (SP)    R13_fiq   R13_svc    R13_abt   R13_irq   R13_und
    R14 (LR)    R14_fiq   R14_svc    R14_abt   R14_irq   R14_und
    R15 (PC)    R15       R15        R15       R15       R15
    --------------------------------------------------------------
    CPSR        CPSR      CPSR       CPSR      CPSR      CPSR
    --          SPSR_fiq  SPSR_svc   SPSR_abt  SPSR_irq  SPSR_und
    --------------------------------------------------------------
  */
  // typedef struct {
  //   word_t R0;
  //   word_t R1;
  //   word_t R2;
  //   word_t R3;
  //   word_t R4;
  //   word_t R5;
  //   word_t R6;
  //   word_t R7;
  //   word_t R8;
  //   word_t R9;
  //   word_t R10;
  //   word_t R11;
  //   word_t R12;

  //   /// Program Counter (PC)
  //   word_t R13;

  //   /// Link Register (LR)
  //   word_t R14;

  //   /// Stack Pointer (SP)
  //   word_t R15;

  //   word_t CPSR;

  // } cpu_regs_t;

  typedef enum logic [1:0] {
    SHIFT_LSL = 2'b00,
    SHIFT_LSR = 2'b01,
    SHIFT_ASR = 2'b10,
    SHIFT_ROR = 2'b11
  } shift_type_t;

  /// Conditional codes
  /// https://mgba-emu.github.io/gbatek/#arm-condition-field-cond
  typedef enum logic [3:0] {
    /// Equal; Z = 1
    COND_EQ = 4'b0000,

    /// Not equal; Z = 0
    COND_NE = 4'b0001,

    /// Carry set; C = 1
    COND_CS_HS = 4'b0010,

    /// Carry cleared; C = 0
    COND_CC_LO = 4'b0011,

    /// Minus/negative; N = 1
    COND_MI = 4'b0100,

    /// Plus/positive or zero; N = 0
    COND_PL = 4'b0101,

    /// Overflow; V = 1
    COND_VS = 4'b0110,

    /// No overflow; V = 0
    COND_VC = 4'b0111,

    /// Unsigned higher; C = 1 and Z = 0
    COND_HI = 4'b1000,

    /// Unsigned lower or same; C = 0 or Z = 1
    COND_LS = 4'b1001,

    /// Signed greater or equal; N = V
    COND_GE = 4'b1010,

    /// Signed less than; N != V
    COND_LT = 4'b1011,

    /// Signed greater than; Z = 0 and N = V
    COND_GT = 4'b1100,

    /// Signed less or equal; Z = 1 or N != V
    COND_LE = 4'b1101,

    /// Always; -
    COND_AL = 4'b1110,

    /// Never; -
    COND_NV = 4'b1111
  } condition_t;


  typedef enum logic [4:0] {

    // ======================================================
    // Invalid / System
    // ======================================================

    /// Undefined / illegal instruction
    ARM_INSTR_UNDEF,

    /// Software interrupt (SWI)
    ARM_INSTR_SWI,

    /// Exception entry (prefetch abort, data abort, etc.)
    ARM_INSTR_EXCEPTION,

    // ======================================================
    // Branch
    // ======================================================

    /// Branch (B)
    ARM_INSTR_BRANCH,

    /// Branch with link (BL)
    ARM_INSTR_BRANCH_LINK,

    /// Branch and exchange (BX)
    ARM_INSTR_BRANCH_EX,

    // ======================================================
    // Data Processing
    // ======================================================

    /// Operand2 = immediate (rotate + imm8)
    ARM_INSTR_DATAPROC_IMM,

    /// Operand2 = register shifted by immediate
    ARM_INSTR_DATAPROC_REG_IMM,

    /// Operand2 = register shifted by register
    ARM_INSTR_DATAPROC_REG_REG,

    // ======================================================
    // Multiply
    // ======================================================

    /// MUL / MLA
    ARM_INSTR_MULTIPLY,

    /// UMULL / UMLAL / SMULL / SMLAL
    ARM_INSTR_MULTIPLY_LONG,

    // ======================================================
    // Single Data Transfer
    // ======================================================

    /// LDR
    ARM_INSTR_LOAD,

    /// STR
    ARM_INSTR_STORE,

    /// LDR / STR (word, immediate offset)
    ARM_INSTR_LDR_STR_IMM,

    /// LDR / STR (word, register offset)
    ARM_INSTR_LDR_STR_REG,

    /// LDRB / STRB
    ARM_INSTR_LDR_STR_BYTE,

    /// LDRH / STRH / LDRSB / LDRSH (immediate)
    ARM_INSTR_LDR_STR_HALF_IMM,

    /// LDRH / STRH / LDRSB / LDRSH (register)
    ARM_INSTR_LDR_STR_HALF_REG,

    /// SWP / SWPB
    ARM_INSTR_SWAP,

    // ======================================================
    // Block Data Transfer
    // ======================================================

    /// LDM / STM
    ARM_INSTR_LDM_STM,

    // ======================================================
    // PSR Transfer
    // ======================================================

    /// MRS (read CPSR/SPSR)
    ARM_INSTR_MRS,

    /// MSR (write CPSR/SPSR)
    ARM_INSTR_MSR

  } arm_instr_t;

  typedef enum logic {
    ARM_LDR_STR_WORD,
    ARM_LDR_STR_BYTE
  } bit_length_flag_t;

  /// TODO verify order
  typedef enum logic {
    /// Shifted Register Offset
    /// Offset it by a register value (Rm)
    ARM_LDR_STR_SHIFTED,

    /// Immediate Offset
    /// Offset it by an immediate value encoded in the instruction
    ARM_LDR_STR_IMMEDIATE
  } mem_offset_flag_t;

  typedef enum logic {
    ARM_LDR_STR_PRE_OFFSET,
    ARM_LDR_STR_POST_OFFSET
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

    // /// ARM_INSTR_LOAD_REG / ARM_INSTR_STORE_REG
    // /// Immediate offset
    // struct packed {
    //   logic [11:0] _pad;

    //   // Bits 11-0
    //   logic [11:0] imm12;
    // } ls_imm;

    // /// ARM_INSTR_LOAD_IMM / ARM_INSTR_STORE_IMM
    // /// Register offset with shift
    // struct packed {
    //   logic [16:0] _pad;

    //   // Bits 11-7
    //   logic [4:0] shift_imm;

    //   // Bits 6-5
    //   shift_type_t shift_type;
    // } ls_reg;

    /// LDRH / STRH / LDRSB / LDRSH (immediate form)
    struct packed {
      logic [15:0] _pad;

      // Bits 11-8
      logic [3:0] imm_hi;

      // Bits 3-0
      logic [3:0] imm_lo;
    } ls_half_imm;


    // ======================================================
    // Block Data Transfer
    // ======================================================

    /// ARM_INSTR_LDM / ARM_INSTR_STM
    struct packed {
      logic [7:0] _pad;

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


  typedef struct packed {
    arm_instr_t instr_type;

    // Bits 31-28
    condition_t condition;

    // Bits 15-12
    logic [3:0] Rd;

    // Bits 19-16
    logic [3:0] Rn;

    // Bits 3-0
    logic [3:0] Rm;

    // Bits 11-8
    logic [3:0] Rs;

    extra_t immediate;
  } decoded_word_t;


  typedef struct packed {
    /// Negative
    logic n;

    /// Zero
    logic z;

    /// Carry
    logic c;

    /// Overflow
    logic v;
  } flags_t;

  /// TODO: verify this is in order
  typedef enum logic [3:0] {
    ALU_OP_AND,
    ALU_OP_XOR,
    ALU_OP_SUB,
    ALU_OP_SUB_REVERSED,
    ALU_OP_ADD,
    ALU_OP_ADC,
    ALU_OP_SBC,
    ALU_OP_SBC_REVERSED,
    ALU_OP_TEST,
    ALU_OP_TEST_EXCLUSIVE,
    ALU_OP_CMP,
    ALU_OP_CMP_NEG,
    ALU_OP_OR,
    ALU_OP_MOV,
    ALU_OP_BIT_CLEAR,
    ALU_OP_NOT
  } alu_op_t;

endpackage : cpu_types_pkg
