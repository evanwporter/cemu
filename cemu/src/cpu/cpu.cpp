#include <ios>
#include <iostream>

#include "cpu.hpp"
#include "cpu/register.hpp"
#include "gameboy.hpp"
#include "opcode_cycles.hpp"
#include "opcodes.hpp"
#include "util/bitops.hpp"

CPU::CPU(Gameboy& gb, Options& options) :
    opcodes(gb, *this),
    AF(A, F),
    BC(B, C),
    DE(D, E),
    HL(H, L),
    PC(_P1, _C),
    SP(_S, _P2),
    gb(gb),
    options(options) {
}

Cycles CPU::tick() {
    handle_interrupts();

    if (halted) {
        return 1;
    }

    u16 opcode_pc = PC.value();
    auto opcode = fetch_byte_from_pc();
    auto cycles = execute_opcode(opcode, opcode_pc);
    return cycles;
}

Cycles CPU::execute_opcode(const u8 opcode, u16 opcode_pc) {
    branch_taken = false;

    if (opcode == 0xCB) {
        u8 cb_opcode = fetch_byte_from_pc();
        opcodes.PREFIX_CB(cb_opcode);
        return opcode_cycles_cb[cb_opcode];
    }

    execute_opcode(opcode);

    return !branch_taken
        ? opcode_cycles[opcode]
        : opcode_cycles_branched[opcode];
}

void CPU::handle_interrupts() {
    u8 fired_interrupts = interrupt_flag.value() & interrupt_enabled.value();
    if (!fired_interrupts) {
        return;
    }

    if (halted && fired_interrupts != 0x0) {
        // TODO: Handle halt bug
        halted = false;
    }

    if (!interrupts_enabled) {
        return;
    }

    stack_push(PC);

    bool handled_interrupt = false;

    handled_interrupt = handle_interrupt(0, interrupts::vblank, fired_interrupts);
    if (handled_interrupt) {
        return;
    }

    handled_interrupt = handle_interrupt(1, interrupts::lcdc_status, fired_interrupts);
    if (handled_interrupt) {
        return;
    }

    handled_interrupt = handle_interrupt(2, interrupts::timer, fired_interrupts);
    if (handled_interrupt) {
        return;
    }

    handled_interrupt = handle_interrupt(3, interrupts::serial, fired_interrupts);
    if (handled_interrupt) {
        return;
    }

    handled_interrupt = handle_interrupt(4, interrupts::joypad, fired_interrupts);
    if (handled_interrupt) {
        return;
    }
}

bool CPU::handle_interrupt(u8 interrupt_bit, u16 interrupt_vector, u8 fired_interrupts) {

    if (!check_bit(fired_interrupts, interrupt_bit)) {
        return false;
    }

    interrupt_flag.set_bit_to(interrupt_bit, false);
    PC.set(interrupt_vector);
    interrupts_enabled = false;
    return true;
}

u8 CPU::fetch_byte_from_pc() {
    u8 byte = gb.mmu->read(Address(PC));
    PC.increment();

    return byte;
}

s8 CPU::get_signed_byte_from_pc() {
    u8 byte = fetch_byte_from_pc();
    return static_cast<s8>(byte);
}

u16 CPU::fetch_word_from_pc() {
    u8 low_byte = fetch_byte_from_pc();
    u8 high_byte = fetch_byte_from_pc();

    return compose_bytes(high_byte, low_byte);
}

void CPU::set_flag_zero(bool set) { flags::set_zero(F, set); }
void CPU::set_flag_subtract(bool set) { flags::set_subtract(F, set); }
void CPU::set_flag_half_carry(bool set) { flags::set_half_carry(F, set); }
void CPU::set_flag_carry(bool set) { flags::set_carry(F, set); }

bool CPU::is_condition(Condition condition) {
    bool should_branch;

    switch (condition) {
    case Condition::C:
        should_branch = flags::carry(F);
        break;
    case Condition::NC:
        should_branch = !flags::carry(F);
        break;
    case Condition::Z:
        should_branch = flags::zero(F);
        break;
    case Condition::NZ:
        should_branch = !flags::zero(F);
        break;
    }

    /* If the branch is taken, remember so that the correct processor cycles
     * can be used */
    branch_taken = should_branch;
    return should_branch;
}

void CPU::stack_push(const Register16& reg) {
    SP.decrement();
    gb.mmu->write(Address(SP), reg.high());
    SP.decrement();
    gb.mmu->write(Address(SP), reg.low());
}

void CPU::stack_pop(Register16& reg) {
    u8 low_byte = gb.mmu->read(Address(SP));
    SP.increment();
    u8 high_byte = gb.mmu->read(Address(SP));
    SP.increment();

    u16 value = compose_bytes(high_byte, low_byte);
    reg.set(value);
}

void CPU::execute_opcode(u8 opcode) {
    switch (opcode) {
    case 0x00:
        return; // NOP

    case 0x08:
        opcodes.LD_A16_SP();
        return;

    case 0x18: // JR e8
        opcodes.JR();
        return;

    case 0x20: // JR NZ, e8
        opcodes.JR(!flags::zero(F));
        return;

    case 0x28: // JR Z, e8
        opcodes.JR(flags::zero(F));
        return;

    case 0x30: // JR NC, e8
        opcodes.JR(!flags::carry(F));
        return;

    case 0x38: // JR C, e8
        opcodes.JR(flags::carry(F));
        return;

    case 0x07: // RLCA
    case 0x17: // RLA
    case 0x0F: // RRCA
    case 0x1F: // RRA
        opcodes.rotate_A(opcode);
        return;

    case 0x27:
        opcodes.DAA();
        return;
    case 0x37:
        opcodes.SCF();
        return;
    case 0x2F:
        opcodes.CPL();
        return;
    case 0x3F:
        opcodes.CCF();
        return;

    case 0xC0: // RET NZ
    case 0xD0: // RET NC
    case 0xC8: // RET Z
    case 0xD8: // RET C
        opcodes.RET_cc(opcode);
        return;

    case 0xC2:
    case 0xD2:
    case 0xCA:
    case 0xDA:
        opcodes.JP_cc_a16(opcode);
        return;

    case 0xC9:
        opcodes.RET();
        return;

    case 0xE9:
        opcodes.JP_HL();
        return;

    case 0xFB:
        gb.cpu->interrupts_enabled = true;
        return; // EI

    case 0xF3:
        gb.cpu->interrupts_enabled = false;
        return; // DI

    case 0xC3:
        opcodes.JP_a16();
        return;

    case 0xCD:
        opcodes.CALL(opcode, true);
        return;

    case 0xC4:
    case 0xCC:
    case 0xD4:
    case 0xDC:
        opcodes.CALL_cc_a16(opcode);
        return;

    case 0xE0: {
        u8 n = fetch_byte_from_pc();
        gb.mmu->write(0xFF00 + n, A.value());
        return;
    }

    case 0xF0: {
        u8 n = fetch_byte_from_pc();
        A.set(gb.mmu->read(0xFF00 + n));
        return;
    }

    case 0xE2:
        gb.mmu->write(0xFF00 + C.value(), A.value());
        return;
    case 0xF2:
        A.set(gb.mmu->read(0xFF00 + C.value()));
        return;

    case 0xEA: // LD (a16),A
        opcodes.LD_A16_A();
        return;

    case 0xFA: // LD A,(a16)
        opcodes.LD_A_A16();
        return;

    case 0xE8: // ADD SP, e8
        opcodes.ADD_SP_e8();
        return;

    case 0xF8: // LD HL, SP+e8
        opcodes.LD_HL_SP_e8();
        return;

    case 0xD9: // RETI
        opcodes.RET();
        interrupts_enabled = true;
        return;

    case 0xF9: // LD SP,HL
        opcodes.LD_SP_HL();
        return;
    }

    if ((opcode & 0xC7) == 0xC6) { // matches C6, CE, D6, DE, E6, EE, F6, FE
        opcodes.ALU_n8(opcode);
        return;
    }

    // Handles rows 0x to 3x
    else if (0x00 <= opcode && opcode <= 0x3F) {
        const u8 column = opcode & 0x0F;
        switch (column) {
        case 0x01:
            opcodes.LD_r16_n16(opcode);
            break;
        case 0x06:
        case 0x0E:
            opcodes.LD_r8_n8(opcode);
            break;

        case 0x02:
            opcodes.LD_r16_A(opcode);
            break;

        case 0x0A:
            opcodes.LD_A_r16(opcode);
            break;

        case 0x03:
            opcodes.INC16(opcode);
            break;

        case 0x0B:
            opcodes.DEC16(opcode);
            break;

        case 0x04:
        case 0x0C:
            opcodes.INC8(opcode);
            break;

        case 0x05:
        case 0x0D:
            opcodes.DEC8(opcode);
            break;

        case 0x09:
            opcodes.ADD_HL_r16(opcode);
            break;
        }
    }

    // Handles rows 4x to 7x
    else if (0x40 <= opcode && opcode <= 0x7F) {
        opcodes.LD_r8_r8(opcode);
        return;
    }

    // Handles rows 8x to Bx
    else if (0x80 <= opcode && opcode <= 0xBF) {
        opcodes.ALU(opcode);
        return;
    }

    // Handles rows 8x to Bx
    else if (0xC0 <= opcode && opcode <= 0xFF) {
        const u8 column = opcode & 0x0F;
        switch (column) {
        case 0x07:
        case 0x0F:
            opcodes.RST(opcode);
            break;

        case 0x05:
            opcodes.PUSH(opcode);
            break;

        case 0x01:
            opcodes.POP(opcode);
            break;
        }
    } else {
        std::cerr << "Unhandled opcode 0x" << std::hex << +opcode << "\n";
    }
}