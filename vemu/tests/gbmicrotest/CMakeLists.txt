find_package(GTest CONFIG REQUIRED)

add_library(test_gbmicrotest)

target_sources(test_gbmicrotest
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/test_gbmicrotest.cpp
)

target_link_libraries(test_gbmicrotest PRIVATE
    libvemu
    GTest::gtest
)

target_compile_definitions(test_gbmicrotest 
    PUBLIC
        TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_include_directories(test_gbmicrotest
    PUBLIC
        ${VEMU_TESTS_CPP_DIR}
)