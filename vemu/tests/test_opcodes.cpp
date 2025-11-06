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

static vluint64_t timestamp = 0;

double sc_time_stamp() { return timestamp; }

static const fs::path kTestDir = fs::path(TEST_DIR) / "GameboyCPUTests/v2";

void tick(VGameboy& top, VerilatedContext& ctx) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(5);

    top.clk = 1;
    top.eval();
    ctx.timeInc(5);
}

void applyInitialState(VGameboy& top, const json& init) {
    auto* regs = &top.rootp->Gameboy__DOT__cpu__DOT__regs;

    if (init.contains("a"))
        regs->__PVT__a = init["a"].get<u8>();
    if (init.contains("b"))
        regs->__PVT__b = init["b"].get<u8>();
    if (init.contains("c"))
        regs->__PVT__c = init["c"].get<u8>();
    if (init.contains("d"))
        regs->__PVT__d = init["d"].get<u8>();
    if (init.contains("e"))
        regs->__PVT__e = init["e"].get<u8>();
    if (init.contains("f"))
        regs->__PVT__flags = init["f"].get<u8>();
    if (init.contains("h"))
        regs->__PVT__h = init["h"].get<u8>();
    if (init.contains("l"))
        regs->__PVT__l = init["l"].get<u8>();
    if (init.contains("sp"))
        regs->__PVT__sp = init["sp"].get<u16>();
    if (init.contains("pc"))
        regs->__PVT__pc = init["pc"].get<u16>() - 1; // match C++ version
}

void verifyRegisters(const VGameboy& top, const json& expected, const std::string& test_name) {
    auto* regs = &top.rootp->Gameboy__DOT__cpu__DOT__regs;

    EXPECT_EQ(regs->__PVT__a, expected["a"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__b, expected["b"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__c, expected["c"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__d, expected["d"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__e, expected["e"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__flags, expected["f"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__h, expected["h"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__l, expected["l"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__sp, expected["sp"].get<u16>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__pc, expected["pc"].get<u16>()) << "Test: " << test_name;
}

class GameboyCpuFileTest : public ::testing::TestWithParam<fs::path> { };

TEST_P(GameboyCpuFileTest, RunAllCases_Verilog) {
    const auto path = GetParam();
    std::ifstream f(path);
    ASSERT_TRUE(f.is_open()) << "Failed to open test file: " << path;

    json testFile;
    f >> testFile;
    ASSERT_TRUE(testFile.is_array());

    for (const auto& testCase : testFile) {
        VerilatedContext ctx;
        ctx.debug(0);
        ctx.time(0);

        VGameboy top(&ctx);

        top.reset = 1;
        for (int i = 0; i < 4; ++i)
            tick(top, ctx);
        top.reset = 0;

        applyInitialState(top, testCase["initial"]);

        for (int t = 0; t < 16; ++t)
            tick(top, ctx);

        verifyRegisters(top, testCase["final"], testCase["name"]);
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
        return files;
    }()),
    [](const ::testing::TestParamInfo<fs::path>& info) {
        return info.param.stem().string();
    });
