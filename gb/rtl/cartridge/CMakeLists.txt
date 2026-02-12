add_subdirectory(cartridges)

gb_add_rtl(
    PACKAGES
        ${CMAKE_CURRENT_SOURCE_DIR}/Cartridge_pkg.sv
    INTERFACES
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/Cartridge.sv
)
