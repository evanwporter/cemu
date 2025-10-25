#pragma once

#include <array>

#include "cpu/register.hpp"
#include "definitions.hpp"

class CPU;
class Gameboy;

class Opcodes {
public:
    // constructor
    Opcodes(Gameboy& gb, CPU& cpu);

    std::array<Register8*, 8> regTable {};

    void LD_r8_r8(u8 opcode);
    void LD_r8_n8(u8 opcode);

    void LD_r16_A(u8 opcode);
    void LD_A_r16(u8 opcode);

    void LD_r16_n16(u8 opcode);

    void INC_DEC_r8(u8 opcode);
    void INC_DEC_r16(u8 opcode);

    void INC16(u8 opcode);
    void INC8(u8 opcode);

    void DEC16(u8 opcode);
    void DEC8(u8 opcode);

    void ALU(u8 opcode);

    void ADD_HL_r16(u8 opcode);

    void LD_A16_SP();

    void JR(); // JR e8
    void JR(bool condition); // JR cc,e8

    void rotate_A(u8 opcode);

    void RST(u8 opcode);

    void PUSH(u8 opcode);
    void POP(u8 opcode);

    void DAA();
    void SCF();
    void CPL();
    void CCF();

    void RET_cc(u8 opcode);

    void JP_cc_a16(u8 opcode);

    void CALL_cc_a16(u8 opcode);
    void CALL(u8 opcode, bool conditional);

    void RET();

    void JP_HL();

    void LD_SP_HL();

    void JP_a16();

    // TODO
    void PREFIX_CB(u8 cb_opcode);

    void ALU_n8(u8 opcode);

    void LD_A16_A();
    void LD_A_A16();

    void ADD_SP_e8();

    void LD_HL_SP_e8();

    // -----------------

private:
    Gameboy& gb;
    CPU& cpu;

    void INCDEC8(u8 opcode, int delta);
    void INCDEC16(u8 opcode, int delta);

    inline void writeOperand8(u8 regIndex, u8 value);
    inline u8 readOperand8(u8 regIndex) const;

    inline u16 resolveAddressFromPair(u8 opcode);

    void ADC(u8 value);
    void SUB(u8 value);
    void ADD(u8 value);

    /// Subtract with Carry
    void SBC(u8 value);

    void AND(u8 value);

    void XOR(u8 value);
    void OR(u8 value);

    void CP(u8 value);

    // Gameboy Color CPU Instructions
    // ====================================

    // Rotates and Shifts
    void RLC(u8 regIndex); // Rotate Left Circular
    void RRC(u8 regIndex); // Rotate Right Circular
    void RL(u8 regIndex); // Rotate Left through Carry
    void RR(u8 regIndex); // Rotate Right through Carry
    void SLA(u8 regIndex); // Shift Left Arithmetic
    void SRA(u8 regIndex); // Shift Right Arithmetic
    void SWAP(u8 regIndex); // Swap upper/lower nibbles
    void SRL(u8 regIndex); // Shift Right Logical

    // Bit Operations
    void BIT(u8 bitIndex, u8 regIndex); // Test bit
    void RES(u8 bitIndex, u8 regIndex); // Reset bit
    void SET(u8 bitIndex, u8 regIndex); // Set bit
};