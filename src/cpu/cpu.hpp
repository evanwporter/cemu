#pragma once

#include "cpu/register.hpp"
#include "opcodes.hpp"
#include "options.hpp"

class Gameboy;

enum class Condition {
    NZ,
    Z,
    NC,
    C,
};

namespace interrupts {
    const u16 vblank = 0x40;
    const u16 lcdc_status = 0x48;
    const u16 timer = 0x50;
    const u16 serial = 0x58;
    const u16 joypad = 0x60;
} // namespace interrupts

class CPU {
public:
    CPU(Gameboy& gb, Options& options);

    Opcodes opcodes;

    Cycles tick();

    Cycles execute_opcode(u8 opcode, u16 opcode_pc);

    Cycles execute_cb_opcode(u8 opcode, u16 opcode_pc);
    void execute_opcode(u8 opcode);

    Register8 interrupt_flag;
    Register8 interrupt_enabled;

    // Basic registers
    Register8 A, B, C, D, E, H, L;

    // Group registers for operations which use two registers as a word
    Register16 AF;
    Register16 BC;
    Register16 DE;
    Register16 HL;

    Register16 PC, SP;

    void handle_interrupts();
    bool handle_interrupt(u8 interrupt_bit, u16 interrupt_vector, u8 fired_interrupts);

    Gameboy& gb;
    Options& options;

    // Not meant to ever be used. I just need somewhere to hold ownership of these registers.
    Register8 _S, _P1, _P2, _C;

    bool interrupts_enabled = false;
    bool halted = false;

    bool branch_taken = false;

    /*
     * Flags set dependant on the result of the last operation
     *  0x80 - produced 0
     *  0x40 - was a subtraction
     *  0x20 - lower half of the byte overflowed 15
     *  0x10 - overflowed 255 or underflowed 0 for additions/subtractions
     */
    FlagRegister F;

    void set_flag_zero(bool set);
    void set_flag_subtract(bool set);
    void set_flag_half_carry(bool set);
    void set_flag_carry(bool set);

    /* Note: Not const because this also sets the 'branch_taken' member
     * variable if a branch is taken. This allows the correct cycle
     * count to be used */
    bool is_condition(Condition condition);

    u8 fetch_byte_from_pc();
    s8 get_signed_byte_from_pc();
    u16 fetch_word_from_pc();

    void stack_push(const Register16& reg);
    void stack_pop(Register16& reg);

private:
    friend class Debugger;
};
