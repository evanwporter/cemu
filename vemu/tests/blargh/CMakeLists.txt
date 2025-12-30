find_package(GTest CONFIG REQUIRED)

add_library(test_blargh test_blargh.cpp)

target_link_libraries(test_blargh PRIVATE
    libvemu
    libvemu_harness
    GTest::gtest
    GTest::gtest_main
)

target_compile_definitions(test_blargh PRIVATE
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_include_directories(test_blargh PRIVATE
    PRIVATE
        ${VEMU_TESTS_CPP_DIR}
)