cmake_minimum_required(VERSION 3.10)

project(cemu LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(${PROJECT_SOURCE_DIR}/src)

find_package(nlohmann_json CONFIG REQUIRED)

set(LIB_SOURCES
    src/cpu/cpu.cpp
    src/cpu/opcodes.cpp
    src/mmu/mmu.cpp
)

add_library(libcemu STATIC ${LIB_SOURCES})

set(EXE_SOURCES
    src/main.cpp
)

add_executable(cemu ${EXE_SOURCES})

target_link_libraries(cemu PRIVATE libcemu)

set(TEST_SOURCES 
    tests/test_cemu.cpp
    tests/cpu.cpp
)

include(FetchContent)
FetchContent_Declare(
  googletest
  # Specify the commit you depend on and update it regularly.
  URL https://github.com/google/googletest/archive/52eb8108c5bdec04579160ae17225d66034bd723.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

include(CTest)
enable_testing()

add_executable(cemu_tests ${TEST_SOURCES})
target_link_libraries(cemu_tests PRIVATE libcemu gtest_main nlohmann_json::nlohmann_json)

if(TARGET cemu_tests)
    target_compile_definitions(libcemu PRIVATE CEMU_CPU_TEST_MODE=1)
endif()

target_compile_definitions(cemu_tests PRIVATE CEMU_CPU_TEST_MODE=1)

add_test(NAME cemu_tests COMMAND cemu_tests)
