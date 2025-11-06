add_subdirectory(src)
add_subdirectory(tests)

find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

add_executable(vemu ${CMAKE_CURRENT_SOURCE_DIR}/sim/main.cpp)

target_include_directories(vemu PRIVATE
    ${CMAKE_BINARY_DIR}/vemu/CMakeFiles/libvemu.dir/VGameboy.dir
    ${VERILATOR_ROOT}/include
)

target_link_libraries(vemu PRIVATE
    libvemu   
)