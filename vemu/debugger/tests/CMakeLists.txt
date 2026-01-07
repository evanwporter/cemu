
find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_executable(test_debugger)

target_sources(test_debugger PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/mem.cpp
)

target_include_directories(test_debugger PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_compile_definitions(test_debugger PRIVATE TEST_DIR="${CMAKE_SOURCE_DIR}/tests/")

target_link_libraries(test_debugger PRIVATE
    libvemu
    GTest::gtest
    nlohmann_json::nlohmann_json
    GTest::gtest_main
)