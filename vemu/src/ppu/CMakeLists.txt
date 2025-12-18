vemu_add_rtl(
    PACKAGES ${CMAKE_CURRENT_SOURCE_DIR}/types.sv
    INTERFACES
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/Fetcher.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/PPU.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/FIFO.sv
        ${CMAKE_CURRENT_SOURCE_DIR}/Framebuffer.sv
)
