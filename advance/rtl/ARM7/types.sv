package cpu_types_pkg;

  typedef logic [31:0] word_t;

  typedef logic [15:0] half_t;

  typedef logic [7:0] byte_t;

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
  typedef struct {
    word_t R0;
    word_t R1;
    word_t R2;
    word_t R3;
    word_t R4;
    word_t R5;
    word_t R6;
    word_t R7;
    word_t R8;
    word_t R9;
    word_t R10;
    word_t R11;
    word_t R12;

    /// Program Counter (PC)
    word_t R13;

    /// Link Register (LR)
    word_t R14;

    /// Stack Pointer (SP)
    word_t R15;

    word_t CPSR;

  } cpu_regs_t;


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


  typedef enum logic [3:0] {
    /// Undefined / illegal instruction
    ARM_INSTR_UNDEF,

    //// Branch and Exchange (BX, BLX_reg)
    ARM_INSTR_BRANCH_EX,

    /// Block data transfer (LDM, STM)
    ARM_INSTR_BLOCK_DATA_TRANSFER,

    /// Data processing (AND,EOR,ADD,SUB,MOV,CMP,...)
    ARM_INSTR_DATAPROC,

    //// Branch
    ARM_INSTR_BRANCH,

    /// Branch with Link (BL)
    ARM_INSTR_BRANCH_LINK,

    /// MUL, MLA (and long multiplies if implemented)
    ARM_INSTR_MULTIPLY,

    /// Single data transfer (LDR, STR, byte variants)
    ARM_INSTR_LDR_STR,

    /// Block data transfer (LDM, STM)
    ARM_INSTR_LDM_STM,

    /// B, BL
    // ARM_INSTR_BRANCH,

    /// MRS, MSR
    ARM_INSTR_PSR_TRANSFER,

    /// Software interrupt (SWI)
    ARM_INSTR_SWI
  } arm_instr_t;

  typedef struct packed {
    condition_t condition;

    arm_instr_t instr_type;

    logic [3:0] Rd;
    logic [3:0] Rn;
    logic [3:0] Rm;
    logic [3:0] Rs;

    /// Per instruction opcode
    logic [3:0] opcode;
  } decoded_word_t;



endpackage : cpu_types_pkg
