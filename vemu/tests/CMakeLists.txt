set(CMAKE_CXX_STANDARD 23)

add_subdirectory(testbench)

find_package(Verilator REQUIRED HINTS $ENV{VERILATOR_ROOT})

add_executable(vemu_tests 
    ${CMAKE_CURRENT_SOURCE_DIR}/test_opcodes.cpp
)

find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

target_link_libraries(vemu_tests PRIVATE 
    libvemu 
    GTest::gtest 
    GTest::gtest_main 
    nlohmann_json::nlohmann_json
)

target_compile_definitions(vemu_tests PRIVATE
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)