add_library(libcemu)
target_include_directories(libcemu PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(cartridge)
add_subdirectory(cpu)
add_subdirectory(util)
add_subdirectory(ppu)
add_subdirectory(io)
add_subdirectory(mmu)

target_sources(libcemu PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/address.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/gameboy.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/timer.cpp
)
