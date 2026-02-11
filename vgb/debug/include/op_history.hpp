#pragma once

#include "types.hpp"
#include <optional>

namespace debug {

    struct Delta {
        u16 addr;
        u8 value;
    };

    struct Operation {
        u8 opcode;
        CPURegisters cpu_reg;

        std::vector<Delta> history;

        std::vector<u16> read_addresses;
    };

    class OperationHistory {
    public:
        static constexpr size_t MEM_SIZE = 0x10000;
        static constexpr size_t SNAPSHOT_INTERVAL = 256; // tunable

        using Memory = std::array<uint8_t, MEM_SIZE>;

        // Push a new operation
        void push(Operation op);

        // Get memory state after operation `op_index`
        Memory get_state_at(size_t op_index) const;

        // Access latest memory directly
        const Memory& current_memory() const { return current; }

        std::optional<Delta> get_latest_delta() const {
            if (operations.empty() || operations.back().history.empty()) {
                return std::nullopt;
            }

            return operations.back().history.back();
        }

        Operation& back() {
            return operations.back();
        }

        const std::vector<Operation>& get_operations() const {
            return operations;
        }

    private:
        Memory current {}; // always latest state

        std::vector<Operation> operations;

        // Snapshots store full memory
        struct Snapshot {
            size_t op_index;
            Memory memory;
        };

        std::vector<Snapshot> snapshots;
    };
} // namespace debug
