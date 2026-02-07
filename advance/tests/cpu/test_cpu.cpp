#include <filesystem>
#include <fstream>
#include <gtest/gtest.h>
#include <nlohmann/json.hpp>

#include <Varm_cpu_top.h>
#include <Varm_cpu_top_Bus_if.h>
#include <Varm_cpu_top___024root.h>
#include <verilated.h>

#include "util/util.hpp"

#include "json_parser.hpp"

using namespace std;
namespace fs = std::filesystem;
using json = nlohmann::json;

using u8 = uint8_t;
using u16 = uint16_t;

static const fs::path kTestDir = fs::path(TEST_DIR) / "GameboyAdvanceCPUTests/v1";

static inline u16 get_u16(u8 hi, u8 lo) {
    return static_cast<u16>((hi << 8) | lo);
}

static inline void set_u16(u8& hi, u8& lo, u16 val) {
    hi = static_cast<u8>(val >> 8);
    lo = static_cast<u8>(val & 0xFF);
}

static inline u8 read_u8(const json& j) {
    if (j.is_string()) {
        return static_cast<u8>(std::stoul(j.get<std::string>(), nullptr, 16));
    }
    return j.get<u8>();
}

static inline u16 read_u16(const json& j) {
    if (j.is_string()) {
        return static_cast<u16>(std::stoul(j.get<std::string>(), nullptr, 16));
    }
    return j.get<u16>();
}

static void tick(Varm_cpu_top& top, VerilatedContext& ctx) {
    std::cout << "PC: " << top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__regs.__PVT__user[15] << std::endl;

    top.clk = 0;
    top.eval();
    ctx.timeInc(5);

    top.clk = 1;
    top.eval();
    ctx.timeInc(5);
}

static void dump_failed_test_to_file(const json& test, const fs::path& source, size_t index) {
    // fs::path out = fs::current_path() / ("failed_test" + source.stem().string() + "_" + std::to_string(index) + ".json");
    fs::path out = fs::current_path() / "failed_test.json";

    std::ofstream f(out);
    if (!f.is_open())
        return;

    f << test.dump(2);
    f << std::endl;

    std::cerr << "Wrote failing test to: " << out.string() << "\n";
}

static void apply_instruction_memory(Varm_cpu_top& top, const json& test) {
    // auto* mmu = top.rootp->arm_cpu_top__DOT__mmu_inst;

    auto& expected = top.rootp->arm_cpu_top__DOT__mmu_inst__DOT__expected;
    auto& txn_index = top.rootp->arm_cpu_top__DOT__mmu_inst__DOT__txn_index;

    top.rootp->arm_cpu_top__DOT__mmu_inst__DOT__expected_count = test["transactions"].size();

    top.rootp->arm_cpu_top__DOT__mmu_inst__DOT__opcode = test["opcode"];
    top.rootp->arm_cpu_top__DOT__mmu_inst__DOT__base_addr = test["base_addr"];

    txn_index = 0;

    for (size_t i = 0; i < test["transactions"].size(); i++) {
        expected[i].__PVT__kind = test["transactions"][i]["kind"];
        expected[i].__PVT__addr = test["transactions"][i]["addr"];
        expected[i].__PVT__data = test["transactions"][i]["data"];
        expected[i].__PVT__size = test["transactions"][i]["size"];
    }
}

static void apply_initial_state(Varm_cpu_top& top, const json& test) {
    auto& regs = top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__regs;

    const auto& init = test["initial"];

    for (int i = 0; i < 15; ++i) {
        regs.__PVT__user[i] = init["R"][i];
    }

    regs.__PVT__user[15] = init["R"][15].get<uint32_t>() - 8;

    regs.__PVT__CPSR = init["CPSR"];

    // // Optional: banked registers
    // if (init.contains("R_fiq")) {
    //     for (int i = 0; i < 7; ++i)
    //         regs.R_fiq[i] = init["R_fiq"][i];
    // }

    apply_instruction_memory(top, test);
}

static void verify_registers(const Varm_cpu_top& top, const json& expected, const std::string& test_name) {
    const auto& regs = top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__regs;

    // R0–R14
    for (int i = 0; i < 15; ++i) {
        ASSERT_EQ(regs.__PVT__user[i], expected["R"][i])
            << "R" << i << " mismatch in test \"" << test_name << "\"";
    }

    // R15 (PC)
    ASSERT_EQ(regs.__PVT__user[15], expected["R"][15].get<uint32_t>())
        << "PC (R15) mismatch in test \"" << test_name << "\"";

    // CPSR
    ASSERT_EQ(regs.__PVT__CPSR, expected["CPSR"])
        << "CPSR mismatch in test \"" << test_name << "\"";
}

static void run_single_test(const json& testCase, const fs::path& source, size_t index) {

    testing::internal::CaptureStdout();
    testing::internal::CaptureStderr();

    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);

    Varm_cpu_top top(&ctx);

    std::cout << "Cycle 0: Resetting CPU" << std::endl;

    // Reset
    top.reset = 1;
    tick(top, ctx);
    top.reset = 0;

    std::cout << "\nCycle 1: Reset Phase 2:" << std::endl;

    apply_initial_state(top, testCase);

    ASSERT_EQ(top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__controlUnit__DOT__flush_cnt, 3);

    // Fetch
    tick(top, ctx);

    std::cout << "\nCycle 2: Start flush" << std::endl;

    // Check if it reset correctly and is now starting a flush.
    ASSERT_TRUE(top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__controlUnit__DOT__flushing);
    ASSERT_EQ(top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__controlUnit__DOT__flush_cnt, 2);

    const auto& IR = top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__IR;

    tick(top, ctx);

    std::cout << "\nCycle 3: Start flush and decode" << std::endl;

    ASSERT_TRUE(top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__controlUnit__DOT__flushing);
    ASSERT_EQ(top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__controlUnit__DOT__flush_cnt, 1);

    // Fetch and Decode
    tick(top, ctx);

    std::cout << "\nCycle 4: Execute" << std::endl;

    // Check if it flushed the reset correctly and is now ready to begin executing the instruction.
    ASSERT_FALSE(top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__controlUnit__DOT__flushing);
    ASSERT_EQ(top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__controlUnit__DOT__flush_cnt, 0);

    tick(top, ctx);

    // ASSERT_EQ(top.rootp->__PVT__arm_cpu_top__DOT__cpu_inst__DOT__decoder_bus->word.__PVT__IR, 0)
    //     << "CPU not in IF1 state after reset flush in test " << index
    //     << " from " << source;

    // int max_ticks = 200;
    // while (top.rootp->arm_cpu_top__DOT__cpu_inst__DOT__controlUnit__DOT__instr_done == 0 && max_ticks-- > 0) {
    //     tick(top, ctx);
    // }

    // ASSERT_GT(max_ticks, 0)
    //     << "Timeout in test " << index
    //     << " from " << source;

    verify_registers(top, testCase["final"], to_string(testCase["opcode"]));

    std::string stdout_output = testing::internal::GetCapturedStdout();
    std::string stderr_output = testing::internal::GetCapturedStderr();

    if (::testing::Test::HasFailure()) {
        std::cerr << "\n==== Captured stdout ====\n"
                  << stdout_output
                  << "\n==== Captured stderr ====\n"
                  << stderr_output
                  << "\n=========================\n";

        dump_failed_test_to_file(testCase, source, index);
    }
}

static void run_single_file(const fs::path& path) {
    TestStream stream(path.string());

    json testCase;
    size_t test_index = 0;

    while (stream.next(testCase)) {
        run_single_test(testCase, path, test_index);
        if (::testing::Test::HasFailure())
            break;
        ++test_index;
    }
}

class GameboyAdvanceOpcodeTest : public ::testing::TestWithParam<fs::path> { };

TEST_P(GameboyAdvanceOpcodeTest, Run) {
    run_single_file(GetParam());
}

INSTANTIATE_TEST_SUITE_P(
    CPUTests,
    GameboyAdvanceOpcodeTest,
    ::testing::ValuesIn(collect_files_in_directory(
        kTestDir,
        ".bin")),
    get_test_name);
