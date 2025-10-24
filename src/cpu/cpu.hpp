#pragma once

#include "cpu/register.hpp"
#include "opcodes.hpp"
#include "types.hpp"

class GameBoy;

class CPU {
public:
    // 8-bit registers
    Register8 A, B, C, D, E, H, L;
    FlagRegister F;

    // Backing bytes for SP and PC
    Register8 SP_high, SP_low;
    Register8 PC_high, PC_low;

    // 16-bit register pairs
    Register16 AF;
    Register16 BC;
    Register16 DE;
    Register16 HL;

    /// Stack Pointer
    Register16 SP;

    /// Program Counter
    Register16 PC;

    // constructor
    CPU(GameBoy& gb) :
        AF(A, F), BC(B, C),
        DE(D, E), HL(H, L),
        SP(SP_high, SP_low),
        PC(PC_high, PC_low),
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

    Register8 interrupt_flag;
    Register8 interrupt_enabled;

    bool handle_interrupt(u8 interrupt_bit, u16 interrupt_vector, u8 fired_interrupts);
    void handle_interrupts();

    u16 stack_pop();
    void stack_push(u16 value);

private:
    GameBoy& gb;

    // Not meant to ever be used. I just need somewhere to hold ownership of these registers.
    Register8 _S, _P1, _P2, _C;
};
