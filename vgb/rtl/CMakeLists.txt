find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

add_library(libvemu)

add_subdirectory(ppu)
add_subdirectory(mmu)
add_subdirectory(cpu)
add_subdirectory(cartridge)

vemu_add_rtl(
    PACKAGES
        ${CMAKE_CURRENT_SOURCE_DIR}/types.sv
    INTERFACES
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/Memory.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Input.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Serial.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Timer.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
)

get_target_property(VGB_PACKAGES vemu_rtl INTERFACE_VGB_PACKAGES)
get_target_property(VGB_INTERFACES vemu_rtl INTERFACE_VGB_INTERFACES)
get_target_property(VGB_SOURCES vemu_rtl INTERFACE_VGB_SOURCES)

set(VGB_F_CONTENT
"${VGB_PACKAGES}
${VGB_INTERFACES}
${VGB_SOURCES}
")

string(REPLACE ";" "\n" VGB_F_CONTENT "${VGB_F_CONTENT}")

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/vgb.f "${VGB_F_CONTENT}\n")
file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/vgb.f "+incdir+${CMAKE_CURRENT_SOURCE_DIR}\n")

verilate(libvemu
    PREFIX VGameboy
    SOURCES 
        ${VGB_PACKAGES}
        ${VGB_INTERFACES}
        ${VGB_SOURCES}
        ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
    TOP_MODULE Gameboy
    VERILATOR_ARGS
        --sv
        --trace-vcd
        # -Wall
        -I${CMAKE_CURRENT_SOURCE_DIR}
        -O3
)

