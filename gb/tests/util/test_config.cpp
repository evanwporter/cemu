// test_config.cpp
#include "util/test_config.hpp"

TestConfig& test_config() {
    static TestConfig cfg;
    return cfg;
}
