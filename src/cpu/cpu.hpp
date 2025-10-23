#pragma once

#include "cpu/register.hpp"
#include "opcodes.hpp"
#include "types.hpp"

class GameBoy;

class CPU {
public:
    // 16-bit register pairs
    Register16 AF;
    Register16 BC;
    Register16 DE;
    Register16 HL;

    /// Stack Pointer
    Register16 SP;

    /// Program Counter
    Register16 PC;

    // 8-bit registers
    Register8 &A, &B, &C, &D, &E, &H, &L;
    FlagRegister& F;

    // constructor
    CPU(GameBoy& gb) :
        A(AF.high()), B(BC.high()),
        C(BC.low()), D(DE.high()),
        E(DE.low()), H(HL.high()),
        L(HL.low()), F(AF.low()),
        opcodes(gb, *this),
        gb(gb) { }

    // CPU control methods
    void reset();
    void step(); // executes one instruction

    bool interruptsEnabled = false;
    bool halted = false;

    Opcodes opcodes;

    void executeOpcode(u8 opcode);

    u8 fetch_byte_from_pc();
    u16 fetch_word_from_pc();

private:
    GameBoy& gb;
};
