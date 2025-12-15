cmake_minimum_required(VERSION 3.10)

project(cemu LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(src)
add_subdirectory(tests)

set(EXE_SOURCES
  src/main.cpp
)

include(FetchContent)
# set(FETCHCONTENT_FULLY_DISCONNECTED ON) 
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