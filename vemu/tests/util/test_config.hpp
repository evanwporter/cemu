#pragma once

struct TestConfig {
    bool update = false;
    bool gui = false;
};

TestConfig& test_config();
