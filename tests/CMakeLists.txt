set(CMAKE_CXX_STANDARD 23)

include(CheckCXXCompilerFlag)

set(TESTBENCH_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/cpu_tb.sv
)

if (MSVC)
    add_compile_options(/wd4018)
    string(REPLACE "-fcoroutines" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
    string(REPLACE "-fcoroutines" "" CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")
    string(REPLACE "-fcoroutines" "" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
endif()

get_property(VERILOG_SOURCES GLOBAL PROPERTY VERILOG_SOURCES)

foreach(TB_FILE ${TESTBENCH_SOURCES})
    get_filename_component(TB_NAME ${TB_FILE} NAME_WE)
    message(STATUS "Configuring Verilator testbench: ${TB_NAME}")

    add_executable(${TB_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/tb_main.cpp)

    verilate(${TB_NAME}
        TOP_MODULE ${TB_NAME}
        SOURCES
            ${TB_FILE}
            ${VERILOG_SOURCES}
        VERILATOR_ARGS
            --sv
            --trace
            -Wall
            --timing
            --Wno-fatal
            -I${CMAKE_SOURCE_DIR}/verilog
    )

endforeach()