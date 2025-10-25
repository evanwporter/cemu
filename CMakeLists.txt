cmake_minimum_required(VERSION 3.10)

project(cemu LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(src)

set(EXE_SOURCES
  src/main.cpp
)

include(FetchContent)
FetchContent_Declare(
    argparse
    GIT_REPOSITORY https://github.com/p-ranav/argparse.git
)
FetchContent_MakeAvailable(argparse)

find_package(SDL2 CONFIG REQUIRED)

add_executable(cemu ${EXE_SOURCES})

target_link_libraries(cemu PRIVATE 
    libcemu 
    argparse 
    SDL2::SDL2main 
    SDL2::SDL2
)

set(TEST_SOURCES 
    tests/test_opcodes.cpp
    tests/mock_mmu.cpp
)

enable_testing()

find_package(nlohmann_json CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_executable(cemu_tests ${TEST_SOURCES})
target_link_libraries(cemu_tests PRIVATE 
    libcemu 
    GTest::gtest 
    GTest::gtest_main 
    nlohmann_json::nlohmann_json
)

target_compile_definitions(cemu_tests PRIVATE
    TEST_DIR="${CMAKE_CURRENT_SOURCE_DIR}/tests/"
)

target_link_options(cemu_tests PRIVATE "/FORCE:MULTIPLE")

add_test(NAME cemu_tests COMMAND cemu_tests)