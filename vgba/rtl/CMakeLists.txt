find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

add_library(libvemu_adv)

vemu_adv_add_rtl(
    PACKAGES
        ${CMAKE_CURRENT_SOURCE_DIR}/types.sv
    INTERFACES
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
)

add_subdirectory(cpu)
add_subdirectory(mmu)

get_target_property(VGBA_PACKAGES vemu_adv_rtl INTERFACE_VGB_PACKAGES)
get_target_property(VGBA_INTERFACES vemu_adv_rtl INTERFACE_VGB_INTERFACES)
get_target_property(VGBA_SOURCES vemu_adv_rtl INTERFACE_VGB_SOURCES)

set(VGBA_F_CONTENT
"${VGBA_PACKAGES}
${VGBA_INTERFACES}
${VGBA_SOURCES}
")

string(REPLACE ";" "\n" VGBA_F_CONTENT "${VGBA_F_CONTENT}")

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/vgb.f "${VGBA_F_CONTENT}\n")
file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/vgb.f "+incdir+${CMAKE_CURRENT_SOURCE_DIR}\n")

verilate(libvemu_adv
    PREFIX VGameboy
    SOURCES 
        ${VGBA_PACKAGES}
        ${VGBA_INTERFACES}
        ${VGBA_SOURCES}
        ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
    TOP_MODULE Gameboy
    VERILATOR_ARGS
        --sv
        --trace-vcd
        # -Wall
        -I${CMAKE_CURRENT_SOURCE_DIR}
        -O3
)