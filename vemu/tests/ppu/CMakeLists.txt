find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

# add_library(test_ppu_l2)
add_executable(test_ppu_l2)

# target_sources(test_ppu_l2
#     PUBLIC
#         ${CMAKE_CURRENT_SOURCE_DIR}/test_ppu_l2.cpp
# )

target_link_libraries(test_ppu_l2 PUBLIC
    SDL2::SDL2
    GameboyHarness
)

target_include_directories(test_ppu_l2
    PUBLIC
        ${VEMU_TESTS_CPP_DIR}
)

get_target_property(VEMU_PACKAGES vemu_rtl INTERFACE_VEMU_PACKAGES)
get_target_property(VEMU_INTERFACES vemu_rtl INTERFACE_VEMU_INTERFACES)

verilate(test_ppu_l2
    PREFIX VMockPPU
    TOP_MODULE MockPPU
    SOURCES
        ${VEMU_PACKAGES}
        ${VEMU_INTERFACES}

        ${CMAKE_CURRENT_SOURCE_DIR}/MockPPU.sv

    VERILATOR_ARGS
        --sv
        --trace
        -Wall
        -Wno-fatal
        -I${VEMU_SRC_DIR}
        -I${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(test_ppu_l2 PUBLIC
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_sources(test_ppu_l2
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/test_ppu_l2.cpp
        ${VEMU_TESTS_CPP_DIR}/util/util.cpp
        ${VEMU_TESTS_CPP_DIR}/verilator_time.cpp
)

target_include_directories(test_ppu_l2
    PUBLIC
        ${VEMU_TESTS_CPP_DIR}
)
