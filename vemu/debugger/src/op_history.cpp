#include "op_history.hpp"

namespace debug {
    void OperationHistory::push(Operation op) {
        // Apply deltas to current memory
        for (const auto& d : op.history) {
            current[d.addr] = d.value;
        }

        std::size_t op_index = operations.size();
        operations.push_back(std::move(op));

        // Take snapshot periodically
        if (op_index % SNAPSHOT_INTERVAL == 0) {
            snapshots.push_back(Snapshot { op_index, current });
        }
    }

    OperationHistory::Memory OperationHistory::get_state_at(size_t op_index) const {
        // Find latest snapshot <= op_index
        const Snapshot* snap = nullptr;
        for (auto it = snapshots.rbegin(); it != snapshots.rend(); ++it) {
            if (it->op_index <= op_index) {
                snap = &*it;
                break;
            }
        }

        Memory mem;
        std::size_t start_op = 0;

        if (snap) {
            mem = snap->memory;
            start_op = snap->op_index;
        } else {
            mem.fill(0);
        }

        // Replay operations forward
        for (std::size_t i = start_op; i <= op_index; ++i) {
            for (const auto& d : operations[i].history) {
                mem[d.addr] = d.value;
            }
        }

        return mem;
    }
} // namespace debug