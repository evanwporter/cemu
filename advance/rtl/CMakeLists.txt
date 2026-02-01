find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

add_library(libvemu_adv)

add_subdirectory(ARM7)
add_subdirectory(MMU)

vemu_adv_add_rtl(
    PACKAGES
    INTERFACES
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
)

get_target_property(VEMU_ADV_PACKAGES vemu_adv_rtl INTERFACE_VEMU_PACKAGES)
get_target_property(VEMU_ADV_INTERFACES vemu_adv_rtl INTERFACE_VEMU_INTERFACES)
get_target_property(VEMU_ADV_SOURCES vemu_adv_rtl INTERFACE_VEMU_SOURCES)

set(VEMU_ADV_F_CONTENT
"${VEMU_ADV_PACKAGES}
${VEMU_ADV_INTERFACES}
${VEMU_ADV_SOURCES}
")

string(REPLACE ";" "\n" VEMU_ADV_F_CONTENT "${VEMU_ADV_F_CONTENT}")

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/vemu.f "${VEMU_ADV_F_CONTENT}\n")
file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/vemu.f "+incdir+${CMAKE_CURRENT_SOURCE_DIR}\n")

verilate(libvemu_adv
    PREFIX VGameboy
    SOURCES 
        ${VEMU_ADV_PACKAGES}
        ${VEMU_ADV_INTERFACES}
        ${VEMU_ADV_SOURCES}
        ${CMAKE_CURRENT_SOURCE_DIR}/Gameboy.sv
    TOP_MODULE Gameboy
    VERILATOR_ARGS
        --sv
        --trace-vcd
        # -Wall
        -I${CMAKE_CURRENT_SOURCE_DIR}
        -O3
)