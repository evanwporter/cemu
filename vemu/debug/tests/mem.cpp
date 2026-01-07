#include <cstdint>
#include <fstream>
#include <gtest/gtest.h>
#include <nlohmann/json.hpp>
#include <optional>
#include <unordered_map>

#include "instruction_access.hpp"

#include <verilated.h>

using u8 = uint8_t;
using u16 = uint16_t;

namespace fs = std::filesystem;

struct JsonAccess {
    std::string type; // "read" | "write"
    std::string access; // "immediate" | "address" | "register"
    std::string addr; // "PC", "HL", "a16", etc
    int offset; // signed
};

struct MemoryAccess {
    uint16_t address;
    bool read;
    bool write;
};

struct CPUState {
    uint16_t AF, BC, DE, HL;
    uint16_t SP, PC;

    uint8_t A() const { return AF >> 8; }
    uint8_t F() const { return AF & 0xFF; }
};

using InstructionTable = std::unordered_map<uint8_t, std::vector<JsonAccess>>;

InstructionTable load_instruction_accesses(const fs::path& path) {
    std::ifstream f(path);
    nlohmann::json j;
    f >> j;

    InstructionTable table;

    for (auto& [opcode_hex, instr] : j.items()) {
        uint8_t opcode = std::stoi(opcode_hex, nullptr, 16);
        std::vector<JsonAccess> accesses;

        for (const auto& a : instr["accesses"]) {
            accesses.push_back({ a["type"], a["access"], a["addr"], a["offset"] });
        }

        table[opcode] = std::move(accesses);
    }

    return table;
}

uint16_t resolve_address(
    const JsonAccess& a,
    const CPUState& cpu) {

    uint16_t base = 0;

    if (a.addr == "PC")
        base = cpu.PC;
    else if (a.addr == "SP")
        base = cpu.SP;
    else if (a.addr == "HL")
        base = cpu.HL;
    else if (a.addr == "BC")
        base = cpu.BC;
    else if (a.addr == "DE")
        base = cpu.DE;
    else
        return 0;

    // Immediate: no dereference
    if (a.access == "immediate")
        return base + a.offset;

    // Address: dereference (16-bit little endian)
    if (a.access == "address") {
        uint16_t lo = read_memory(base + a.offset);
        uint16_t hi = read_memory(base + a.offset + 1);
        return (hi << 8) | lo;
    }

    return 0;
}

std::vector<MemoryAccess> get_memory_accesses(
    uint8_t opcode,
    const CPUState& cpu,
    const InstructionTable& table) {

    std::vector<MemoryAccess> out;
    const auto& accesses = table.at(opcode);

    for (const auto& a : accesses) {
        if (a.access == "register")
            continue; // ignore pure register effects

        uint16_t addr = resolve_address(a, cpu);

        // if (a.access == "address")
        //     continue; // ignore immediate data fetches

        out.push_back({ addr, a.type == "read", a.type == "write" });
    }

    return out;
}

/// Global Verilator time variable
vluint64_t g_verilator_time = 0;

double sc_time_stamp() {
    return static_cast<double>(g_verilator_time);
}

static std::unordered_map<uint16_t, uint8_t> mock_ram;

uint8_t read_memory(uint16_t addr) {
    return mock_ram[addr];
}

std::optional<uint16_t> resolve_operand_address(
    const char* name,
    const CPUState& cpu,
    uint16_t pc,
    uint8_t immediate_offset) {
    // Register indirects
    if (strcmp(name, "BC") == 0)
        return cpu.BC;
    if (strcmp(name, "DE") == 0)
        return cpu.DE;
    if (strcmp(name, "HL") == 0)
        return cpu.HL;

    // Absolute address immediate (a16)
    if (strcmp(name, "a16") == 0) {
        uint16_t lo = read_memory(pc + immediate_offset);
        uint16_t hi = read_memory(pc + immediate_offset + 1);
        return (hi << 8) | lo;
    }

    // Stack pointer memory
    if (strcmp(name, "SP") == 0)
        return cpu.SP;

    return std::nullopt;
}

std::vector<MemoryAccess> get_memory_accesses(
    uint8_t opcode,
    const CPUState& cpu) {

    std::vector<MemoryAccess> accesses;

    const InstructionAccess& instr = instruction_access[opcode];

    uint16_t pc = cpu.PC;
    uint8_t imm_offset = 1; // first byte after opcode

    for (int i = 0; i < instr.immediate_reads; i++) {
        accesses.push_back({
            static_cast<uint16_t>(pc + imm_offset),
            true, // read
            false // write
        });
        imm_offset++;
    }

    uint8_t operand_imm_offset = 1;

    for (const auto& op : instr.operands) {
        auto addr = resolve_operand_address(
            op.name,
            cpu,
            pc,
            operand_imm_offset);

        if (addr.has_value()) {
            accesses.push_back({ *addr, op.read, op.write });
        }

        // Advance offset for operands that consume immediates
        if (strcmp(op.name, "n8") == 0 || strcmp(op.name, "r8") == 0)
            operand_imm_offset += 1;
        else if (strcmp(op.name, "n16") == 0 || strcmp(op.name, "a16") == 0)
            operand_imm_offset += 2;
    }

    return accesses;
}

CPUState make_cpu(const nlohmann::json& j) {
    CPUState cpu {};
    cpu.AF = (j["a"].get<uint8_t>() << 8) | j["f"].get<uint8_t>();
    cpu.BC = (j["b"].get<uint8_t>() << 8) | j["c"].get<uint8_t>();
    cpu.DE = (j["d"].get<uint8_t>() << 8) | j["e"].get<uint8_t>();
    cpu.HL = (j["h"].get<uint8_t>() << 8) | j["l"].get<uint8_t>();
    cpu.PC = j["pc"];
    cpu.SP = j["sp"];
    return cpu;
}

struct ExpectedAccess {
    uint16_t address;
    bool read;
    bool write;
};

std::vector<ExpectedAccess>
parse_expected_cycles(const nlohmann::json& cycles) {
    std::vector<ExpectedAccess> out;

    for (const auto& c : cycles) {
        uint16_t addr = c[0];
        std::string type = c[2];

        out.push_back({ addr, type == "read", type == "write" });
    }
    return out;
}

std::vector<nlohmann::json> load_tests(const char* path) {
    std::ifstream f(path);
    nlohmann::json j;
    f >> j;

    std::vector<nlohmann::json> out;
    for (const auto& test : j) {
        out.push_back(test);
    }
    return out;
}

static void apply_initial_state(const nlohmann::json& init, CPUState& cpu) {
    cpu.AF = (init["a"].get<u8>() << 8) | init["f"].get<u8>();
    cpu.BC = (init["b"].get<u8>() << 8) | init["c"].get<u8>();
    cpu.DE = (init["d"].get<u8>() << 8) | init["e"].get<u8>();
    cpu.HL = (init["h"].get<u8>() << 8) | init["l"].get<u8>();
    cpu.SP = init["sp"];
    cpu.PC = init["pc"];

    mock_ram.clear();
    for (const auto& cell : init["ram"]) {
        mock_ram[cell[0]] = cell[1];
    }
}

static void verify_memory_accesses(
    const std::vector<MemoryAccess>& actual,
    const std::vector<nlohmann::json>& expected,
    const std::string& test_name) {

    for (size_t i = 0; i < actual.size(); ++i) {

        u16 addr = expected[i][0];
        std::string type = expected[i][2];

        EXPECT_EQ(actual[i].address, addr)
            << "Address mismatch in " << test_name;
        EXPECT_EQ(actual[i].read, type == "read")
            << "Read flag mismatch in " << test_name;
        EXPECT_EQ(actual[i].write, type == "write")
            << "Write flag mismatch in " << test_name;
    }
}

static void run_single_file(const fs::path& path) {
    std::ifstream f(path);
    ASSERT_TRUE(f.is_open()) << "Failed to open test file: " << path;

    nlohmann::json testFile;
    f >> testFile;
    ASSERT_TRUE(testFile.is_array());

    for (const auto& testCase : testFile) {
        CPUState cpu {};
        apply_initial_state(testCase["initial"], cpu);

        const std::string test_name = testCase["name"];

        u8 opcode = static_cast<u8>(
            std::stoi(test_name.substr(0, 2), nullptr, 16));

        static InstructionTable instr_table = load_instruction_accesses("C:\\Users\\evanw\\cemu\\scripts\\opcode_read_written.json");

        auto accesses = get_memory_accesses(opcode, cpu, instr_table);

        std::vector<nlohmann::json> cycles;
        for (const auto& c : testCase["cycles"]) {
            if (!c.is_null())
                cycles.push_back(c);
        }

        verify_memory_accesses(
            accesses,
            cycles,
            test_name);

        if (::testing::Test::HasFailure())
            break;
    }
}

class MemoryAccessTest : public ::testing::TestWithParam<fs::path> { };

TEST_P(MemoryAccessTest, Run) {
    run_single_file(GetParam());
}

static const fs::path kMemoryTestDir = fs::path(TEST_DIR) / "GameboyCPUTests/v2";

std::vector<fs::path> collect_files_in_directory(const fs::path& dir, const std::string& extension, std::unordered_set<std::string> exclude = {}) {
    std::vector<fs::path> roms;

    if (!fs::exists(dir) || !fs::is_directory(dir))
        return roms;

    for (const auto& entry : fs::directory_iterator(dir)) {
        if (!entry.is_regular_file())
            continue;

        if (entry.path().extension() == extension) {
            if (exclude.find(entry.path().filename().string()) != exclude.end())
                continue;
            roms.push_back(entry.path());
        }
    }

    std::sort(roms.begin(), roms.end());
    return roms;
}

INSTANTIATE_TEST_SUITE_P(MemoryAccess, MemoryAccessTest, ::testing::ValuesIn(collect_files_in_directory(kMemoryTestDir, ".json")), [](const ::testing::TestParamInfo<fs::path>& info) {
    return info.param.stem().string();
});
