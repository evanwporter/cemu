add_subdirectory(panels)

target_sources(gb_debugger PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/debugger.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/op_history.cpp
)