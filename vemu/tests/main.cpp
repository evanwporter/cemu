#include "util/test_config.hpp"
#include <gtest/gtest.h>

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);

    // TODO: Arg parse
    for (int i = 1; i < argc; ++i) {
        if (std::string_view(argv[i]) == "--update") {
            test_config().update = true;
        } else if (std::string_view(argv[i]) == "--gui") {
            test_config().gui = true;
        }
    }

    return RUN_ALL_TESTS();
}
