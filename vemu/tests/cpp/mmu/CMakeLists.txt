# function(generate_mock name value)
#     set(NAME "${name}")
#     set(READ_VALUE "${value}")
#     set(out "${CMAKE_CURRENT_BINARY_DIR}/${name}.sv")
#     configure_file(${CMAKE_CURRENT_SOURCE_DIR}/mock_module.sv.in
#                    ${out}
#                    @ONLY)
#     list(APPEND GENERATED_MOCKS ${out})
#     set(GENERATED_MOCKS "${GENERATED_MOCKS}" PARENT_SCOPE)
# endfunction()

# generate_mock(PPU "8'hA0")
# generate_mock(APU "8'hE0")
# generate_mock(TIMER "8'h42")

add_cpp_tb(test_MMU
    ${CMAKE_CURRENT_SOURCE_DIR}/top.sv
    ${VEMU_SRC_DIR}/mmu/MMU.sv
    ${VERILOG_SOURCES}
    # ${GENERATED_MOCKS}
)