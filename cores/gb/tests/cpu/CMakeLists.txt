find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_library(test_cpu)

target_sources(test_cpu
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/test_cpu.cpp
)

target_link_libraries(test_cpu PRIVATE
    GTest::gtest
    nlohmann_json::nlohmann_json
)

target_include_directories(test_cpu
    PRIVATE
        ${GB_TESTS_CPP_DIR}
)

get_target_property(GB_PACKAGES gb_rtl INTERFACE_GB_PACKAGES)
get_target_property(GB_INTERFACES gb_rtl INTERFACE_GB_INTERFACES)

verilate(test_cpu
    PREFIX Vcpu_top
    TOP_MODULE cpu_top
    SOURCES
        ${GB_PACKAGES}
        ${GB_INTERFACES}

        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_top.sv

    VERILATOR_ARGS
        --sv
        --trace
        -Wall
        -Wno-fatal
        -I${GB_INCLUDE_DIR}
        -I${GB_SRC_DIR}
        -I${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(test_cpu PUBLIC
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)
