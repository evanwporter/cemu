find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_library(test_ppu)

target_sources(test_ppu
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/test_ppu.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/test_oam_scan.cpp
    PRIVATE
        ${GB_SRC_DIR}/../sim/src/gpu.cpp
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
        ${GB_TESTS_CPP_DIR}
        ${GB_SRC_DIR}/../sim/include
)

get_target_property(GB_PACKAGES gb_rtl INTERFACE_GB_PACKAGES)
get_target_property(GB_INTERFACES gb_rtl INTERFACE_GB_INTERFACES)

verilate(test_ppu
    PREFIX Vppu_top
    TOP_MODULE ppu_top
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/test_ppu.vlt
        ${GB_PACKAGES}
        ${GB_INTERFACES}

        ${CMAKE_CURRENT_SOURCE_DIR}/ppu_top.sv

    VERILATOR_ARGS
        --sv
        --trace
        -Wall
        -Wno-fatal
        -I${GB_INCLUDE_DIR}
        -I${GB_SRC_DIR}
        -I${CMAKE_CURRENT_BINARY_DIR}
)