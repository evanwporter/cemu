find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

add_library(libvemu)

add_subdirectory(ppu)
add_subdirectory(mmu)
add_subdirectory(cpu)

vemu_add_rtl(
    PACKAGES
    INTERFACES
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/Input.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Cartridge.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Serial.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Timer.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
)

# Helper macro to normalize NOTFOUND variables 
macro(vemu_normalize var)
    if(${var} STREQUAL "${var}-NOTFOUND")
        set(${var} "")
    endif()
endmacro()

get_target_property(VEMU_PACKAGES vemu_rtl INTERFACE_VEMU_PACKAGES)
get_target_property(VEMU_INTERFACES vemu_rtl INTERFACE_VEMU_INTERFACES)
get_target_property(VEMU_SOURCES vemu_rtl INTERFACE_VEMU_SOURCES)

vemu_normalize(VEMU_PACKAGES)
vemu_normalize(VEMU_INTERFACES)
vemu_normalize(VEMU_SOURCES)

set(VEMU_F_CONTENT
"${VEMU_PACKAGES}
${VEMU_INTERFACES}
${VEMU_SOURCES}
")

string(REPLACE ";" "\n" VEMU_F_CONTENT "${VEMU_F_CONTENT}")

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/vemu.f "${VEMU_F_CONTENT}\n")

verilate(libvemu
    SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
    TOP_MODULE Gameboy
    VERILATOR_ARGS
        --sv
        --trace
        # -Wall
        -I${CMAKE_CURRENT_SOURCE_DIR}
        -f ${CMAKE_CURRENT_BINARY_DIR}/vemu.f
)

