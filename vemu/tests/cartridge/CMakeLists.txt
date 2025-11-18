set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_cpp_tb(test_cartridge
    ${CMAKE_CURRENT_SOURCE_DIR}/cartridge_top.sv
)

add_cpp_tb(test_cartridge_integration
    ${CMAKE_CURRENT_SOURCE_DIR}/cartridge_cpu_top.sv
)