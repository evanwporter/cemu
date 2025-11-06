#include "cpu/cpu.hpp"
#include "cpu/opcodes.hpp"
#include "cpu/register.hpp"
#include "gameboy.hpp"

void Opcodes::RLC(u8 regIndex) {
    u8 value = (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value()) // (HL)
        : regTable[regIndex]->value();

    bool newCarry = (value & 0x80) != 0;
    u8 result = static_cast<u8>((value << 1) | (newCarry ? 1 : 0));

    if (regIndex == 6)
        gb.mmu->write(cpu.HL.value(), result);
    else
        regTable[regIndex]->set(result);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, newCarry);
}

void Opcodes::RRC(u8 regIndex) {
    u8 value = (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value())
        : regTable[regIndex]->value();

    bool newCarry = (value & 0x01) != 0; // old bit 0
    u8 result = static_cast<u8>((value >> 1) | (newCarry ? 0x80 : 0x00));

    if (regIndex == 6)
        gb.mmu->write(cpu.HL.value(), result);
    else
        regTable[regIndex]->set(result);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, newCarry);
}

void Opcodes::RL(u8 regIndex) {
    u8 value = (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value())
        : regTable[regIndex]->value();

    bool oldCarry = flags::carry(cpu.F);
    bool newCarry = (value & 0x80) != 0; // bit 7

    u8 result = static_cast<u8>((value << 1) | (oldCarry ? 1 : 0));

    if (regIndex == 6)
        gb.mmu->write(cpu.HL.value(), result);
    else
        regTable[regIndex]->set(result);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, newCarry);
}

void Opcodes::RR(u8 regIndex) {
    u8 value = (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value())
        : regTable[regIndex]->value();

    bool oldCarry = flags::carry(cpu.F);
    bool newCarry = (value & 0x01) != 0; // bit 0

    u8 result = static_cast<u8>((value >> 1) | (oldCarry ? 0x80 : 0x00));

    if (regIndex == 6)
        gb.mmu->write(cpu.HL.value(), result);
    else
        regTable[regIndex]->set(result);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, newCarry);
}

void Opcodes::SLA(u8 regIndex) {
    u8 value = (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value())
        : regTable[regIndex]->value();

    bool newCarry = (value & 0x80) != 0;
    u8 result = static_cast<u8>(value << 1);

    if (regIndex == 6)
        gb.mmu->write(cpu.HL.value(), result);
    else
        regTable[regIndex]->set(result);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, newCarry);
}

void Opcodes::SRA(u8 regIndex) {
    u8 value = (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value())
        : regTable[regIndex]->value();

    bool newCarry = (value & 0x01) != 0;
    bool msb = (value & 0x80) != 0;
    u8 result = static_cast<u8>((value >> 1) | (msb ? 0x80 : 0x00));

    if (regIndex == 6)
        gb.mmu->write(cpu.HL.value(), result);
    else
        regTable[regIndex]->set(result);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, newCarry);
}

void Opcodes::SWAP(u8 regIndex) {
    u8 value = (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value())
        : regTable[regIndex]->value();

    u8 result = static_cast<u8>(((value & 0x0F) << 4) | ((value & 0xF0) >> 4));

    if (regIndex == 6)
        gb.mmu->write(cpu.HL.value(), result);
    else
        regTable[regIndex]->set(result);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, false);
}

void Opcodes::SRL(u8 regIndex) {
    u8 value = (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value())
        : regTable[regIndex]->value();

    bool newCarry = (value & 0x01) != 0;
    u8 result = static_cast<u8>(value >> 1); // bit7 becomes 0

    if (regIndex == 6)
        gb.mmu->write(cpu.HL.value(), result);
    else
        regTable[regIndex]->set(result);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, newCarry);
}

void Opcodes::BIT(u8 bitIndex, u8 regIndex) {
    u8 value = (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value())
        : regTable[regIndex]->value();

    bool bitSet = (value & (1 << bitIndex)) != 0;

    flags::set_zero(cpu.F, !bitSet);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, true);
}

void Opcodes::RES(u8 bitIndex, u8 regIndex) {
    if (regIndex == 6) {
        u16 addr = cpu.HL.value();
        u8 value = gb.mmu->read(addr);
        value &= ~(1 << bitIndex);
        gb.mmu->write(addr, value);
    } else {
        u8 value = regTable[regIndex]->value();
        value &= ~(1 << bitIndex);
        regTable[regIndex]->set(value);
    }
}

void Opcodes::SET(u8 bitIndex, u8 regIndex) {
    if (regIndex == 6) {
        u16 addr = cpu.HL.value();
        u8 value = gb.mmu->read(addr);
        value |= (1 << bitIndex);
        gb.mmu->write(addr, value);
    } else {
        u8 value = regTable[regIndex]->value();
        value |= (1 << bitIndex);
        regTable[regIndex]->set(value);
    }
}

void Opcodes::PREFIX_CB(u8 cb_opcode) {
    const u8 regIndex = cb_opcode & 0b111;
    const u8 group = (cb_opcode & 0xF8);

    switch (group) {
    case 0x00:
        RLC(regIndex);
        break;
    case 0x08:
        RRC(regIndex);
        break;
    case 0x10:
        RL(regIndex);
        break;
    case 0x18:
        RR(regIndex);
        break;
    case 0x20:
        SLA(regIndex);
        break;
    case 0x28:
        SRA(regIndex);
        break;
    case 0x30:
        SWAP(regIndex);
        break;
    case 0x38:
        SRL(regIndex);
        break;
    default:
        if (cb_opcode >= 0x40 && cb_opcode <= 0x7F) {
            // BIT
            u8 bitIndex = (cb_opcode >> 3) & 0b111;
            BIT(bitIndex, regIndex);
        } else if (cb_opcode >= 0x80 && cb_opcode <= 0xBF) {
            // RES
            u8 bitIndex = (cb_opcode >> 3) & 0b111;
            RES(bitIndex, regIndex);
        } else if (cb_opcode >= 0xC0 && cb_opcode <= 0xFF) {
            // SET
            u8 bitIndex = (cb_opcode >> 3) & 0b111;
            SET(bitIndex, regIndex);
        } else {
            printf("Unhandled CB opcode: 0x%02X\n", cb_opcode);
        }
        break;
    }
}
