#include "json_parser.hpp"

#include <cstring>
#include <fstream>
#include <stdexcept>
#include <vector>

static uint32_t read_u32(const uint8_t*& p, const uint8_t* end) {
    if (p + 4 > end)
        throw std::runtime_error("decode_test: buffer overrun");
    uint32_t v;
    std::memcpy(&v, p, 4);
    p += 4;
    return v;
}

static int32_t read_i32(const uint8_t*& p, const uint8_t* end) {
    return static_cast<int32_t>(read_u32(p, end));
}

static nlohmann::json decode_state(const uint8_t*& p, const uint8_t* end) {
    read_i32(p, end); // full_sz
    read_u32(p, end); // padding

    uint32_t v[40];
    for (auto& x : v)
        x = read_u32(p, end);

    nlohmann::json s;
    s["R"] = nlohmann::json::array({ v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9], v[10], v[11], v[12], v[13], v[14], v[15] });
    s["R_fiq"] = nlohmann::json::array({ v[16], v[17], v[18], v[19], v[20], v[21], v[22] });
    s["R_svc"] = { v[23], v[24] };
    s["R_abt"] = { v[25], v[26] };
    s["R_irq"] = { v[27], v[28] };
    s["R_und"] = { v[29], v[30] };
    s["CPSR"] = v[31];
    s["SPSR"] = { v[32], v[33], v[34], v[35], v[36] };
    s["pipeline"] = { v[37], v[38] };
    s["access"] = v[39];

    return s;
}

static nlohmann::json decode_transactions(const uint8_t*& p, const uint8_t* end) {
    read_i32(p, end); // full_sz
    if (read_i32(p, end) != 3) // mn
        throw std::runtime_error("transactions: bad mn");

    int32_t count = read_i32(p, end);

    nlohmann::json txs = nlohmann::json::array();
    for (int i = 0; i < count; i++) {
        txs.push_back({
            { "kind", read_u32(p, end) },
            { "size", read_u32(p, end) },
            { "addr", read_u32(p, end) },
            { "data", read_u32(p, end) },
            { "cycle", read_u32(p, end) },
            { "access", read_u32(p, end) },
        });
    }
    return txs;
}

static void decode_test(const uint8_t* buf, size_t len, nlohmann::json& out) {
    const uint8_t* p = buf;
    const uint8_t* end = buf + len;

    read_i32(p, end); // full_sz

    out["initial"] = decode_state(p, end);
    out["final"] = decode_state(p, end);
    out["transactions"] = decode_transactions(p, end);

    read_i32(p, end); // opcode block size
    read_u32(p, end); // padding

    out["opcode"] = read_u32(p, end);
    out["base_addr"] = read_u32(p, end);
}

TestStream::TestStream(const std::string& path) :
    in(path, std::ios::binary) {
    if (!in)
        throw std::runtime_error("Failed to open test file");

    uint32_t magic;
    in.read(reinterpret_cast<char*>(&magic), 4);
    in.read(reinterpret_cast<char*>(&num_tests), 4);

    if (magic != 0xD33DBAE0)
        throw std::runtime_error("Bad test file");

    tests_left = num_tests;
}

bool TestStream::next(nlohmann::json& out) {
    if (tests_left == 0)
        return false;

    // Read size-prefixed test blob
    int32_t sz;
    in.read(reinterpret_cast<char*>(&sz), 4);
    if (!in || sz < 4)
        throw std::runtime_error("Unexpected EOF");

    std::vector<uint8_t> buf(sz);
    std::memcpy(buf.data(), &sz, 4);
    in.read(reinterpret_cast<char*>(buf.data() + 4), sz - 4);

    if (!in)
        throw std::runtime_error("Unexpected EOF");

    decode_test(buf.data(), buf.size(), out);

    --tests_left;
    return true;
}