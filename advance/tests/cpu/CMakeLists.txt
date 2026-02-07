find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_library(test_cpu_adv)

target_sources(test_cpu_adv
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/test_cpu.cpp
)

target_link_libraries(test_cpu_adv PRIVATE
    GTest::gtest
    nlohmann_json::nlohmann_json
)

target_include_directories(test_cpu_adv
    PRIVATE
        ${VEMU_ADV_TESTS_CPP_DIR}
)

get_target_property(VEMU_ADV_PACKAGES vemu_adv_rtl INTERFACE_VEMU_PACKAGES)
get_target_property(VEMU_ADV_INTERFACES vemu_adv_rtl INTERFACE_VEMU_INTERFACES)

verilate(test_cpu_adv
    PREFIX Varm_cpu_top
    TOP_MODULE arm_cpu_top
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/test_cpu.vlt
    
        ${VEMU_ADV_PACKAGES}
        ${VEMU_ADV_INTERFACES}

        ${CMAKE_CURRENT_SOURCE_DIR}/arm_cpu_top.sv
        ${VEMU_ADV_SRC_DIR}/cpu/CPU.sv
        ${VEMU_ADV_SRC_DIR}/cpu/ALU.sv
        ${VEMU_ADV_SRC_DIR}/cpu/BarrelShifter.sv
        ${VEMU_ADV_SRC_DIR}/cpu/control_types.sv
        ${VEMU_ADV_SRC_DIR}/cpu/Decoder.sv
        ${VEMU_ADV_SRC_DIR}/cpu/ControlUnit.sv
        ${VEMU_ADV_SRC_DIR}/cpu/interface.sv
        ${VEMU_ADV_SRC_DIR}/cpu/types.sv

    VERILATOR_ARGS
        --sv
        --trace
        -Wall
        -Wno-fatal
        -I${VEMU_ADV_SRC_DIR}
        -I${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(test_cpu_adv PUBLIC
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)
