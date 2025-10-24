#include <filesystem>
#include <fstream>
#include <gtest/gtest.h>
#include <nlohmann/json.hpp>

#include "cpu/cpu.hpp"
#include "gameboy.hpp"
#include "mmu/mmu.hpp"

using json = nlohmann::json;
namespace fs = std::filesystem;

static const fs::path kTestDir = fs::path(TEST_DIR) / "GameboyCPUTests/v2";

json loadJson(const fs::path& path) {
    std::ifstream f(path);
    if (!f.is_open())
        throw std::runtime_error("Failed to open " + path.string());
    json j;
    f >> j;
    return j;
}

void applyRam(MMU& mmu, const json& ramList) {
    for (const auto& pair : ramList) {
        u16 addr = pair[0].get<u16>();
        u8 val = pair[1].get<u8>();
        mmu.write(addr, val);
    }
}

void verifyRam(const MMU& mmu, const json& ramList, const std::string& opcodeName) {
    for (const auto& pair : ramList) {
        u16 addr = pair[0].get<u16>();
        u8 expected = pair[1].get<u8>();
        u8 actual = mmu.read(addr);
        ASSERT_EQ(actual, expected)
            << "RAM mismatch at 0x" << std::hex << addr
            << " during opcode \"" << opcodeName << "\"";
    }
}

void verifyRegisters(const CPU& cpu, const json& expected, const std::string& opcodeName) {
    EXPECT_EQ(cpu.A.get(), expected["a"].get<u8>()) << "Test name: " << opcodeName;
    EXPECT_EQ(cpu.B.get(), expected["b"].get<u8>()) << "Test name: " << opcodeName;
    EXPECT_EQ(cpu.C.get(), expected["c"].get<u8>()) << "Test name: " << opcodeName;
    EXPECT_EQ(cpu.D.get(), expected["d"].get<u8>()) << "Test name: " << opcodeName;
    EXPECT_EQ(cpu.E.get(), expected["e"].get<u8>()) << "Test name: " << opcodeName;
    EXPECT_EQ(cpu.F.get(), expected["f"].get<u8>()) << "Test name: " << opcodeName;
    EXPECT_EQ(cpu.H.get(), expected["h"].get<u8>()) << "Test name: " << opcodeName;
    EXPECT_EQ(cpu.L.get(), expected["l"].get<u8>()) << "Test name: " << opcodeName;
    EXPECT_EQ(cpu.PC.get(), expected["pc"].get<u16>() - 1) << "Test name: " << opcodeName;
    EXPECT_EQ(cpu.SP.get(), expected["sp"].get<u16>()) << "Test name: " << opcodeName;
}

void applyInitialState(GameBoy& gb, const json& init) {
    auto& cpu = *gb.cpu;
    auto& mmu = *gb.mmu;

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

    applyRam(mmu, init["ram"]);
}

class GameboyCpuFileTest : public ::testing::TestWithParam<fs::path> { };

TEST_P(GameboyCpuFileTest, RunAllCases) {
    auto path = GetParam();
    json testFile = loadJson(path);
    ASSERT_TRUE(testFile.is_array()) << "Invalid JSON test file: " << path;

    for (const auto& testCase : testFile) {
        GameBoy gb;

        applyInitialState(gb, testCase["initial"]);

        gb.cpu->step();

        const std::string opcodeName = testCase["name"].get<std::string>();

        verifyRegisters(*gb.cpu, testCase["final"], opcodeName);
        verifyRam(*gb.mmu, testCase["final"]["ram"], opcodeName);
    }
}

INSTANTIATE_TEST_SUITE_P(
    CpuTests,
    GameboyCpuFileTest,
    ::testing::ValuesIn([] {
        std::vector<fs::path> files;
        int tmp = 0;
        for (auto& entry : fs::directory_iterator(kTestDir)) {
            if (entry.path().extension() == ".json") {
                files.push_back(entry.path());
                // break;
                tmp++;
                if (tmp == 191)
                    break;
            }
        }
        return files;
    }()),
    [](const ::testing::TestParamInfo<fs::path>& info) {
        return info.param.stem().string();
    });
