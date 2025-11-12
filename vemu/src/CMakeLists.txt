find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

add_library(libvemu)

add_subdirectory(cpu)
add_subdirectory(mmu)
add_subdirectory(util)

set(VERILOG_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
)

set_property(GLOBAL PROPERTY VERILOG_SOURCES "${VERILOG_SOURCES}")

verilate(libvemu
    SOURCES ${VERILOG_SOURCES}
    TOP_MODULE Gameboy
    VERILATOR_ARGS
        --sv
        --trace
        # -Wall
        -I${CMAKE_CURRENT_SOURCE_DIR}
        -I${CMAKE_CURRENT_SOURCE_DIR}/../ext/svlogger/
)