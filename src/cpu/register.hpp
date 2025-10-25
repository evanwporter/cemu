#pragma once

#include "cpu/register.hpp"
#include "definitions.hpp"

class Register8 {
public:
    void set(u8 new_value);
    void reset();
    u8 value() const;

    void set_bit_to(u8 bit, bool set);

    void increment();
    void decrement();

    bool operator==(u8 other) const;
    Register8& operator++() {
        set(value() + 1);
        return *this;
    }
    Register8& operator--() {
        set(value() - 1);
        return *this;
    }

protected:
    u8 val = 0x0;
};

using FlagRegister = Register8;

inline void set_flag(FlagRegister& F, u8 flag, bool state) {
    u8 val = F.value();
    if (state)
        val |= flag;
    else
        val &= ~flag;
    F.set(val & 0xF0); // ensure lower bits are always zero
}

inline bool get_flag(const FlagRegister& F, u8 flag) {
    return (F.value() & flag) != 0;
}

namespace flags {
    constexpr u8 FLAG_Z = 1 << 7; // Zero
    constexpr u8 FLAG_N = 1 << 6; // Subtract
    constexpr u8 FLAG_H = 1 << 5; // Half Carry
    constexpr u8 FLAG_C = 1 << 4; // Carry

    inline void set_zero(FlagRegister& F, bool v) { set_flag(F, FLAG_Z, v); }
    inline void set_subtract(FlagRegister& F, bool v) { set_flag(F, FLAG_N, v); }
    inline void set_half_carry(FlagRegister& F, bool v) { set_flag(F, FLAG_H, v); }
    inline void set_carry(FlagRegister& F, bool v) { set_flag(F, FLAG_C, v); }

    inline bool zero(const FlagRegister& F) { return get_flag(F, FLAG_Z); }
    inline bool subtract(const FlagRegister& F) { return get_flag(F, FLAG_N); }
    inline bool half_carry(const FlagRegister& F) { return get_flag(F, FLAG_H); }
    inline bool carry(const FlagRegister& F) { return get_flag(F, FLAG_C); }

    inline u8 carry_value(const FlagRegister& F) { return static_cast<u8>(carry(F) ? 1 : 0); }
    inline u8 half_carry_value(const FlagRegister& F) { return static_cast<u8>(half_carry(F) ? 1 : 0); }
    inline u8 subtract_value(const FlagRegister& F) { return static_cast<u8>(subtract(F) ? 1 : 0); }
    inline u8 zero_value(const FlagRegister& F) { return static_cast<u8>(zero(F) ? 1 : 0); }

}

class Register16 {
public:
    Register16(Register8& high, Register8& low);

    void set(u16 word);

    u16 value() const;

    u8 low() const;
    u8 high() const;

    void increment();
    void decrement();

    Register16& operator++() {
        set(value() + 1);
        return *this;
    }
    Register16& operator--() {
        set(value() - 1);
        return *this;
    }

private:
    Register8& low_byte;
    Register8& high_byte;
};
