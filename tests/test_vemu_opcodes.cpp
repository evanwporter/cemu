#include <filesystem>
#include <fstream>
#include <gtest/gtest.h>
#include <nlohmann/json.hpp>

#include "VGameboy.h"
#include "VGameboy___024root.h"
#include "verilated.h"

using namespace std;
namespace fs = std::filesystem;
using json = nlohmann::json;

using u8 = uint8_t;
using u16 = uint16_t;

double sc_time_stamp() { return 0.0; }

static const fs::path kTestDir = fs::path(TEST_DIR) / "GameboyCPUTests/v2";

class GameboyCpuFileTest : public ::testing::TestWithParam<fs::path> { };

TEST_P(GameboyCpuFileTest, RunAllCases_Verilog) {
    const auto path = GetParam();

    ifstream f(path);
    ASSERT_TRUE(f.is_open()) << "Failed to open test file: " << path.string();

    json testFile;
    f >> testFile;
    ASSERT_TRUE(testFile.is_array()) << "Expected JSON array of test cases";

    for (const auto& testCase : testFile) {
        ASSERT_TRUE(testCase.contains("initial"));
        ASSERT_TRUE(testCase.contains("final"));

        VGameboy top;
        top.reset = 1;
        top.clk = 0;
        for (int i = 0; i < 2; ++i) {
            top.clk = !top.clk;
            top.eval();
        }
        top.reset = 0;

        const auto& init = testCase["initial"];
        if (init.contains("a"))
            top.rootp->Gameboy__DOT__cpu__DOT__regs.__PVT__a = init["a"].get<u8>();
        if (init.contains("pc"))
            top.rootp->Gameboy__DOT__cpu__DOT__regs.__PVT__pc = init["pc"].get<u16>();

        for (int t = 0; t < 22; ++t) {
            top.clk = !top.clk;
            top.eval();
        }

        const auto& expected = testCase["final"];
        const std::string test_name = testCase.contains("name")
            ? testCase["name"].get<std::string>()
            : path.filename().string();

        if (expected.contains("a")) {
            EXPECT_EQ(top.rootp->Gameboy__DOT__cpu__DOT__regs.__PVT__a, expected["a"].get<u8>())
                << "Mismatch in register A (" << test_name << ")";
        }
        if (expected.contains("pc")) {
            EXPECT_EQ(top.rootp->Gameboy__DOT__cpu__DOT__regs.__PVT__pc, expected["pc"].get<u16>())
                << "Mismatch in register PC (" << test_name << ")";
        }
    }
}

INSTANTIATE_TEST_SUITE_P(
    CpuTests,
    GameboyCpuFileTest,
    ::testing::ValuesIn([] {
        std::vector<fs::path> files;
        if (fs::exists(kTestDir)) {
            for (auto& entry : fs::directory_iterator(kTestDir)) {
                if (entry.path().extension() == ".json")
                    files.push_back(entry.path());
                break;
            }
        }
        // Fallback: use a single example if directory is empty
        if (files.empty())
            files.push_back("tests/sample.json");
        return files;
    }()),
    [](const ::testing::TestParamInfo<fs::path>& info) {
        return info.param.stem().string(); // test name derived from filename
    });
