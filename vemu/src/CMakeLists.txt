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
        ${CMAKE_CURRENT_SOURCE_DIR}/Input.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Serial.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Timer.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
)

get_target_property(VEMU_PACKAGES vemu_rtl INTERFACE_VEMU_PACKAGES)
get_target_property(VEMU_INTERFACES vemu_rtl INTERFACE_VEMU_INTERFACES)
get_target_property(VEMU_SOURCES vemu_rtl INTERFACE_VEMU_SOURCES)

set(VEMU_F_CONTENT
"${VEMU_PACKAGES}
${VEMU_INTERFACES}
${VEMU_SOURCES}
")

string(REPLACE ";" "\n" VEMU_F_CONTENT "${VEMU_F_CONTENT}")

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/vemu.f "${VEMU_F_CONTENT}\n")
file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/vemu.f "+incdir+${CMAKE_CURRENT_SOURCE_DIR}\n")

verilate(libvemu
    PREFIX VGameboy
    SOURCES 
        ${VEMU_PACKAGES}
        ${VEMU_INTERFACES}
        ${VEMU_SOURCES}
        ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
    TOP_MODULE Gameboy
    VERILATOR_ARGS
        --sv
        --trace
        # -Wall
        -I${CMAKE_CURRENT_SOURCE_DIR}
        -O3
)

