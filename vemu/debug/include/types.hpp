#pragma once

#include "gb.hpp"

#include <cstdint>

namespace debug {
    using u8 = uint8_t;
    using u16 = uint16_t;
    using u32 = uint32_t;
    using u64 = uint64_t;

    struct CPURegisters {
        u16 AF;
        u16 BC;
        u16 DE;
        u16 HL;
        u16 SP;
        u16 PC;
    };

    enum class ExecMode {
        Running,
        Paused,
        StepOnce,
        Stopped
    };

    struct MemorySelection {
        bool valid = false;
        std::vector<u16> addresses;
    };
}