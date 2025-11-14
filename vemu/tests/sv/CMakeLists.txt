set(CMAKE_CXX_STANDARD 23)

include(CheckCXXCompilerFlag)
enable_testing()

set(TESTBENCH_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/cpu_tb.sv
)

if (MSVC)
    add_compile_options(/wd4018)
endif()

get_property(VERILOG_SOURCES GLOBAL PROPERTY VERILOG_SOURCES)

foreach(TB_FILE ${TESTBENCH_SOURCES})
    get_filename_component(TB_MODULE_NAME ${TB_FILE} NAME_WE)
    set(TB_NAME test_${TB_MODULE_NAME})

    message(STATUS "Configuring Verilator testbench: ${TB_NAME}")

    add_executable(${TB_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/tb_main.cpp)

    # set_target_properties(${TB_NAME} PROPERTIES
    #     RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/.."
    # )

    find_package(GTest CONFIG REQUIRED)

    target_link_libraries(${TB_NAME}
        GTest::gtest
        GTest::gtest_main
    )

    verilate(${TB_NAME}
        TOP_MODULE ${TB_MODULE_NAME}
        SOURCES
            ${TB_FILE}
            ${VERILOG_SOURCES}
        VERILATOR_ARGS
            --sv
            --trace
            -Wall
            --timing
            --Wno-fatal
            -I${CMAKE_CURRENT_SOURCE_DIR}
            -I${CMAKE_SOURCE_DIR}/vemu/src
    )

endforeach()