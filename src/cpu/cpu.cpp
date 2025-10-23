#include <ios>
#include <iostream>

#include "cpu/cpu.hpp"
#include "cpu/opcodes.hpp"
#include "gameboy.hpp"
#include "types.hpp"

void CPU::step() {
    if (halted)
        return;

    u8 opcode = fetch_byte_from_pc();

    executeOpcode(opcode);
}

u8 CPU::fetch_byte_from_pc() {
    u8 byte = gb.mmu->read(PC.get());
    ++PC;

    return byte;
}

u16 CPU::fetch_word_from_pc() {
    u8 low = fetch_byte_from_pc();
    u8 high = fetch_byte_from_pc();
    return static_cast<u16>((high << 8) | low);
}

void CPU::executeOpcode(u8 opcode) {
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
    }

    // Handles rows 0x to 3x
    if (0x00 <= opcode && opcode <= 0x3F) {
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
        case 0x17:
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