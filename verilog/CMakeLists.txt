find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

add_library(libvemu)

add_subdirectory(cpu)
add_subdirectory(mmu)

set(VERILOG_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/types.sv
)

verilate(libvemu
    SOURCES ${VERILOG_SOURCES}
    TOP_MODULE Gameboy
    VERILATOR_ARGS
        --sv
        --trace
        # -Wall
        -I${CMAKE_CURRENT_SOURCE_DIR}
        -I${CMAKE_CURRENT_SOURCE_DIR}/cpu
)