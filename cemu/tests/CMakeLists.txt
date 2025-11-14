set(TEST_SOURCES 
    ${CMAKE_CURRENT_SOURCE_DIR}/test_opcodes.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/mock_mmu.cpp
)

enable_testing()

find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_executable(test_cemu ${TEST_SOURCES})
target_link_libraries(test_cemu PRIVATE 
    libcemu 
    GTest::gtest 
    GTest::gtest_main 
    nlohmann_json::nlohmann_json
)

target_compile_definitions(test_cemu PRIVATE
    TEST_DIR="${CMAKE_SOURCE_DIR}/tests/"
)

target_link_options(test_cemu PRIVATE "/FORCE:MULTIPLE")
