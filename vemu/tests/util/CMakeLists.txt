target_sources(test_vemu
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/util.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/test_config.cpp
)

add_executable(display_ppm 
    ${CMAKE_CURRENT_SOURCE_DIR}/display_ppm.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/ppm.cpp
)

target_link_libraries(display_ppm PRIVATE SDL2::SDL2)