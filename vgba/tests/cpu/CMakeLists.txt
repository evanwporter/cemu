find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_library(test_cpu_adv)

target_sources(test_cpu_adv
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/test_cpu.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/json_parser.cpp
)

target_link_libraries(test_cpu_adv PRIVATE
    GTest::gtest
    nlohmann_json::nlohmann_json
)

target_include_directories(test_cpu_adv
    PRIVATE
        ${VGBA_TESTS_CPP_DIR}
)

get_target_property(VGBA_PACKAGES vemu_adv_rtl INTERFACE_VGB_PACKAGES)
get_target_property(VGBA_INTERFACES vemu_adv_rtl INTERFACE_VGB_INTERFACES)

verilate(test_cpu_adv
    PREFIX Varm_cpu_top
    TOP_MODULE arm_cpu_top
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/test_cpu.vlt
    
        ${VGBA_PACKAGES}
        ${VGBA_INTERFACES}

        ${CMAKE_CURRENT_SOURCE_DIR}/arm_cpu_top.sv
        ${VGBA_SRC_DIR}/cpu/CPU.sv
        ${VGBA_SRC_DIR}/cpu/ALU.sv
        ${VGBA_SRC_DIR}/cpu/BarrelShifter.sv
        ${VGBA_SRC_DIR}/cpu/control_types.sv
        ${VGBA_SRC_DIR}/cpu/Decoder.sv
        ${VGBA_SRC_DIR}/cpu/ControlUnit.sv
        ${VGBA_SRC_DIR}/cpu/interface.sv
        ${VGBA_SRC_DIR}/cpu/types.sv

    VERILATOR_ARGS
        --sv
        --trace
        -Wall
        -Wno-fatal
        -I${VGBA_SRC_DIR}
        -I${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(test_cpu_adv PUBLIC
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)
