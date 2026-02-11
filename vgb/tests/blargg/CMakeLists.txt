find_package(GTest CONFIG REQUIRED)

add_library(test_blargg)

target_sources(test_blargg
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/test_blargg.cpp
)

target_link_libraries(test_blargg PRIVATE
    libvemu
    GTest::gtest
)

target_compile_definitions(test_blargg 
    PUBLIC
        TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_include_directories(test_blargg
    PUBLIC
        ${VGB_TESTS_CPP_DIR}
)