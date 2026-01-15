set(VEMU_TESTS_CPP_DIR ${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(cpu)
add_subdirectory(ppu)
add_subdirectory(blargg)
add_subdirectory(mooneye)
add_subdirectory(gbmicrotest)

add_executable(test_vemu
    ${CMAKE_CURRENT_SOURCE_DIR}/verilator_time.cpp
)

add_subdirectory(util)

add_test(
    NAME test_vemu
    COMMAND test_vemu
)

find_package(GTest CONFIG REQUIRED)
target_link_libraries(test_vemu
    PRIVATE
        test_cpu
        test_blargg
        test_mooneye
        # test_gbmicrotest
        libvemu
        GTest::gtest
        GTest::gtest_main
)

target_compile_definitions(test_vemu PRIVATE
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_include_directories(test_vemu PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

