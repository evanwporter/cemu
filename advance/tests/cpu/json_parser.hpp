#include <fstream>
#include <string>
#include <vector>

#include <nlohmann/json.hpp>

struct Reader {
    const uint8_t* p;
    const uint8_t* end;

    Reader(const uint8_t* buf, size_t len) :
        p(buf), end(buf + len) { }

    template <typename T>
    T read() {
        if (p + sizeof(T) > end)
            throw std::runtime_error("decode_test: buffer overrun");
        T v;
        std::memcpy(&v, p, sizeof(T));
        p += sizeof(T);
        return v;
    }

    void skip(size_t n) {
        if (p + n > end)
            throw std::runtime_error("decode_test: buffer overrun");
        p += n;
    }
};

static nlohmann::json decode_state(Reader& r) {
    int32_t full_sz = r.read<int32_t>();
    r.skip(4); // matches Python ptr += 8 total

    uint32_t values[40];
    for (int i = 0; i < 40; i++)
        values[i] = r.read<uint32_t>();

    nlohmann::json state;

    state["R"] = nlohmann::json::array();
    for (int i = 0; i < 16; i++)
        state["R"].push_back(values[i]);

    state["R_fiq"] = nlohmann::json::array();
    for (int i = 0; i < 7; i++)
        state["R_fiq"].push_back(values[i + 16]);

    state["R_svc"] = { values[23], values[24] };
    state["R_abt"] = { values[25], values[26] };
    state["R_irq"] = { values[27], values[28] };
    state["R_und"] = { values[29], values[30] };

    state["CPSR"] = values[31];
    state["SPSR"] = {
        values[32], values[33], values[34], values[35], values[36]
    };

    state["pipeline"] = { values[37], values[38] };
    state["access"] = values[39];

    return state;
}

static nlohmann::json decode_transactions(Reader& r) {
    int32_t full_sz = r.read<int32_t>();
    int32_t mn = r.read<int32_t>();
    int32_t count = r.read<int32_t>();

    if (mn != 3)
        throw std::runtime_error("transactions: bad mn");

    nlohmann::json txs = nlohmann::json::array();

    for (int i = 0; i < count; i++) {
        nlohmann::json tx;
        tx["kind"] = r.read<uint32_t>();
        tx["size"] = r.read<uint32_t>();
        tx["addr"] = r.read<uint32_t>();
        tx["data"] = r.read<uint32_t>();
        tx["cycle"] = r.read<uint32_t>();
        tx["access"] = r.read<uint32_t>();
        txs.push_back(tx);
    }

    return txs;
}

static void decode_opcode(Reader& r, uint32_t& opcode, uint32_t& base_addr) {
    int32_t full_sz = r.read<int32_t>();
    r.skip(4);
    opcode = r.read<uint32_t>();
    base_addr = r.read<uint32_t>();
}

void decode_test(const uint8_t* buf, size_t len, nlohmann::json& out) {
    Reader r(buf, len);

    int32_t full_sz = r.read<int32_t>();

    out = nlohmann::json::object();

    out["initial"] = decode_state(r);
    out["final"] = decode_state(r);
    out["transactions"] = decode_transactions(r);

    uint32_t opcode, base_addr;
    decode_opcode(r, opcode, base_addr);

    out["opcode"] = opcode;
    out["base_addr"] = base_addr;
}

class TestStream {
public:
    explicit TestStream(const std::string& path) :
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

    bool next(nlohmann::json& out) {
        if (tests_left == 0)
            return false;

        int32_t sz;
        in.read(reinterpret_cast<char*>(&sz), 4);

        if (!in)
            throw std::runtime_error("Unexpected EOF");

        std::vector<uint8_t> buf(sz);
        std::memcpy(buf.data(), &sz, 4);
        in.read(reinterpret_cast<char*>(buf.data() + 4), sz - 4);

        decode_test(buf.data(), buf.size(), out);

        tests_left--;
        return true;
    }

private:
    std::ifstream in;
    uint32_t num_tests = 0;
    uint32_t tests_left = 0;
};