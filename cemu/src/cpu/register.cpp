#include "cpu/register.hpp"

#include "util/bitops.hpp"

void Register8::set(const u8 new_value) {
    val = new_value;
}

void Register8::reset() {
    val = 0;
}

u8 Register8::value() const { return val; }

void Register8::set_bit_to(u8 bit, bool set) {
    val = set_bit(val, bit, set);
}

void Register8::increment() {
    val += 1;
}
void Register8::decrement() {
    val -= 1;
}

bool Register8::operator==(u8 other) const { return val == other; }

Register16::Register16(Register8& high, Register8& low) :
    low_byte(low),
    high_byte(high) {
}

void Register16::set(const u16 word) {
    // Discard the upper byte
    low_byte.set(static_cast<u8>(word));

    // Discard the lower byte
    high_byte.set(static_cast<u8>((word) >> 8));
}

u8 Register16::low() const { return low_byte.value(); }

u8 Register16::high() const { return high_byte.value(); }

u16 Register16::value() const {
    return compose_bytes(high_byte.value(), low_byte.value());
}

void Register16::increment() {
    set(value() + 1);
}

void Register16::decrement() {
    set(value() - 1);
}
