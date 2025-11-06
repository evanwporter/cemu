registers = ["B", "C", "D", "E", "H", "L", "(HL)", "A"]

MAX_CYCLES = 6
control_words = [[] for _ in range(256)]
opcode_comments = {}

conditions = {
    "NZ": "COND_NZ",
    "Z": "COND_Z",
    "NC": "COND_NC",
    "C": "COND_C",
}

DEFAULT_FIELDS = {
    "addr_src": "ADDR_NONE",
    "data_bus_src": "DATA_BUS_SRC_NONE",
    "data_bus_op": "DATA_BUS_OP_NONE",
    "idu_op": "IDU_OP_NONE",
    "alu_op": "ALU_OP_NONE",
    "alu_dst": "ALU_SRC_NONE",
    "alu_src": "ALU_SRC_NONE",
    "misc_op": "MISC_OP_NONE",
    "cond": "COND_NONE",
}


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
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
    ]
    control_words[opcode] = cycles
    opcode_comments[opcode] = f"LD (HL), {src}"


def make_jp_nn(cond_sv: str | None = None):
    cycles = [
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_Z",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_W",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        {
            "addr_src": "ADDR_NONE",
            "data_bus_op": "DATA_BUS_OP_NONE",
            "misc_op": "MISC_OP_WZ_TO_PC",
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        None,
        None,
    ]

    if cond_sv:
        cycles[1]["misc_op"] = "MISC_OP_COND_CHECK"
        cycles[1]["cond"] = cond_sv
        cycles[5] = {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        }

    return cycles


conditional_jumps = {
    0xC2: "NZ",
    0xCA: "Z",
    0xD2: "NC",
    0xDA: "C",
}

for opcode, cond_name in conditional_jumps.items():
    control_words[opcode] = make_jp_nn(conditions[cond_name])
    opcode_comments[opcode] = f"JP {cond_name}, nn"

# Unconditional
control_words[0xC3] = make_jp_nn()
opcode_comments[0xC3] = "JP nn"


def make_call_nn(cond_sv: str | None = None):
    cycles = [
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_Z",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_W",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_src": "DATA_BUS_SRC_PC_HIGH",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_DEC",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_src": "DATA_BUS_SRC_PC_LOW",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_DEC",
            "misc_op": "MISC_OP_WZ_TO_PC",
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_op": "DATA_BUS_OP_READ",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "idu_op": "IDU_OP_INC",
        },
    ]

    if cond_sv:
        cycles[1]["misc_op"] = "MISC_OP_COND_CHECK"
        cycles[1]["cond"] = cond_sv

    return cycles


conditional_call = {
    0xC4: "NZ",
    0xCC: "Z",
    0xD4: "NC",
    0xDC: "C",
}

for opcode, cond_name in conditional_call.items():
    control_words[opcode] = make_call_nn(conditions[cond_name])
    opcode_comments[opcode] = f"CALL {cond_name}, nn"

# Unconditional CALL
control_words[0xCD] = make_call_nn()
opcode_comments[0xCD] = "CALL nn"


def make_ret(cond_sv: str | None = None):
    cycles = [
        {
            "addr_src": "ADDR_SP",
            "data_bus_src": "DATA_BUS_SRC_Z",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_src": "DATA_BUS_SRC_W",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        {
            "addr_src": "ADDR_NONE",
            "data_bus_op": "DATA_BUS_OP_NONE",
            "misc_op": "MISC_OP_WZ_TO_PC",
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        None,
        None,
    ]

    if cond_sv:
        cycles.insert(
            0,
            {
                "addr_src": "ADDR_NONE",
                "data_bus_op": "DATA_BUS_OP_NONE",
                "misc_op": "MISC_OP_COND_CHECK",
                "cond": cond_sv,
            },
        )

        # Fill last slot for “not taken” alignment
        cycles[5] = {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        }

        return cycles[:-1]

    return cycles


conditional_rets = {
    0xC0: "NZ",
    0xC8: "Z",
    0xD0: "NC",
    0xD8: "C",
}

for opcode, cond_name in conditional_rets.items():
    control_words[opcode] = make_ret(conditions[cond_name])
    opcode_comments[opcode] = f"RET {cond_name}"

# Unconditional RET
control_words[0xC9] = make_ret()
opcode_comments[0xC9] = "RET"


# 8 bit ALU operations
def make_alu_op(base_opcode: int, alu_op: str, mnemonic: str):
    for i, src in enumerate(registers):
        opcode = base_opcode | i
        cycles = []

        if src == "(HL)":
            # (HL) takes 2 cycles: read + execute
            cycles = [
                {
                    "addr_src": "ADDR_HL",
                    "data_bus_src": "DATA_BUS_SRC_Z",
                    "data_bus_op": "DATA_BUS_OP_READ",
                },
                {
                    "addr_src": "ADDR_PC",
                    "data_bus_src": "DATA_BUS_SRC_IR",
                    "data_bus_op": "DATA_BUS_OP_READ",
                    "idu_op": "IDU_OP_INC",
                    "alu_op": alu_op,
                    "alu_dst": "ALU_SRC_A",
                    "alu_src": "ALU_SRC_Z",
                },
            ]
        else:
            # Register source: single ALU cycle
            cycles = [
                {
                    "addr_src": "ADDR_PC",
                    "data_bus_src": "DATA_BUS_SRC_IR",
                    "data_bus_op": "DATA_BUS_OP_READ",
                    "idu_op": "IDU_OP_INC",
                    "alu_op": alu_op,
                    "alu_dst": "ALU_SRC_A",
                    "alu_src": f"ALU_SRC_{src}",
                }
            ]

        control_words[opcode] = cycles
        opcode_comments[opcode] = f"{mnemonic} {src}"


# ADD A,r
make_alu_op(0x80, "ALU_OP_ADD", "ADD A,")

# ADC A,r
make_alu_op(0x88, "ALU_OP_ADC", "ADC A,")

# SUB A,r
make_alu_op(0x90, "ALU_OP_SUB", "SUB A,")

# SBC A,r
make_alu_op(0x98, "ALU_OP_SBC", "SBC A,")

# AND A,r
make_alu_op(0xA0, "ALU_OP_AND", "AND A,")

# XOR A,r
make_alu_op(0xA8, "ALU_OP_XOR", "XOR A,")

# OR A,r
make_alu_op(0xB0, "ALU_OP_OR", "OR A,")

# # CP A,r
# make_alu_op(0xB8, "ALU_OP_CP", "CP A,")

# NOP
control_words[0x00] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_op": "DATA_BUS_OP_READ",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "idu_op": "IDU_OP_INC",
    },
]
opcode_comments[0x00] = "NOP"


def sv_literal(i: int, entry: dict | None, is_last=False) -> str:
    if not entry:
        comma = "," if not is_last else ""
        return f"            {i}: `DEFAULT_CYCLE{comma}  // M-cycle {i + 1}\n"

    filled = DEFAULT_FIELDS.copy()
    filled.update(entry)

    fields = [f"                {key} : {val}" for key, val in filled.items()]
    comma = "," if not is_last else ""
    return (
        f"            {i}: '{{  // M-cycle {i + 1}\n"
        + ",\n".join(fields)
        + f"\n            }}{comma}\n"
    )


def count_real_cycles(cycles: list) -> int:
    count = 0
    for c in cycles:
        if not c:
            break
        count += 1
    return count


def generate_sv(control_words, opcode_comments) -> str:
    lines = []
    lines.append("`ifndef CONTROL_WORDS_SV\n`define CONTROL_WORDS_SV\n")
    lines.append('`include "cpu/opcodes.sv"\n\n')
    lines.append("localparam control_word_t control_words [0:255] = '{\n")

    for opcode in range(256):
        cycles = control_words[opcode]
        comment = opcode_comments.get(opcode, "")
        if not comment:
            comment = "UNDEFINED"
        comment_str = f" {comment}" if comment else ""

        lines.append(f"    'h{opcode:02X}: '{{  // {comment_str}\n")

        if cycles:
            num_real = count_real_cycles(cycles)
            lines.append(f"        num_cycles : 3'd{num_real},\n")
            lines.append("        cycles : '{\n")

            for i in range(MAX_CYCLES):
                is_last = i == MAX_CYCLES - 1
                entry = cycles[i] if i < len(cycles) else None
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


output_path = "verilog/cpu/control_words.sv"
with open(output_path, "w", newline="\n") as f:
    f.write(generate_sv(control_words, opcode_comments))
