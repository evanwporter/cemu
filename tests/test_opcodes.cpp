#include <filesystem>
#include <fstream>
#include <gtest/gtest.h>
#include <nlohmann/json.hpp>

#include "cpu/cpu.hpp"
#include "gameboy.hpp"
#include "mmu/mmu.hpp"
#include "options.hpp"

using json = nlohmann::json;
namespace fs = std::filesystem;

static const fs::path kTestDir = fs::path(TEST_DIR) / "GameboyCPUTests/v2";

static constexpr size_t MEM_SIZE = 0x10000; // 64KB total Game Boy address space
using MemBuffer = std::array<u8, MEM_SIZE>;

json loadJson(const fs::path& path) {
    std::ifstream f(path);
    if (!f.is_open())
        throw std::runtime_error("Failed to open " + path.string());
    json j;
    f >> j;
    return j;
}

void applyRam(Gameboy& gb, const json& ramList) {
    for (const auto& pair : ramList) {
        u16 addr = pair[0].get<u16>();
        u8 val = pair[1].get<u8>();
        gb.mmu->write(addr, val);
    }
}

void verifyRam(const Gameboy& gb, const json& ramList, const std::string& test_name) {
    for (const auto& pair : ramList) {
        u16 addr = pair[0].get<u16>();
        u8 expected = pair[1].get<u8>();
        u8 actual = gb.mmu->read(addr);
        ASSERT_EQ(actual, expected)
            << "RAM mismatch at 0x" << std::hex << addr
            << " during test \"" << test_name << "\"";
    }
}

void verifyRegisters(const CPU& cpu, const json& expected, const std::string& test_name) {
    EXPECT_EQ(cpu.A.value(), expected["a"].get<u8>()) << "Test name: " << test_name;
    EXPECT_EQ(cpu.B.value(), expected["b"].get<u8>()) << "Test name: " << test_name;
    EXPECT_EQ(cpu.C.value(), expected["c"].get<u8>()) << "Test name: " << test_name;
    EXPECT_EQ(cpu.D.value(), expected["d"].get<u8>()) << "Test name: " << test_name;
    EXPECT_EQ(cpu.E.value(), expected["e"].get<u8>()) << "Test name: " << test_name;
    EXPECT_EQ(cpu.F.value(), expected["f"].get<u8>()) << "Test name: " << test_name;
    EXPECT_EQ(cpu.H.value(), expected["h"].get<u8>()) << "Test name: " << test_name;
    EXPECT_EQ(cpu.L.value(), expected["l"].get<u8>()) << "Test name: " << test_name;
    EXPECT_EQ(cpu.PC.value(), expected["pc"].get<u16>() - 1) << "Test name: " << test_name;
    EXPECT_EQ(cpu.SP.value(), expected["sp"].get<u16>()) << "Test name: " << test_name;
}

void applyInitialState(Gameboy& gb, const json& init) {
    auto& cpu = *gb.cpu;

    cpu.A.set(init["a"].get<u8>());
    cpu.B.set(init["b"].get<u8>());
    cpu.C.set(init["c"].get<u8>());
    cpu.D.set(init["d"].get<u8>());
    cpu.E.set(init["e"].get<u8>());
    cpu.F.set(init["f"].get<u8>());
    cpu.H.set(init["h"].get<u8>());
    cpu.L.set(init["l"].get<u8>());
    cpu.PC.set(init["pc"].get<u16>() - 1);
    cpu.SP.set(init["sp"].get<u16>());

    applyRam(gb, init["ram"]);
}

class GameboyCpuFileTest : public ::testing::TestWithParam<fs::path> { };

TEST_P(GameboyCpuFileTest, RunAllCases) {
    auto path = GetParam();
    json testFile = loadJson(path);
    ASSERT_TRUE(testFile.is_array()) << "Invalid JSON test file: " << path;

    for (const auto& testCase : testFile) {
        Options options;
        Gameboy gb(options);

        applyInitialState(gb, testCase["initial"]);

        gb.cpu->tick();

        const std::string test_name = testCase["name"].get<std::string>();

        verifyRegisters(*gb.cpu, testCase["final"], test_name);
        verifyRam(gb, testCase["final"]["ram"], test_name);
    }
}

INSTANTIATE_TEST_SUITE_P(
    CpuTests,
    GameboyCpuFileTest,
    ::testing::ValuesIn([] {
        std::vector<fs::path> files;
        for (auto& entry : fs::directory_iterator(kTestDir)) {
            if (entry.path().extension() == ".json") {
                const auto filename = entry.path().filename().string();
                files.push_back(entry.path());
            }
        }
        return files;
    }()),
    [](const ::testing::TestParamInfo<fs::path>& info) {
        return info.param.stem().string();
    });
