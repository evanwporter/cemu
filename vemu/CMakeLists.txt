# TODO: The CMake is incredibly messy right now. Clean it up.

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

add_subdirectory(src)

target_sources(libvemu PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/sim/gb.cpp)

target_include_directories(libvemu PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/sim/)

find_package(SDL2 CONFIG REQUIRED)
target_link_libraries(libvemu PUBLIC
    SDL2::SDL2
)

target_compile_definitions(libvemu PUBLIC
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
    SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
)

add_subdirectory(tests)

find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

include(FetchContent)
FetchContent_Declare(
    argparse
    GIT_REPOSITORY https://github.com/p-ranav/argparse.git
)
FetchContent_MakeAvailable(argparse)

add_executable(vemu ${CMAKE_CURRENT_SOURCE_DIR}/sim/main.cpp)

target_include_directories(vemu PRIVATE
    ${CMAKE_BINARY_DIR}/vemu/CMakeFiles/libvemu.dir/VGameboy.dir
    ${VERILATOR_ROOT}/include
)

target_link_libraries(vemu PRIVATE
    libvemu
    argparse
)

add_subdirectory(debug)

add_executable(debug)
target_sources(debug PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/sim/debug.cpp)
target_link_libraries(debug PRIVATE gb_debugger libvemu argparse)