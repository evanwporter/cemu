#include <filesystem>
#include <gtest/gtest.h>
#include <string>

#include "gb.hpp"

namespace fs = std::filesystem;

static constexpr uint64_t MAX_INSTRUCTIONS = 10'000'000;

class BlarggRomTest : public ::testing::TestWithParam<std::string> { };

TEST_P(BlarggRomTest, Passes) {
    GameboyHarness harness(false, false);

    const fs::path base = fs::path(TEST_DIR) / "gb-test-roms/cpu_instrs/individual";

    bool saw_passed = false;
    bool saw_failed = false;
    uint64_t instr_count = 0;

    bool ok = harness.run(
        base / GetParam(),
        [&](GameboyHarness& h, VGameboy&) {
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

INSTANTIATE_TEST_SUITE_P(
    BlarggCPUInstrs,
    BlarggRomTest,
    ::testing::Values(
        "01-special.gb",
        "02-interrupts.gb",
        "03-op sp,hl.gb",
        "04-op r,imm.gb",
        "05-op rp.gb",
        "06-ld r,r.gb",
        "07-jr,jp,call,ret,rst.gb",
        "08-misc instrs.gb",
        "09-op r,r.gb",
        "10-bit ops.gb",
        "11-op a,(hl).gb"),
    [](const ::testing::TestParamInfo<std::string>& info) {
        std::string name = info.param;

        // GoogleTest test names must be valid C identifiers
        for (char& c : name) {
            if (!std::isalnum(static_cast<unsigned char>(c)))
                c = '_';
        }

        return name;
    });
