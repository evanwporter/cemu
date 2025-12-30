set(VEMU_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)

add_library(vemu_rtl INTERFACE)

function(vemu_add_rtl)
    cmake_parse_arguments(ARG "" "" "PACKAGES;INTERFACES;SOURCES" ${ARGN})

    if(ARG_PACKAGES)
        set_property(TARGET vemu_rtl APPEND PROPERTY
            INTERFACE_VEMU_PACKAGES ${ARG_PACKAGES})
    endif()

    if(ARG_INTERFACES)
        set_property(TARGET vemu_rtl APPEND PROPERTY
            INTERFACE_VEMU_INTERFACES ${ARG_INTERFACES})
    endif()

    if(ARG_SOURCES)
        set_property(TARGET vemu_rtl APPEND PROPERTY
            INTERFACE_VEMU_SOURCES ${ARG_SOURCES})
    endif()
endfunction()


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

set(VEMU_TEST_SOURCES
    # ${CMAKE_CURRENT_SOURCE_DIR}/tests/cpu/cpu_top.sv
)

add_subdirectory(src)

add_library(libvemu_harness)

target_sources(libvemu_harness PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/sim/gb.cpp)

target_include_directories(libvemu_harness PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/sim/)

target_link_libraries(libvemu_harness PUBLIC
    libvemu
    # SDL2::SDL2main 
    SDL2::SDL2
)

target_compile_definitions(libvemu_harness PUBLIC
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
    SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
)

add_subdirectory(tests)

find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

find_package(SDL2 CONFIG REQUIRED)

add_executable(vemu ${CMAKE_CURRENT_SOURCE_DIR}/sim/main.cpp)

target_include_directories(vemu PRIVATE
    ${CMAKE_BINARY_DIR}/vemu/CMakeFiles/libvemu.dir/VGameboy.dir
    ${VERILATOR_ROOT}/include
)

target_link_libraries(vemu PRIVATE
    libvemu
    libvemu_harness
    SDL2::SDL2main 
)