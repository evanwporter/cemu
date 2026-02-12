target_sources(gb_debugger PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/cpu_state.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/memory_viewer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/instr_history.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/tiles.cpp
)