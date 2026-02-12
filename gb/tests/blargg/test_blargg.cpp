#include <filesystem>
#include <gtest/gtest.h>
#include <string>

#include "gb.hpp"
#include "util/util.hpp"

namespace fs = std::filesystem;

static constexpr uint64_t MAX_INSTRUCTIONS = 1'000'000'000;

static void run_single_file(const fs::path& path) {
    GameboyHarness harness(false, false, false);

    const fs::path base = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual";

    bool saw_passed = false;
    bool saw_failed = false;
    uint64_t instr_count = 0;

    bool ok = harness.run(
        path,
        [&](GameboyHarness& h, VGameboy& top) {
            ++instr_count;

            const std::string serial = h.get_serial_buffer();

            if (serial.find("Passed") != std::string::npos) {
                saw_passed = true;
                std::cout << "\n";
                return false; // stop execution
            }

            if (serial.find("Failed") != std::string::npos) {
                saw_failed = true;
                std::cout << "\n";
                return false; // stop execution
            }

            if (instr_count >= MAX_INSTRUCTIONS) {
                ADD_FAILURE() << "Timeout waiting for Passed/Failed.\n"
                              << "Serial output so far:\n"
                              << serial;
                return false;
            }

            return true; // keep running
        });

    ASSERT_TRUE(ok) << "Harness execution failed";

    if (saw_failed) {
        FAIL() << "ROM reported failure via serial output";
    }

    ASSERT_TRUE(saw_passed)
        << "ROM did not report Passed\n"
        << "Serial output:\n"
        << harness.get_serial_buffer();
}

class BlarggCPUInstrs : public ::testing::TestWithParam<fs::path> { };

TEST_P(BlarggCPUInstrs, Passes) {
    run_single_file(GetParam());
}

INSTANTIATE_TEST_SUITE_P(
    BlarggROMTests,
    BlarggCPUInstrs,
    ::testing::ValuesIn(collect_files_in_directory(
        fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual",
        ".gb")),
    get_test_name);

TEST(BlarggROMTests, CPUInstrsAll) {
    run_single_file(fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/cpu_instrs.gb");
}

// TEST(BlarggROMTests, InstrsTiming) {
//     run_single_file(fs::path(TEST_DIR) / "gb-test-roms/instr_timing/instr_timing.gb");
// }