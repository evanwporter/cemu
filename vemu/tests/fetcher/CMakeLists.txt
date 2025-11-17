set(CMAKE_CXX_STANDARD 23)

add_cpp_tb(test_fetcher
    ${CMAKE_CURRENT_SOURCE_DIR}/fetcher_top.sv
    ${VEMU_SRC_DIR}/ppu/Fetcher.sv
)