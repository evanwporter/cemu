cmake_minimum_required(VERSION 3.30)

project(vgb LANGUAGES CXX)
enable_testing()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(cemu)
add_subdirectory(vgb)
add_subdirectory(vgba)