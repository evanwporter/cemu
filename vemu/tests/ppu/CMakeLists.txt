find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_library(test_ppu)

target_sources(test_ppu
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/test_ppu.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/test_oam_scan.cpp
    PRIVATE
        ${VEMU_SRC_DIR}/../sim/src/gpu.cpp
)

target_compile_definitions(test_ppu PUBLIC
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_link_libraries(test_ppu PUBLIC
    GTest::gtest_main
    SDL2::SDL2
)

target_include_directories(test_ppu
    PUBLIC
        ${VEMU_TESTS_CPP_DIR}
        ${VEMU_SRC_DIR}/../sim/include
)

get_target_property(VEMU_PACKAGES vemu_rtl INTERFACE_VEMU_PACKAGES)
get_target_property(VEMU_INTERFACES vemu_rtl INTERFACE_VEMU_INTERFACES)

verilate(test_ppu
    PREFIX Vppu_top
    TOP_MODULE ppu_top
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/test_ppu.vlt
        ${VEMU_PACKAGES}
        ${VEMU_INTERFACES}

        ${CMAKE_CURRENT_SOURCE_DIR}/ppu_top.sv

    VERILATOR_ARGS
        --sv
        --trace
        -Wall
        -Wno-fatal
        -I${VEMU_SRC_DIR}
        -I${CMAKE_CURRENT_BINARY_DIR}
)