#pragma once

#include "types.hpp"

namespace debug {
    enum class MemAddrSrc : u8 {
        NONE = 0,
        HL,
        BC,
        DE,
        SP,
        WZ,
        FF_C,
        FF_Z,
        PC,
    };

    struct MemWriteDesc {
        MemAddrSrc addr_src; // where address comes from
        int8_t offset; // +0, +1, -1 (for HL+/HL- etc.)
    };

    constexpr int MAX_MEM_WRITES = 4;

    struct MemWriteInfo {
        uint8_t count;
        MemWriteDesc writes[MAX_MEM_WRITES];
    };
} // namespace debug
