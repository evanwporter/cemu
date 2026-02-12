#include "json_parser.hpp"

#include <cstring>
#include <fstream>
#include <stdexcept>

using json = nlohmann::json;

static uint32_t read_u32(const uint8_t*& p, const uint8_t* end) {
    if (p + 4 > end)
        throw std::runtime_error("decode_test: buffer overrun");
    uint32_t v;
    std::memcpy(&v, p, 4);
    p += 4;
    return v;
}

static json decode_state(const uint8_t*& p, const uint8_t* end) {
    read_u32(p, end);
    read_u32(p, end);

    uint32_t v[40];
    for (int i = 0; i < 40; ++i)
        v[i] = read_u32(p, end);

    return {
        { "R", json { v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9], v[10], v[11], v[12], v[13], v[14], v[15] } },
        { "R_fiq", json { v[16], v[17], v[18], v[19], v[20], v[21], v[22] } },
        { "R_svc", { v[23], v[24] } },
        { "R_abt", { v[25], v[26] } },
        { "R_irq", { v[27], v[28] } },
        { "R_und", { v[29], v[30] } },
        { "CPSR", v[31] },
        { "SPSR", { v[32], v[33], v[34], v[35], v[36] } },
        { "pipeline", { v[37], v[38] } },
        { "access", v[39] }
    };
}

static json decode_transactions(const uint8_t*& p, const uint8_t* end) {
    read_u32(p, end);
    if (read_u32(p, end) != 3)
        throw std::runtime_error("transactions: bad mn");

    int count = read_u32(p, end);
    json txs = json::array();

    while (count--) {
        txs.push_back({ { "kind", read_u32(p, end) }, { "size", read_u32(p, end) }, { "addr", read_u32(p, end) }, { "data", read_u32(p, end) }, { "cycle", read_u32(p, end) }, { "access", read_u32(p, end) } });
    }
    return txs;
}

static void decode_test(const uint8_t* buf, size_t len, json& out) {
    const uint8_t* p = buf;
    const uint8_t* e = buf + len;

    read_u32(p, e);
    out["initial"] = decode_state(p, e);
    out["final"] = decode_state(p, e);
    out["transactions"] = decode_transactions(p, e);

    read_u32(p, e);
    read_u32(p, e);
    out["opcode"] = read_u32(p, e);
    out["base_addr"] = read_u32(p, e);
}

TestStream::TestStream(const std::string& path) :
    in(path, std::ios::binary) {
    uint32_t magic;
    in.read((char*)&magic, 4);
    in.read((char*)&num_tests, 4);
    if (!in || magic != 0xD33DBAE0)
        throw std::runtime_error("Bad test file");
    tests_left = num_tests;
}

bool TestStream::next(json& out) {
    if (!tests_left--)
        return false;

    int32_t sz;
    in.read((char*)&sz, 4);
    if (!in || sz < 4)
        throw std::runtime_error("Unexpected EOF");

    std::vector<uint8_t> buf(sz);
    std::memcpy(buf.data(), &sz, 4);
    in.read((char*)buf.data() + 4, sz - 4);
    if (!in)
        throw std::runtime_error("Unexpected EOF");

    decode_test(buf.data(), buf.size(), out);
    return true;
}