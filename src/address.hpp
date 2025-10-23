#pragma once
#include "types.hpp"
#include <iomanip>
#include <sstream>
#include <string>

class Address {
public:
    constexpr explicit Address(const u16 location) :
        location(location) { }

    constexpr operator u16() const { return location; }

    [[nodiscard]] constexpr u16 value(u16 offset = 0) const {
        return location - offset;
    }

    [[nodiscard]] std::string toString() const {
        std::ostringstream ss;
        ss << '$' << std::uppercase << std::setfill('0') << std::setw(4) << std::hex << static_cast<int>(location);
        return ss.str();
    }

    // Region helpers
    [[nodiscard]] bool inROM0() const { return location <= 0x3FFF; }
    [[nodiscard]] bool inROMX() const { return location >= 0x4000 && location <= 0x7FFF; }
    [[nodiscard]] bool inVRAM() const { return location >= 0x8000 && location <= 0x9FFF; }
    [[nodiscard]] bool inWRAM() const { return location >= 0xC000 && location <= 0xDFFF; }
    [[nodiscard]] bool inOAM() const { return location >= 0xFE00 && location <= 0xFE9F; }
    [[nodiscard]] bool inIO() const { return location >= 0xFF00 && location <= 0xFF7F; }
    [[nodiscard]] bool inHRAM() const { return location >= 0xFF80 && location <= 0xFFFE; }

private:
    u16 location;
};
