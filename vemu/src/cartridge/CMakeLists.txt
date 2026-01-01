add_subdirectory(cartridges)

vemu_add_rtl(
    PACKAGES
    INTERFACES
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/Cartridge.sv
)
