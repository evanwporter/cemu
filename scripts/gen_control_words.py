registers = ["B", "C", "D", "E", "H", "L", "(HL)", "A"]

MAX_CYCLES = 6
control_words = [[] for _ in range(256)]
opcode_comments = {}


def opcode_for_ld(dst, src):
    # LD r, r' start at 0x40
    dst_index = registers.index(dst)
    src_index = registers.index(src)
    return 0x40 | (dst_index << 3) | src_index


# LD r,r'
for dst in registers:
    for src in registers:
        if "(HL)" in [dst, src]:
            continue
        opcode = opcode_for_ld(dst, src)
        cycles = [
            {
                "addr_src": "ADDR_PC",
                "data_bus_src": "DATA_BUS_SRC_IR",
                "data_bus_op": "DATA_BUS_OP_READ",
                "idu_op": "IDU_OP_INC",
                "alu_op": "ALU_OP_COPY",
                "alu_dst": f"ALU_SRC_{dst}",
                "alu_src": f"ALU_SRC_{src}",
            }
        ]
        control_words[opcode] = cycles
        opcode_comments[opcode] = f"LD {dst}, {src}"


# LD r,(HL)
for dst in registers:
    if dst == "(HL)":
        continue
    src = "(HL)"
    opcode = opcode_for_ld(dst, src)
    cycles = [
        {
            "addr_src": "ADDR_HL",
            "data_bus_src": "DATA_BUS_SRC_Z",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_NONE",
            "alu_op": "ALU_OP_NONE",
            "alu_dst": "ALU_SRC_NONE",
            "alu_src": "ALU_SRC_NONE",
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
            "alu_op": "ALU_OP_COPY",
            "alu_dst": f"ALU_SRC_{dst}",
            "alu_src": "ALU_SRC_Z",
        },
    ]
    control_words[opcode] = cycles
    opcode_comments[opcode] = f"LD {dst}, (HL)"

for src in registers:
    if src == "(HL)":
        continue
    dst = "(HL)"
    opcode = opcode_for_ld(dst, src)
    cycles = [
        {
            "addr_src": "ADDR_HL",
            "data_bus_src": f"DATA_BUS_SRC_{src}",
            "data_bus_op": "DATA_BUS_OP_WRITE",
            "idu_op": "IDU_OP_INC",
            "alu_op": "ALU_OP_NONE",
            "alu_dst": "ALU_SRC_NONE",
            "alu_src": "ALU_SRC_NONE",
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
            "alu_op": "ALU_OP_NONE",
            "alu_dst": "ALU_SRC_NONE",
            "alu_src": "ALU_SRC_NONE",
        },
    ]
    control_words[opcode] = cycles
    opcode_comments[opcode] = f"LD (HL), {src}"


def sv_literal(i: int, entry: dict, is_last=False) -> str:
    if not entry:
        comma = "," if not is_last else ""
        return f"            `DEFAULT_CYCLE{comma}  // M-cycle {i + 1}\n"

    fields = [f"                {key} : {val}" for key, val in entry.items()]
    comma = "," if not is_last else ""
    return (
        f"            '{{  // M-cycle {i + 1}\n"
        + ",\n".join(fields)
        + f"\n            }}{comma}\n"
    )


def generate_sv(control_words, opcode_comments) -> str:
    lines = []
    lines.append("`ifndef CONTROL_WORDS_SV\n`define CONTROL_WORDS_SV\n")
    lines.append('`include "opcodes.sv"\n\n')
    lines.append("localparam control_word_t control_words [0:255] = '{\n")

    for opcode in range(256):
        cycles = control_words[opcode]
        comment = opcode_comments.get(opcode, "")
        if not comment:
            comment = "UNDEFINED"
        comment_str = f" {comment}" if comment else ""

        lines.append(f"    8'h{opcode:02X}: '{{  //{comment_str}\n")

        if cycles:
            lines.append(f"        num_cycles : 3'd{len(cycles)},\n")
            lines.append("        cycles : '{\n")

            for i in range(MAX_CYCLES):
                is_last = i == MAX_CYCLES - 1
                entry = cycles[i] if i < len(cycles) else {}
                lines.append(sv_literal(i, entry, is_last))

            lines.append("        }\n    }")
        else:
            # undefined opcode: 6 default cycles
            lines.append("        num_cycles : 3'd0,\n")
            lines.append("        cycles : '{\n")
            for i in range(MAX_CYCLES):
                is_last = i == MAX_CYCLES - 1
                comma = "" if is_last else ","
                lines.append(f"            `DEFAULT_CYCLE{comma}  // M-cycle {i + 1}\n")
            lines.append("        }\n    }")

        if opcode != 255:
            lines.append(",\n")
        else:
            lines.append("\n")

    lines.append("};\n`endif // CONTROL_WORDS_SV\n")
    return "".join(lines)


output_path = "verilog/control_words.sv"
with open(output_path, "w", newline="\n") as f:
    f.write(generate_sv(control_words, opcode_comments))
