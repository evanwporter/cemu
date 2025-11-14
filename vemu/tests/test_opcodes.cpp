#include <filesystem>
#include <fstream>
#include <gtest/gtest.h>
#include <nlohmann/json.hpp>

#include <VGameboy.h>
#include <VGameboy_Bus_if.h>
#include <VGameboy___024root.h>
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

void tick(VGameboy& top, VerilatedContext& ctx) {
    top.clk = 0;
    top.eval();
    ctx.timeInc(5);

    top.clk = 1;
    top.eval();
    ctx.timeInc(5);
}

void write8(VGameboy& top, VerilatedContext& ctx, uint16_t addr, uint8_t val) {
    auto* rootp = top.rootp;
    auto* bus = rootp->__PVT__Gameboy__DOT__cpu_bus;

    bus->addr = addr;
    bus->wdata = val;
    bus->write_en = 1;
    bus->read_en = 0;

    top.eval();

    tick(top, ctx);

    bus->write_en = 0;
    top.eval();
}

uint8_t read8(VGameboy& top, VerilatedContext& ctx, uint16_t addr) {
    auto* rootp = top.rootp;
    auto* bus = rootp->__PVT__Gameboy__DOT__cpu_bus;

    // drive read request
    bus->addr = addr;
    bus->write_en = 0;
    bus->read_en = 1;

    top.eval(); // settle combinational MMU logic
    tick(top, ctx);

    uint8_t result = bus->rdata;

    // release bus
    bus->read_en = 0;
    top.eval();

    return result;
}

void apply_ram(VGameboy& gb, VerilatedContext& ctx, const json& ramList) {
    for (const auto& pair : ramList) {
        u16 addr = pair[0].get<u16>();
        u8 val = pair[1].get<u8>();
        write8(gb, ctx, addr, val);
    }
}

void verify_ram(VGameboy& gb, VerilatedContext& ctx, const json& ramList, const std::string& test_name) {
    for (const auto& pair : ramList) {
        u16 addr = pair[0].get<u16>();
        u8 expected = pair[1].get<u8>();
        u8 actual = read8(gb, ctx, addr);
        ASSERT_EQ(actual, expected)
            << "RAM mismatch at 0x" << std::hex << addr
            << " during test \"" << test_name << "\"";
    }
}

void apply_initial_state(VGameboy& gb, VerilatedContext& ctx, const json& init) {
    auto* regs = &gb.rootp->Gameboy__DOT__cpu_inst__DOT__regs;

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

void verify_registers(const VGameboy& top, const json& expected, const std::string& test_name) {
    auto* regs = &top.rootp->Gameboy__DOT__cpu_inst__DOT__regs;

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

        apply_initial_state(top, ctx, testCase["initial"]);

        for (int t = 0; t < 4; ++t)
            tick(top, ctx);

        int max_ticks = 100;
        while (top.rootp->Gameboy__DOT__cpu_inst__DOT__instr_count < 2 && max_ticks-- > 0) {
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
    GameboyCpuFileTest,
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
