macro(add_cpp_tb TB_NAME SV_FILE)
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
        SOURCES ${SV_FILE}
        VERILATOR_ARGS
            --sv
            --trace
            -Wall
            -Wno-fatal
            -I${VEMU_SRC_DIR}
    )

    include(GoogleTest)
    gtest_discover_tests(${TB_NAME})
endmacro()

add_cpp_tb(test_FIFO ${VEMU_SRC_DIR}/ppu/FIFO.sv)
