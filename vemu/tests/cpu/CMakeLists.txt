find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_executable(test_cpu
    test_cpu.cpp
)

target_link_libraries(test_cpu
    GTest::gtest
    GTest::gtest_main
    nlohmann_json::nlohmann_json
)

target_include_directories(test_cpu
    PRIVATE
        ${VEMU_TESTS_CPP_DIR}
)
verilate(test_cpu
    TOP_MODULE cpu_top
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_top.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/MockMMU.sv
        ${VEMU_SRC_DIR}/cpu/CPU.sv
    VERILATOR_ARGS
        --sv
        --trace
        -Wall
        -Wno-fatal
        -I${VEMU_SRC_DIR}
        -I${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(test_cpu PRIVATE
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)