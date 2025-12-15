set(GENERATED_F ${CMAKE_CURRENT_BINARY_DIR}/gameboy.f)

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/gameboy.f.in
    ${GENERATED_F}
    @ONLY
)

foreach(src ${VERILOG_SOURCES})
    file(APPEND ${GENERATED_F} "${src}\n")
endforeach()

set(GENERATED_F ${GENERATED_F} PARENT_SCOPE)
