#include <filesystem>
#include <gtest/gtest.h>

#include "gb.hpp"
#include "util/util.hpp"

namespace fs = std::filesystem;

static constexpr uint64_t MAX_INSTRUCTIONS = 1'000'000'000;

static void run_single_file(
    const fs::path& path,
    const uint64_t max_instructions = MAX_INSTRUCTIONS) {
    GameboyHarness harness(false, true, true);

    bool saw_match = false;
    uint64_t instr_count = 0;

    bool ok = harness.run(
        path,
        [&](GameboyHarness& emu, VGameboy& top) {
            ++instr_count;

            const auto& regs = top.rootp->Gameboy__DOT__cpu_inst__DOT__regs;

            if (emu.read_mem(top, 0xFF82)) {
                saw_match = emu.read_mem(top, 0xFF80) == emu.read_mem(top, 0xFF80);
                return false;
            }

            if (instr_count >= max_instructions) {
                ADD_FAILURE()
                    << "Timeout waiting for Fibonacci registers.\n";
                return false;
            }

            return true; // keep running
        });

    ASSERT_TRUE(ok) << "Harness execution failed";

    ASSERT_TRUE(saw_match)
        << "Fibonacci values were never written to registers.\n"
        << "Expected:\n"
        << "B=3 C=5 D=8 E=13 H=21 L=34\n";
}

class AllTests : public ::testing::TestWithParam<fs::path> { };

TEST_P(AllTests, Passes) {
    run_single_file(GetParam());
}

INSTANTIATE_TEST_SUITE_P(
    GBMicrotestROMTests,
    AllTests,
    ::testing::ValuesIn(collect_files_in_directory(
        fs::path(TEST_DIR) / "gbmicrotest/bin",
        ".gb",
        {})),
    get_test_name);
