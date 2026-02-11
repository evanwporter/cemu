set(VGBA_TESTS_CPP_DIR ${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(cpu)

add_executable(test_vgba
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/verilator_time.cpp
)

add_subdirectory(util)

add_test(
    NAME test_vgba
    COMMAND test_vgba
)

find_package(GTest CONFIG REQUIRED)
target_link_libraries(test_vgba
    PRIVATE
        test_cpu_adv
        GTest::gtest
)

target_compile_definitions(test_vgba PRIVATE
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_include_directories(test_vgba PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)
