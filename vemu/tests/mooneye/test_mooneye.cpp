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
        [&](GameboyHarness&, VGameboy& top) {
            ++instr_count;

            const auto& regs = top.rootp->Gameboy__DOT__cpu_inst__DOT__regs;

            uint8_t B = regs.__PVT__b;
            uint8_t C = regs.__PVT__c;
            uint8_t D = regs.__PVT__d;
            uint8_t E = regs.__PVT__e;
            uint8_t H = regs.__PVT__h;
            uint8_t L = regs.__PVT__l;

            if (B == 3 && C == 5 && D == 8 && E == 13 && H == 21 && L == 34) {
                saw_match = true;
                return false; // stop execution
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

class Bits : public ::testing::TestWithParam<fs::path> { };

TEST_P(Bits, Passes) {
    run_single_file(GetParam());
}

INSTANTIATE_TEST_SUITE_P(
    MooneyeROMTests,
    Bits,
    ::testing::ValuesIn(collect_files_in_directory(
        fs::path(TEST_DIR) / "mooneye-test-suite/acceptance/bits",
        ".gb",
        { "unused_hwio-GS.gb" })),
    [](const ::testing::TestParamInfo<fs::path>& info) {
        std::string name = info.param.filename().stem().string();

        // GTest test names must be valid C identifiers
        for (char& c : name) {
            if (!std::isalnum(static_cast<unsigned char>(c)))
                c = '_';
        }

        return name;
    });

TEST(MooneyeROMTests, OamDmaBasic) {
    run_single_file(fs::path(TEST_DIR) / "mooneye-test-suite/acceptance/oam_dma/basic.gb", 100'000);
}

TEST(MooneyeROMTests, InstrDAA) {
    run_single_file(fs::path(TEST_DIR) / "mooneye-test-suite/acceptance/instr/daa.gb", 1'000'000);
}

TEST(MooneyeROMTests, DIVWrite) {
    run_single_file(fs::path(TEST_DIR) / "mooneye-test-suite/acceptance/timer/div_write.gb", 1'000'000);
}