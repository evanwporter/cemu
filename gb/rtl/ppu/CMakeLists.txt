add_subdirectory(fetcher)
add_subdirectory(fifo)

gb_add_rtl(
    PACKAGES 
        ${CMAKE_CURRENT_SOURCE_DIR}/types.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/util.sv
    INTERFACES
        ${CMAKE_CURRENT_SOURCE_DIR}/interface.sv
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/PPU.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Framebuffer.sv
)
