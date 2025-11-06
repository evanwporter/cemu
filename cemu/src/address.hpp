#pragma once

#include "cpu/register.hpp"
#include "definitions.hpp"

class Address {
public:
    Address(u16 location);
    explicit Address(const Register16& from);

    u16 value() const;

    bool in_range(Address low, Address high) const;

    bool operator==(u16 other) const;
    Address operator+(uint other) const;
    Address operator-(uint other) const;
    bool operator<=(const Address& other) const { return addr <= other.addr; }
    bool operator<=(const u16& other) const { return addr <= other; }

private:
    u16 addr = 0x0;
};
