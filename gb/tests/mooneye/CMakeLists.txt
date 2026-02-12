find_package(GTest CONFIG REQUIRED)

add_library(test_mooneye)

target_sources(test_mooneye
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/test_mooneye.cpp
)

target_link_libraries(test_mooneye PRIVATE
    libgb
    GTest::gtest
)

target_compile_definitions(test_mooneye 
    PUBLIC
        TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_include_directories(test_mooneye
    PUBLIC
        ${GB_TESTS_CPP_DIR}
)