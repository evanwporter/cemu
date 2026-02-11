# TODO: The CMake is incredibly messy right now. Clean it up.

set(VGBA_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/rtl)

add_library(vemu_adv_rtl INTERFACE)

function(vemu_adv_add_rtl)
    cmake_parse_arguments(ARG "" "" "PACKAGES;INTERFACES;SOURCES" ${ARGN})

    if(ARG_PACKAGES)
        set_property(TARGET vemu_adv_rtl APPEND PROPERTY
            INTERFACE_VGB_PACKAGES ${ARG_PACKAGES})
    endif()

    if(ARG_INTERFACES)
        set_property(TARGET vemu_adv_rtl APPEND PROPERTY
            INTERFACE_VGB_INTERFACES ${ARG_INTERFACES})
    endif()

    if(ARG_SOURCES)
        set_property(TARGET vemu_adv_rtl APPEND PROPERTY
            INTERFACE_VGB_SOURCES ${ARG_SOURCES})
    endif()
endfunction()

add_subdirectory(rtl)

# target_sources(libvemu_adv PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/sim/gb.cpp)

target_include_directories(libvemu_adv PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/sim/)

find_package(SDL2 CONFIG REQUIRED)
target_link_libraries(libvemu_adv PUBLIC
    SDL2::SDL2
)

target_compile_definitions(libvemu_adv PUBLIC
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

# add_executable(vgb ${CMAKE_CURRENT_SOURCE_DIR}/sim/main.cpp)

# target_include_directories(vgb PRIVATE
#     ${CMAKE_BINARY_DIR}/vgb/CMakeFiles/libvemu.dir/VGameboy.dir
#     ${VERILATOR_ROOT}/include
# )

# target_link_libraries(vgb PRIVATE
#     libvemu_adv
#     argparse
# )
