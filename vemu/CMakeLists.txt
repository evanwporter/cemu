set(VEMU_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)

set(VEMU_PKGS
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ppu/types.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/cpu/types.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/mmu/addresses.sv
)

set(VERILOG_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ppu/PPU.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ppu/Fetcher.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ppu/FIFO.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ppu/Framebuffer.sv

    ${CMAKE_CURRENT_SOURCE_DIR}/src/Gameboy.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/Input.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/Cartridge.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/Serial.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/Timer.sv

    ${CMAKE_CURRENT_SOURCE_DIR}/src/cpu/CPU.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/cpu/RAM.sv

    ${CMAKE_CURRENT_SOURCE_DIR}/src/mmu/MMU.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/mmu/DMA.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/mmu/interface.sv
    ${CMAKE_CURRENT_SOURCE_DIR}/src/mmu/util.sv
)

add_subdirectory(builds)
add_subdirectory(src)
# add_subdirectory(tests)

find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

find_package(SDL2 CONFIG REQUIRED)

add_executable(vemu ${CMAKE_CURRENT_SOURCE_DIR}/sim/main.cpp)

target_include_directories(vemu PRIVATE
    ${CMAKE_BINARY_DIR}/vemu/CMakeFiles/libvemu.dir/VGameboy.dir
    ${VERILATOR_ROOT}/include
)

target_link_libraries(vemu PRIVATE
    libvemu
    SDL2::SDL2main 
    SDL2::SDL2
)

target_compile_definitions(vemu PRIVATE
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
    SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
)