#include <fstream>

#include <nlohmann/json.hpp>

class TestStream {
public:
    TestStream(const std::string& path);

    bool next(nlohmann::json& out);

private:
    std::ifstream in;
    uint32_t num_tests = 0;
    uint32_t tests_left = 0;
};