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

    verilate(${TB_NAME}
        TOP_MODULE ${TOP_NAME}
        SOURCES ${_SV_FILES}
        VERILATOR_ARGS
            --sv
            --trace
            -Wall
            -Wno-fatal
            -I${VEMU_SRC_DIR}
            -I${CMAKE_CURRENT_BINARY_DIR}/
    )
endmacro()

add_cpp_tb(test_FIFO ${VEMU_SRC_DIR}/ppu/FIFO.sv)

add_subdirectory(mmu)

