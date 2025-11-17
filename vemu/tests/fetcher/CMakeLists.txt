set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_cpp_tb(test_fetcher
    ${CMAKE_CURRENT_SOURCE_DIR}/fetcher_top.sv
)