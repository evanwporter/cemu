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

void apply_ram(VGameboy& gb, const json& ramList) {
    for (const auto& pair : ramList) {
        u16 addr = pair[0].get<u16>();
        u8 val = pair[1].get<u8>();
        gb.rootp->Gameboy__DOT__mmu__DOT__memory[addr] = val;
    }
}

void verify_ram(const VGameboy& gb, const json& ramList, const std::string& test_name) {
    for (const auto& pair : ramList) {
        u16 addr = pair[0].get<u16>();
        u8 expected = pair[1].get<u8>();
        u8 actual = gb.rootp->Gameboy__DOT__mmu__DOT__memory[addr];
        ASSERT_EQ(actual, expected)
            << "RAM mismatch at 0x" << std::hex << addr
            << " during test \"" << test_name << "\"";
    }
}

void apply_initial_state(VGameboy& gb, const json& init) {
    auto* regs = &gb.rootp->Gameboy__DOT__cpu__DOT__regs;

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
        regs->__PVT__pc = init["pc"].get<u16>() - 1;

    apply_ram(gb, init["ram"]);
}

void verify_registers(const VGameboy& top, const json& expected, const std::string& test_name) {
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

TEST_P(GameboyCpuFileTest, RunAllCases) {
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

        apply_initial_state(top, testCase["initial"]);

        for (int t = 0; t < 16; ++t)
            tick(top, ctx);

        const std::string test_name = testCase["name"].get<std::string>();

        verify_registers(top, testCase["final"], test_name);
        verify_ram(top, testCase["final"]["ram"], test_name);
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
