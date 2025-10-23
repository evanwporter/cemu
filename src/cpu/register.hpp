#pragma once

#include <stdexcept>

#include "types.hpp"

class Register8 {
public:
    Register8(u8 initial = 0) :
        value(initial) { }

    // Get/set full byte
    u8 get() const { return value; }
    void set(u8 v) { value = v; }

    bool get_bit(int bit) const {
        if (bit < 0 || bit > 7)
            throw std::out_of_range("bit index out of range");
        return (value >> bit) & 1;
    }

    void set_bit(int bit, bool state) {
        if (bit < 0 || bit > 7)
            throw std::out_of_range("bit index out of range");
        if (state)
            value |= (1 << bit);
        else
            value &= ~(1 << bit);
    }

    Register8& operator++() {
        value++;
        return *this;
    }
    Register8& operator--() {
        value--;
        return *this;
    }

    // Implicit conversion to u8
    operator u8() const { return value; }

private:
    u8 value;
};

class Register16 {
public:
    Register16() {
    }
    u16 get() const {
        return (static_cast<u16>(high_.get()) << 8) | low_.get();
    }
    void set(u16 v) {
        high_.set(static_cast<u8>(v >> 8));
        low_.set(static_cast<u8>(v & 0xFF));
    }

    // clang-format off
    Register16& operator++() { set(get() + 1); return *this; }
    Register16& operator--() { set(get() - 1); return *this; }

    // Implicit conversion to u16
    operator u16() const { return get(); }

    Register8& high() { return high_; }
    Register8& low() { return low_; }
    const Register8& high() const { return high_; }
    const Register8& low() const { return low_; }

    // clang-format on

private:
    Register8 high_;
    Register8 low_;
};

using FlagRegister = Register8;

inline void setFlag(FlagRegister& F, u8 flag, bool state) {
    u8 val = F.get();
    if (state)
        val |= flag;
    else
        val &= ~flag;
    F.set(val & 0xF0); // ensure lower bits are always zero
}

inline bool getFlag(const FlagRegister& F, u8 flag) {
    return (F.get() & flag) != 0;
}

namespace flags {
    constexpr u8 FLAG_Z = 1 << 7; // Zero
    constexpr u8 FLAG_N = 1 << 6; // Subtract
    constexpr u8 FLAG_H = 1 << 5; // Half Carry
    constexpr u8 FLAG_C = 1 << 4; // Carry

    inline void setZero(FlagRegister& F, bool v) { setFlag(F, FLAG_Z, v); }
    inline void setSubtract(FlagRegister& F, bool v) { setFlag(F, FLAG_N, v); }
    inline void setHalfCarry(FlagRegister& F, bool v) { setFlag(F, FLAG_H, v); }
    inline void setCarry(FlagRegister& F, bool v) { setFlag(F, FLAG_C, v); }

    inline bool zero(const FlagRegister& F) { return getFlag(F, FLAG_Z); }
    inline bool subtract(const FlagRegister& F) { return getFlag(F, FLAG_N); }
    inline bool halfCarry(const FlagRegister& F) { return getFlag(F, FLAG_H); }
    inline bool carry(const FlagRegister& F) { return getFlag(F, FLAG_C); }
}
