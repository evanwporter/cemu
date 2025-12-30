find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

set(VEMU_TESTS_CPP_DIR ${CMAKE_CURRENT_SOURCE_DIR})

macro(add_cpp_tb TB_NAME SV_FILE)
    # If SV_FILE is a list, CMake expands it into multiple arguments.
    # We capture them all using ARGN-style list behavior.
    set(_SV_FILES ${SV_FILE})

    # Get the first file to derive TOP_NAME
    list(GET _SV_FILES 0 _FIRST_SV_FILE)

    get_filename_component(TOP_NAME "${_FIRST_SV_FILE}" NAME_WE)

    get_filename_component(TOP_NAME "${SV_FILE}" NAME_WE)

    add_executable(${TB_NAME}
        ${TB_NAME}.cpp
    )

    find_package(GTest CONFIG REQUIRED)

    target_link_libraries(${TB_NAME}
        GTest::gtest
        GTest::gtest_main
    )

    target_include_directories(${TB_NAME}
        PRIVATE
            ${VEMU_TESTS_CPP_DIR}
    )
    verilate(${TB_NAME}
        TOP_MODULE ${TOP_NAME}
        VERILATOR_ARGS
            --sv
            --trace
            -Wall
            -Wno-fatal
            -I${VEMU_SRC_DIR}
            -I${CMAKE_CURRENT_BINARY_DIR}/
            -f ${GENERATED_F}
    )
endmacro()

# add_subdirectory(fetcher)
# add_subdirectory(mmu)
# add_subdirectory(fifo)
add_subdirectory(cpu)
add_subdirectory(blargh)
# add_subdirectory(cartridge)
# add_subdirectory(integration)

add_executable(test_vemu
    ${CMAKE_CURRENT_SOURCE_DIR}/verilator_time.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/cpu/test_cpu.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/blargh/test_blargh.cpp
)

target_link_libraries(test_vemu
    PRIVATE
        test_cpu
        # test_blargh
        libvemu
        libvemu_harness
)

target_compile_definitions(test_vemu PRIVATE
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_include_directories(test_vemu PRIVATE
    ${VEMU_TESTS_CPP_DIR}
)

