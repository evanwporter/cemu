find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_library(test_cpu)

target_link_libraries(test_cpu
    GTest::gtest
    GTest::gtest_main
    nlohmann_json::nlohmann_json
)

target_include_directories(test_cpu
    PRIVATE
        ${VEMU_TESTS_CPP_DIR}
)

get_target_property(VEMU_PACKAGES vemu_rtl INTERFACE_VEMU_PACKAGES)
get_target_property(VEMU_INTERFACES vemu_rtl INTERFACE_VEMU_INTERFACES)

verilate(test_cpu
    PREFIX Vcpu_top
    TOP_MODULE cpu_top
    SOURCES
        # ${VEMU_SRC_DIR}/cpu/types.sv
        # ${VEMU_SRC_DIR}/ppu/types.sv

        # ${VEMU_SRC_DIR}/mmu/addresses.sv
        # ${VEMU_SRC_DIR}/mmu/interface.sv

        ${VEMU_PACKAGES}
        ${VEMU_INTERFACES}

        ${VEMU_SRC_DIR}/cpu/CPU.sv

        ${CMAKE_CURRENT_SOURCE_DIR}/cpu_top.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/MockMMU.sv

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