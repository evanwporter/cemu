#include "util/test_config.hpp"
#include <gtest/gtest.h>

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);

    for (int i = 1; i < argc; ++i) {
        if (std::string_view(argv[i]) == "--update") {
            test_config().update = true;
        }
    }

    return RUN_ALL_TESTS();
}
