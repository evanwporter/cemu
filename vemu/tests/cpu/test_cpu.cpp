#include <filesystem>
#include <fstream>
#include <gtest/gtest.h>
#include <nlohmann/json.hpp>

#include <Vcpu_top.h>
#include <Vcpu_top_Bus_if.h>
#include <Vcpu_top___024root.h>
#include <verilated.h>

using namespace std;
namespace fs = std::filesystem;
using json = nlohmann::json;

using u8 = uint8_t;
using u16 = uint16_t;

static vluint64_t timestamp = 0;

double sc_time_stamp() { return timestamp; }

static const fs::path kTestDir = fs::path(TEST_DIR) / "GameboyCPUTests/v2";

inline u16 get_u16(u8 hi, u8 lo) {
    return static_cast<u16>((hi << 8) | lo);
}

inline void set_u16(u8& hi, u8& lo, u16 val) {
    hi = static_cast<u8>(val >> 8);
    lo = static_cast<u8>(val & 0xFF);
}

void tick(Vcpu_top& top, VerilatedContext& ctx) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(5);

    top.clk = 1;
    top.eval();
    ctx.timeInc(5);
}

void apply_ram(Vcpu_top& gb, VerilatedContext& ctx, const json& ramList) {
    for (const auto& pair : ramList) {
        u16 addr = pair[0].get<u16>();
        u8 val = pair[1].get<u8>();
        auto& mem = gb.rootp->cpu_top__DOT__mmu_inst__DOT__memory;
        mem[addr] = val;
    }
}

void verify_ram(Vcpu_top& gb, VerilatedContext& ctx, const json& ramList, const std::string& test_name) {
    for (const auto& pair : ramList) {
        u16 addr = pair[0].get<u16>();
        u8 expected = pair[1].get<u8>();
        auto& mem = gb.rootp->cpu_top__DOT__mmu_inst__DOT__memory;
        u8 actual = mem[addr];
        ASSERT_EQ(actual, expected)
            << "RAM mismatch at 0x" << std::hex << addr
            << " during test \"" << test_name << "\"";
    }
}

void apply_initial_state(Vcpu_top& gb, VerilatedContext& ctx, const json& init) {
    auto* regs = &gb.rootp->cpu_top__DOT__cpu_inst__DOT__regs;

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
    if (init.contains("sp")) {
        u16 sp = init["sp"].get<u16>();
        set_u16(regs->__PVT__sph, regs->__PVT__spl, sp);
    }
    if (init.contains("pc")) {
        u16 pc = init["pc"].get<u16>() - 1;
        set_u16(regs->__PVT__pch, regs->__PVT__pcl, pc);
    }

    apply_ram(gb, ctx, init["ram"]);
}

void verify_registers(const Vcpu_top& top, const json& expected, const std::string& test_name) {
    auto* regs = &top.rootp->cpu_top__DOT__cpu_inst__DOT__regs;

    EXPECT_EQ(regs->__PVT__a, expected["a"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__b, expected["b"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__c, expected["c"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__d, expected["d"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__e, expected["e"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__flags, expected["f"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__h, expected["h"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(regs->__PVT__l, expected["l"].get<u8>()) << "Test: " << test_name;
    EXPECT_EQ(get_u16(regs->__PVT__sph, regs->__PVT__spl), expected["sp"].get<u16>())
        << "Test: " << test_name;
    EXPECT_EQ(get_u16(regs->__PVT__pch, regs->__PVT__pcl), expected["pc"].get<u16>())
        << "Test: " << test_name;
}

class GameboyOpcodeTest : public ::testing::TestWithParam<fs::path> { };

TEST_P(GameboyOpcodeTest, RunAllCases) {
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

        Vcpu_top top(&ctx);

        top.reset = 1;
        for (int i = 0; i < 4; ++i)
            tick(top, ctx);
        top.reset = 0;

        apply_initial_state(top, ctx, testCase["initial"]);

        for (int t = 0; t < 4; ++t)
            tick(top, ctx);

        int max_ticks = 100;
        while (top.rootp->cpu_top__DOT__cpu_inst__DOT__instr_boundary == 0 && max_ticks-- > 0) {
            tick(top, ctx);
        }

        top.rootp->cpu_top__DOT__cpu_inst__DOT__instr_boundary = 0;

        while (top.rootp->cpu_top__DOT__cpu_inst__DOT__instr_boundary == 0 && max_ticks-- > 0) {
            tick(top, ctx);
        }

        ASSERT_GT(max_ticks, 0) << "Timed out waiting for instruction to finish";

        const std::string test_name = testCase["name"].get<std::string>();

        verify_registers(top, testCase["final"], test_name);
        verify_ram(top, ctx, testCase["final"]["ram"], test_name);
        break;
    }
}

INSTANTIATE_TEST_SUITE_P(
    CpuTests,
    GameboyOpcodeTest,
    ::testing::ValuesIn([] {
        std::vector<fs::path> files;
        if (fs::exists(kTestDir)) {
            for (auto& entry : fs::directory_iterator(kTestDir)) {
                if (entry.path().extension() == ".json") {
                    if (entry.path().filename() == "cb.json")
                        continue;
                    files.push_back(entry.path());
                }
            }
        }
        return files;
    }()),
    [](const ::testing::TestParamInfo<fs::path>& info) {
        return info.param.stem().string();
    });
