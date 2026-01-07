#include "op_history.hpp"
#include "types.hpp"

namespace debug::panels {

    class InstructionHistoryPanel {
    public:
        void set_history(const OperationHistory* history);
        std::optional<std::size_t> render(ExecMode exec_mode);

    private:
        const OperationHistory* history_ = nullptr;
        int selected_ = -1;
        std::size_t visible_count_ = 0;
    };
} // namespace debug::panels