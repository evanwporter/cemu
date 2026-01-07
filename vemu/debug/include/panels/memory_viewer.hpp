#pragma once

#include "types.hpp"

#include <array>

namespace debug::panels {

    class MemoryViewerPanel {
    public:
        MemoryViewerPanel();

        // Update full 64KB snapshot
        void update(const u16 addr, const u8 value);

        void render();

    private:
        bool visible_ = true;

        std::array<u8, 0x10000> memory_ {};
        bool valid_ = false;

        void render_region(u16 start, u16 end);
    };
}