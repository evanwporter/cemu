set(CMAKE_CXX_STANDARD 20)

add_cpp_tb(test_mmu
    ${CMAKE_CURRENT_SOURCE_DIR}/top.sv
    ${VEMU_SRC_DIR}/mmu/MMU.sv
    ${VEMU_SOURCES}
)