set(VEMU_ADV_TESTS_CPP_DIR ${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(cpu)

add_executable(test_vemu_advance
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/verilator_time.cpp
)

add_subdirectory(util)

add_test(
    NAME test_vemu_advance
    COMMAND test_vemu_advance
)

find_package(GTest CONFIG REQUIRED)
target_link_libraries(test_vemu_advance
    PRIVATE
        test_cpu_adv
        GTest::gtest
)

target_compile_definitions(test_vemu_advance PRIVATE
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_include_directories(test_vemu_advance PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)
