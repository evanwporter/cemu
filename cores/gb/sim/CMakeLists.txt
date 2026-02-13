add_library(GameboyHarness)

add_subdirectory(src)
target_include_directories(GameboyHarness PUBLIC include)
target_link_libraries(GameboyHarness SDL2::SDL2 libgb gb_debugger)