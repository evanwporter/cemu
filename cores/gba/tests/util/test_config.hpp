#pragma once

#include <cstddef>
#include <optional>

struct TestConfig {
    std::optional<std::size_t> test_index;
};

TestConfig& test_config();
