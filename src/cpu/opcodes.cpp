#include "cpu/cpu.hpp"
#include "cpu/opcodes.hpp"
#include "cpu/register.hpp"
#include "gameboy.hpp"

inline u8 decodePairIndex(u8 opcode) {
    return (opcode >> 4) & 0b11;
}

Opcodes::Opcodes(Gameboy& gb, CPU& cpu) :
    regTable { &cpu.B, &cpu.C, &cpu.D, &cpu.E, &cpu.H, &cpu.L, nullptr, &cpu.A },
    gb(gb),
    cpu(cpu) {
}

void Opcodes::writeOperand8(u8 regIndex, u8 value) {
    if (regIndex == 6)
        // (HL) destination
        gb.mmu->write(cpu.HL.value(), value);
    else
        regTable[regIndex]->set(value);
}

u8 Opcodes::readOperand8(u8 regIndex) const {
    return (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value())
        : regTable[regIndex]->value();
}

// https://rgbds.gbdev.io/docs/v0.9.4/gbz80.7#LD_r8,r8
// Copy (aka Load) the value in register on the right into the register on the left.
void Opcodes::LD_r8_r8(u8 opcode) {
    u8 src = opcode & 0b111;
    u8 dst = (opcode >> 3) & 0b111;

    // Special case: LD (HL), (HL) = HALT (0x76)
    if (opcode == 0x76) {
        cpu.halted = true;
        return;
    }

    u8 value = readOperand8(src);
    writeOperand8(dst, value);
}

void Opcodes::LD_r8_n8(u8 opcode) {
    u8 dst = (opcode >> 3) & 0b111;
    u8 value = cpu.fetch_byte_from_pc();

    writeOperand8(dst, value);
}

u16 Opcodes::resolveAddressFromPair(u8 opcode) {
    switch (decodePairIndex(opcode)) {
    case 0:
        return cpu.BC.value();
    case 1:
        return cpu.DE.value();
    case 2:
        return cpu.HL.value();
    case 3:
        return cpu.SP.value();
    }
    return 0;
}

// ====================================
// LD (r16),A  [0x02, 0x12, 0x22, 0x32]
// ====================================
// https://rgbds.gbdev.io/docs/v0.9.4/gbz80.7#LD__r16_,A
void Opcodes::LD_r16_A(u8 opcode) {
    switch (opcode) {
    case 0x02: // LD (BC),A
        gb.mmu->write(cpu.BC.value(), cpu.A.value());
        break;

    case 0x12: // LD (DE),A
        gb.mmu->write(cpu.DE.value(), cpu.A.value());
        break;

    case 0x22: // LD (HL+),A
        gb.mmu->write(cpu.HL.value(), cpu.A.value());
        ++cpu.HL; // post-increment HL
        break;

    case 0x32: // LD (HL−),A
        gb.mmu->write(cpu.HL.value(), cpu.A.value());
        --cpu.HL; // post-decrement HL
        break;
    }
}

// ====================================
// LD A,(r16)  [0x0A, 0x1A, 0x2A, 0x3A]
// ====================================
// https://rgbds.gbdev.io/docs/v0.9.4/gbz80.7#LD_A,_r16_
void Opcodes::LD_A_r16(u8 opcode) {
    switch (opcode) {
    case 0x0A: // LD A,(BC)
        cpu.A.set(gb.mmu->read(cpu.BC.value()));
        break;

    case 0x1A: // LD A,(DE)
        cpu.A.set(gb.mmu->read(cpu.DE.value()));
        break;

    case 0x2A: // LD A,(HL+)
        cpu.A.set(gb.mmu->read(cpu.HL.value()));
        ++cpu.HL; // post-increment
        break;

    case 0x3A: // LD A,(HL−)
        cpu.A.set(gb.mmu->read(cpu.HL.value()));
        --cpu.HL; // post-decrement
        break;
    }
}

// https://rgbds.gbdev.io/docs/v0.9.4/gbz80.7#LD_rr,d16
void Opcodes::LD_r16_n16(u8 opcode) {
    const u16 value = cpu.fetch_word_from_pc();

    switch (opcode) {
    case 0x01:
        cpu.BC.set(value);
        break; // LD BC, d16
    case 0x11:
        cpu.DE.set(value);
        break; // LD DE, d16
    case 0x21:
        cpu.HL.set(value);
        break; // LD HL, d16
    case 0x31:
        cpu.SP.set(value);
        break; // LD SP, d16
    }
}

// ====================================
// Increment / Decrement
// ====================================
void Opcodes::INCDEC8(u8 opcode, int delta) {
    const bool isDec = (delta < 0);
    const u8 regIndex = (opcode >> 3) & 0b111;

    auto applyFlags = [&](u8 oldVal, u8 newVal) {
        flags::set_zero(cpu.F, newVal == 0);
        flags::set_subtract(cpu.F, isDec);
        if (isDec)
            flags::set_half_carry(cpu.F, (oldVal & 0x0F) == 0x00);
        else
            flags::set_half_carry(cpu.F, ((oldVal & 0x0F) + 1) > 0x0F);
    };

    if (regIndex == 6) {
        u16 addr = cpu.HL.value();
        u8 oldVal = gb.mmu->read(addr);
        u8 newVal = static_cast<u8>(oldVal + delta);
        gb.mmu->write(addr, newVal);
        applyFlags(oldVal, newVal);
    } else {
        Register8* reg = regTable[regIndex];
        u8 oldVal = reg->value();
        u8 newVal = static_cast<u8>(oldVal + delta);
        reg->set(newVal);
        applyFlags(oldVal, newVal);
    }
}

void Opcodes::INC8(u8 opcode) { INCDEC8(opcode, +1); }
void Opcodes::DEC8(u8 opcode) { INCDEC8(opcode, -1); }

void Opcodes::INCDEC16(u8 opcode, int delta) {
    const u8 pairIndex = decodePairIndex(opcode);

    switch (pairIndex) {
    case 0:
        cpu.BC.set(cpu.BC.value() + delta);
        break;
    case 1:
        cpu.DE.set(cpu.DE.value() + delta);
        break;
    case 2:
        cpu.HL.set(cpu.HL.value() + delta);
        break;
    case 3:
        cpu.SP.set(cpu.SP.value() + delta);
        break;
    }
}

void Opcodes::INC16(u8 opcode) { INCDEC16(opcode, +1); }
void Opcodes::DEC16(u8 opcode) { INCDEC16(opcode, -1); }

void Opcodes::ALU(const u8 opcode) {
    const u8 opType = (opcode >> 3) & 0b111;
    const u8 regIndex = opcode & 0b111;
    const u8 value = (regIndex == 6)
        ? gb.mmu->read(cpu.HL.value())
        : regTable[regIndex]->value();

    switch (opType) {
    case 0:
        ADD(value);
        break; // ADD A, r
    case 1:
        ADC(value);
        break; // ADC A, r
    case 2:
        SUB(value);
        break; // SUB A, r
    case 3:
        SBC(value);
        break; // SBC A, r
    case 4:
        AND(value);
        break; // AND A, r
    case 5:
        XOR(value);
        break; // XOR A, r
    case 6:
        OR(value);
        break; // OR A, r
    case 7:
        CP(value);
        break; // CP A, r
    }
}

// ====================================
// ADD HL, r16
// ====================================
void Opcodes::ADD_HL_r16(u8 opcode) {
    u16 hlVal = cpu.HL.value();
    u16 value = 0;

    // Bits 5–4 select the 16-bit register pair
    switch ((opcode >> 4) & 0b11) {
    case 0: // 00 — BC
        value = cpu.BC.value();
        break;
    case 1: // 01 — DE
        value = cpu.DE.value();
        break;
    case 2: // 10 — HL
        value = cpu.HL.value();
        break;
    case 3: // 11 — SP
        value = cpu.SP.value();
        break;
    }

    unsigned result = hlVal + value;

    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, ((hlVal & 0x0FFF) + (value & 0x0FFF)) > 0x0FFF);
    flags::set_carry(cpu.F, result > 0xFFFF);

    cpu.HL.set(static_cast<u16>(result));
}

// ====================================
// LD (a16), SP
// ====================================
void Opcodes::LD_A16_SP() {
    // Read 16-bit immediate address
    u16 addr = cpu.fetch_word_from_pc();

    // Write SP (low, then high) to memory
    u16 sp = cpu.SP.value();
    gb.mmu->write(addr, sp & 0xFF); // low byte
    gb.mmu->write(addr + 1, (sp >> 8)); // high byte
}

// ====================================
// JR (Jump Relative)
// ====================================
void Opcodes::JR() {
    JR(true);
}

void Opcodes::JR(bool condition) {
    s8 offset = static_cast<s8>(cpu.fetch_byte_from_pc());

    if (condition) {
        cpu.PC.set(static_cast<u16>(cpu.PC.value() + offset));
    }
}

// ====================================
// RLCA / RLA / RRCA / RRA (A register)
// ====================================
void Opcodes::rotate_A(u8 opcode) {
    u8 aVal = cpu.A.value();
    bool carryIn = flags::carry(cpu.F);
    bool carryOut = false;
    u8 result = aVal;

    switch (opcode) {
    case 0x07: // RLCA
        carryOut = (aVal & 0x80) != 0;
        result = static_cast<u8>((aVal << 1) | (carryOut ? 1 : 0));
        break;

    case 0x17: // RLA
        carryOut = (aVal & 0x80) != 0;
        result = static_cast<u8>((aVal << 1) | (carryIn ? 1 : 0));
        break;

    case 0x0F: // RRCA
        carryOut = (aVal & 0x01) != 0;
        result = static_cast<u8>((aVal >> 1) | (carryOut ? 0x80 : 0x00));
        break;

    case 0x1F: // RRA
        carryOut = (aVal & 0x01) != 0;
        result = static_cast<u8>((aVal >> 1) | (carryIn ? 0x80 : 0x00));
        break;
    }

    cpu.A.set(result);

    // Update flags using new flag system
    flags::set_zero(cpu.F, false);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, carryOut);
}

// ====================================
// DAA — Decimal Adjust Accumulator
// ====================================
void Opcodes::DAA() {
    u8 aVal = cpu.A.value();
    u8 correction = 0;
    bool set_carry = false;

    bool n = flags::subtract(cpu.F);
    bool h = flags::half_carry(cpu.F);
    bool c = flags::carry(cpu.F);

    if (h || (!n && ((aVal & 0x0F) > 9))) {
        correction |= 0x06;
    }
    if (c || (!n && aVal > 0x99)) {
        correction |= 0x60;
        set_carry = true;
    }

    aVal = n ? aVal - correction : aVal + correction;
    cpu.A.set(aVal);

    flags::set_zero(cpu.F, aVal == 0);
    flags::set_half_carry(cpu.F, false);
    if (set_carry)
        flags::set_carry(cpu.F, true);
}

// ====================================
// SCF — Set Carry Flag
// ====================================
void Opcodes::SCF() {
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, true);
}

// ====================================
// CPL — Complement A (A = ~A)
// ====================================
void Opcodes::CPL() {
    cpu.A.set(~cpu.A.value());

    flags::set_subtract(cpu.F, true);
    flags::set_half_carry(cpu.F, true);
}

// ====================================
// CCF — Complement Carry Flag
// ====================================
void Opcodes::CCF() {
    bool carry = flags::carry(cpu.F);

    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, !carry);
}

// ====================================
// RST — Restart (Call fixed address)
// ====================================
void Opcodes::RST(u8 opcode) {
    const u16 target = opcode & 0x38;
    cpu.stack_push(cpu.PC);
    cpu.PC.set(target);
}

// ====================================
// PUSH rr16 — Push register pair to stack
// ====================================
void Opcodes::PUSH(u8 opcode) {
    // Bits 5–4 select which 16-bit register pair
    const u8 pairIndex = (opcode >> 4) & 0b11;
    u16 value = 0;

    switch (pairIndex) {
    case 0:
        value = cpu.BC.value();
        break; // PUSH BC (0xC5)
    case 1:
        value = cpu.DE.value();
        break; // PUSH DE (0xD5)
    case 2:
        value = cpu.HL.value();
        break; // PUSH HL (0xE5)
    case 3:
        value = cpu.AF.value();
        break; // PUSH AF (0xF5)
    }

    // Stack grows downward
    u16 sp = cpu.SP.value();
    gb.mmu->write(--sp, (value >> 8) & 0xFF); // High byte
    gb.mmu->write(--sp, value & 0xFF); // Low byte
    cpu.SP.set(sp);
}

// ====================================
// POP rr16 — Pop 16-bit register pair from stack
// ====================================
void Opcodes::POP(u8 opcode) {
    // Bits 5–4 select which register pair
    const u8 pairIndex = (opcode >> 4) & 0b11;
    u16 sp = cpu.SP.value();

    // Read low then high byte
    u8 low = gb.mmu->read(sp++);
    u8 high = gb.mmu->read(sp++);
    u16 value = (high << 8) | low;

    cpu.SP.set(sp);

    switch (pairIndex) {
    case 0:
        cpu.BC.set(value);
        break; // POP BC (0xC1)
    case 1:
        cpu.DE.set(value);
        break; // POP DE (0xD1)
    case 2:
        cpu.HL.set(value);
        break; // POP HL (0xE1)
    case 3:
        // POP AF — F is flag register (lower 4 bits always 0)
        cpu.AF.set(value & 0xFFF0);
        break;
    }
}

void Opcodes::ADD(u8 value) {
    u8 aVal = cpu.A.value();
    unsigned result = aVal + value;

    cpu.A.set(static_cast<u8>(result));

    flags::set_zero(cpu.F, cpu.A.value() == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, ((aVal & 0xF) + (value & 0xF)) > 0xF);
    flags::set_carry(cpu.F, result > 0xFF);
}

void Opcodes::ADC(u8 value) {
    u8 aVal = cpu.A.value();
    u8 carry = flags::carry(cpu.F) ? 1 : 0;

    unsigned resultFull = aVal + value + carry;
    u8 result = static_cast<u8>(resultFull);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, ((aVal & 0xF) + (value & 0xF) + carry) > 0xF);
    flags::set_carry(cpu.F, resultFull > 0xFF);

    cpu.A.set(result);
}

// ====================================
// SBC — Subtract with Carry
// ====================================
void Opcodes::SBC(u8 value) {
    u8 aVal = cpu.A.value();
    u8 carry = flags::carry(cpu.F) ? 1 : 0;
    int resultFull = static_cast<int>(aVal) - value - carry;
    u8 result = static_cast<u8>(resultFull);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, true);
    flags::set_half_carry(cpu.F, ((aVal & 0x0F) - (value & 0x0F) - carry) < 0);
    flags::set_carry(cpu.F, resultFull < 0);
    cpu.A.set(result);
}

void Opcodes::AND(u8 value) {
    u8 result = cpu.A.value() & value;
    cpu.A.set(result);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, true);
    flags::set_carry(cpu.F, false);
}

void Opcodes::XOR(u8 value) {
    u8 result = cpu.A.value() ^ value;

    cpu.A.set(result);
    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, false);
}

void Opcodes::OR(u8 value) {
    u8 result = cpu.A.value() | value;
    cpu.A.set(result);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, false);
    flags::set_carry(cpu.F, false);
}

void Opcodes::CP(u8 value) {
    u8 aVal = cpu.A.value();
    u8 result = static_cast<u8>(aVal - value);

    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, true);
    flags::set_half_carry(cpu.F, ((aVal & 0xF) - (value & 0xF)) < 0);
    flags::set_carry(cpu.F, aVal < value);
}

// ====================================
// SUB — Subtract (no carry)
// ====================================
void Opcodes::SUB(u8 value) {
    u8 aVal = cpu.A.value();
    u8 result = static_cast<u8>(aVal - value);

    cpu.A.set(result);
    flags::set_zero(cpu.F, result == 0);
    flags::set_subtract(cpu.F, true);
    flags::set_half_carry(cpu.F, ((aVal & 0x0F) - (value & 0x0F)) < 0);
    flags::set_carry(cpu.F, aVal < value);
}

// ====================================
// RET NZ / RET NC — Conditional Returns
// ====================================
// https://rgbds.gbdev.io/docs/v0.9.4/gbz80.7#RET_cc
void Opcodes::RET_cc(u8 opcode) {
    bool condition = false;

    switch (opcode) {
    case 0xC0: // RET NZ
        condition = !flags::zero(cpu.F);
        break;
    case 0xD0: // RET NC
        condition = !flags::carry(cpu.F);
        break;
    case 0xC8: // RET Z
        condition = flags::zero(cpu.F);
        break;
    case 0xD8: // RET C
        condition = flags::carry(cpu.F);
        break;
    default:
        return;
    }

    if (condition) {
        cpu.stack_pop(cpu.PC);
    }
}
// https://rgbds.gbdev.io/docs/v0.9.4/gbz80.7#JP_cc,a16
void Opcodes::JP_cc_a16(u8 opcode) {
    u16 addr = cpu.fetch_word_from_pc();

    bool shouldJump = false;
    switch ((opcode >> 3) & 0x03) { // Bits 4–3
    case 0: // NZ
        shouldJump = !flags::zero(cpu.F);
        break;
    case 1: // Z
        shouldJump = flags::zero(cpu.F);
        break;
    case 2: // NC
        shouldJump = !flags::carry(cpu.F);
        break;
    case 3: // C
        shouldJump = flags::carry(cpu.F);
        break;
    }

    if (shouldJump) {
        cpu.PC.set(addr);
    }
}

void Opcodes::CALL(u8 opcode, bool conditional) {
    u16 addr = cpu.fetch_word_from_pc();
    if (conditional) {
        cpu.stack_push(cpu.PC);
        cpu.PC.set(addr);
    }
}

void Opcodes::CALL_cc_a16(u8 opcode) {
    bool shouldJump = false;
    switch ((opcode >> 3) & 0x03) {
    case 0:
        shouldJump = !flags::zero(cpu.F);
        break; // NZ
    case 1:
        shouldJump = flags::zero(cpu.F);
        break; // Z
    case 2:
        shouldJump = !flags::carry(cpu.F);
        break; // NC
    case 3:
        shouldJump = flags::carry(cpu.F);
        break; // C
    }
    CALL(opcode, shouldJump);
}

void Opcodes::RET() {
    cpu.stack_pop(cpu.PC);
}

void Opcodes::JP_HL() {
    cpu.PC.set(cpu.HL.value());
}

void Opcodes::LD_SP_HL() {
    cpu.SP.set(cpu.HL.value());
}

void Opcodes::JP_a16() {
    u16 addr = cpu.fetch_word_from_pc();
    cpu.PC.set(addr);
}

// ====================================
// ALU operations with immediate (A, n8)
// ====================================
void Opcodes::ALU_n8(u8 opcode) {
    u8 value = cpu.fetch_byte_from_pc();

    switch (opcode) {
    case 0xC6: // ADD A, n8
        ADD(value);
        break;

    case 0xCE: // ADC A, n8
        ADC(value);
        break;

    case 0xD6: // SUB n8
        SUB(value);
        break;

    case 0xDE: // SBC A, n8
        SBC(value);
        break;

    case 0xE6: // AND n8
        AND(value);
        break;

    case 0xEE: // XOR n8
        XOR(value);
        break;

    case 0xF6: // OR n8
        OR(value);
        break;

    case 0xFE: // CP n8
        CP(value);
        break;
    }
}

void Opcodes::LD_A16_A() {
    u16 addr = cpu.fetch_word_from_pc();
    gb.mmu->write(addr, cpu.A.value());
}

void Opcodes::LD_A_A16() {
    u16 addr = cpu.fetch_word_from_pc();
    cpu.A.set(gb.mmu->read(addr));
}

void Opcodes::ADD_SP_e8() {
    s8 offset = static_cast<s8>(cpu.fetch_byte_from_pc());
    u16 sp = cpu.SP.value();
    u16 result = sp + offset;

    flags::set_zero(cpu.F, false);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, ((sp ^ offset ^ (result & 0xFFFF)) & 0x10) != 0);
    flags::set_carry(cpu.F, ((sp ^ offset ^ (result & 0xFFFF)) & 0x100) != 0);

    cpu.SP.set(result);
}

void Opcodes::LD_HL_SP_e8() {
    s8 offset = static_cast<s8>(cpu.fetch_byte_from_pc());
    u16 sp = cpu.SP.value();
    u16 result = sp + offset;

    cpu.HL.set(result);

    flags::set_zero(cpu.F, false);
    flags::set_subtract(cpu.F, false);
    flags::set_half_carry(cpu.F, ((sp ^ offset ^ (result & 0xFFFF)) & 0x10) != 0);
    flags::set_carry(cpu.F, ((sp ^ offset ^ (result & 0xFFFF)) & 0x100) != 0);
}