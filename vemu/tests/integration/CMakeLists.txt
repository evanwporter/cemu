find_package(GTest CONFIG REQUIRED)

add_executable(test_integration test_integration.cpp)

target_link_libraries(test_integration
    libcemu
    libvemu
    GTest::gtest
    GTest::gtest_main
)

target_compile_definitions(test_integration PRIVATE
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_include_directories(test_integration
    PRIVATE
        ${VEMU_TESTS_CPP_DIR}
)