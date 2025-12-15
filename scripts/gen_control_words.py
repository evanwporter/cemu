registers = ["B", "C", "D", "E", "H", "L", "(HL)", "A"]

MAX_CYCLES = 6
control_words = [[] for _ in range(256)]
opcode_comments = {}

cb_control_words = [[] for _ in range(256)]
cb_opcode_comments = {}

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
    "idu_dst": "ADDR_NONE",
    "alu_op": "ALU_OP_NONE",
    "alu_dst": "ALU_SRC_NONE",
    "alu_src": "ALU_SRC_NONE",
    "alu_bit": "ALU_BIT_0",
    "misc_op": "MISC_OP_NONE",
    "misc_op_dst": "MISC_OP_DST_NONE",
    "cond": "COND_NONE",
}

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

NOP = control_words[0x00][0]


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

# LD (HL), r
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
            "misc_op": "MISC_OP_R16_WZ_COPY",
            "misc_op_dst": "MISC_OP_DST_PC",
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


for opcode, cond_name in {0xC2: "NZ", 0xCA: "Z", 0xD2: "NC", 0xDA: "C"}.items():
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
            "idu_op": "IDU_OP_DEC",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_src": "DATA_BUS_SRC_PC_HIGH",
            "data_bus_op": "DATA_BUS_OP_WRITE",
            "idu_op": "IDU_OP_DEC",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_src": "DATA_BUS_SRC_PC_LOW",
            "data_bus_op": "DATA_BUS_OP_WRITE",
            "misc_op": "MISC_OP_R16_WZ_COPY",
            "misc_op_dst": "MISC_OP_DST_PC",
        },
        NOP,
    ]

    if cond_sv:
        cycles[1]["misc_op"] = "MISC_OP_COND_CHECK"
        cycles[1]["cond"] = cond_sv

    return cycles


for opcode, cond_name in {0xC4: "NZ", 0xCC: "Z", 0xD4: "NC", 0xDC: "C"}.items():
    control_words[opcode] = make_call_nn(conditions[cond_name])
    opcode_comments[opcode] = f"CALL {cond_name}, nn"

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
            "misc_op": "MISC_OP_R16_WZ_COPY",
            "misc_op_dst": "MISC_OP_DST_PC",
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

        cycles[5] = {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        }

        return cycles[:-1]

    return cycles


for opcode, cond_name in {0xC0: "NZ", 0xC8: "Z", 0xD0: "NC", 0xD8: "C"}.items():
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


alu_ops = {
    0x80: ("ADD", "ALU_OP_ADD"),
    0x88: ("ADC", "ALU_OP_ADC"),
    0x90: ("SUB", "ALU_OP_SUB"),
    0x98: ("SBC", "ALU_OP_SBC"),
    0xA0: ("AND", "ALU_OP_AND"),
    0xA8: ("XOR", "ALU_OP_XOR"),
    0xB0: ("OR", "ALU_OP_OR"),
    0xB8: ("CP", "ALU_OP_CP"),
}
for base, (mnemonic, op) in alu_ops.items():
    make_alu_op(base, op, f"{mnemonic} A,")

# INC/DEC r
for incdec in ("INC", "DEC"):
    for i, reg in enumerate(registers):
        if reg == "(HL)":
            opcode = 0x34 if incdec == "INC" else 0x35
            cycles = [
                {
                    "addr_src": "ADDR_HL",
                    "data_bus_src": "DATA_BUS_SRC_Z",
                    "data_bus_op": "DATA_BUS_OP_READ",
                    "alu_op": f"ALU_OP_{incdec}",
                    "alu_dst": "ALU_SRC_Z",
                    "alu_src": "ALU_SRC_NONE",
                },
                {
                    "addr_src": "ADDR_HL",
                    "data_bus_src": "DATA_BUS_SRC_Z",
                    "data_bus_op": "DATA_BUS_OP_WRITE",
                },
                {
                    "addr_src": "ADDR_PC",
                    "data_bus_op": "DATA_BUS_OP_READ",
                    "data_bus_src": "DATA_BUS_SRC_IR",
                    "idu_op": "IDU_OP_INC",
                },
            ]
            control_words[opcode] = cycles
            opcode_comments[opcode] = f"{incdec} (HL)"
        else:
            base = 0x04 if incdec == "INC" else 0x05
            opcode = base | (i << 3)
            cycles = [
                {
                    "addr_src": "ADDR_PC",
                    "data_bus_src": "DATA_BUS_SRC_IR",
                    "data_bus_op": "DATA_BUS_OP_READ",
                    "idu_op": "IDU_OP_INC",
                    "alu_op": f"ALU_OP_{incdec}",
                    "alu_dst": f"ALU_SRC_{reg}",
                    "alu_src": "ALU_SRC_NONE",
                }
            ]
            control_words[opcode] = cycles
            opcode_comments[opcode] = f"{incdec} {reg}"


reg_pairs = [
    ("BC", 0x02, 0x0A),
    ("DE", 0x12, 0x1A),
    ("HL+", 0x22, 0x2A),
    ("HL-", 0x32, 0x3A),
]

for pair, opcode_store, opcode_load in reg_pairs:
    base = pair.replace("+", "").replace("-", "")

    # LD (rr),A
    cycles_store = [
        {
            "addr_src": f"ADDR_{base}",
            "data_bus_src": "DATA_BUS_SRC_A",
            "data_bus_op": "DATA_BUS_OP_WRITE",
            "idu_op": (
                "IDU_OP_INC"
                if "+" in pair
                else "IDU_OP_DEC"
                if "-" in pair
                else "IDU_OP_NONE"
            ),
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
    ]
    control_words[opcode_store] = cycles_store
    opcode_comments[opcode_store] = f"LD ({pair}),A"

    # LD A,(rr)
    cycles_load = [
        {
            "addr_src": f"ADDR_{base}",
            "data_bus_src": "DATA_BUS_SRC_Z",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": (
                "IDU_OP_INC"
                if "+" in pair
                else "IDU_OP_DEC"
                if "-" in pair
                else "IDU_OP_NONE"
            ),
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
            "alu_op": "ALU_OP_COPY",
            "alu_dst": "ALU_SRC_A",
            "alu_src": "ALU_SRC_Z",
        },
    ]
    control_words[opcode_load] = cycles_load
    opcode_comments[opcode_load] = f"LD A,({pair})"


# LD (a16), SP
# Opcode 0x08
control_words[0x08] = [
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
        "addr_src": "ADDR_WZ",
        "data_bus_src": "DATA_BUS_SRC_SP_LOW",
        "data_bus_op": "DATA_BUS_OP_WRITE",
        "idu_op": "IDU_OP_INC",
    },
    {
        "addr_src": "ADDR_WZ",
        "data_bus_src": "DATA_BUS_SRC_SP_HIGH",
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
opcode_comments[0x08] = "LD (a16), SP"

# DI
opcode_comments[0xF3] = "DI"
control_words[0xF3] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "misc_op": "MISC_OP_IME_DISABLE",
    }
]

# EI
opcode_comments[0xFB] = "EI"
control_words[0xFB] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "misc_op": "MISC_OP_IME_ENABLE",
    }
]

for pair, base in {"BC": 0xC5, "DE": 0xD5, "HL": 0xE5, "AF": 0xF5}.items():
    hi, lo = ("A", "FLAGS") if pair == "AF" else (pair[0], pair[1])

    # PUSH
    control_words[base] = [
        {"addr_src": "ADDR_SP", "idu_op": "IDU_OP_DEC"},
        {
            "addr_src": "ADDR_SP",
            "data_bus_src": f"DATA_BUS_SRC_{hi}",
            "data_bus_op": "DATA_BUS_OP_WRITE",
            "idu_op": "IDU_OP_DEC",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_src": f"DATA_BUS_SRC_{lo}",
            "data_bus_op": "DATA_BUS_OP_WRITE",
        },
        NOP,
    ]
    opcode_comments[base] = f"PUSH {pair}"

    # POP
    control_words[base - 4] = [
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
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
            "misc_op": "MISC_OP_R16_WZ_COPY",
            "misc_op_dst": f"MISC_OP_DST_{pair}",
        },
    ]
    opcode_comments[base - 4] = f"POP {pair}"

# LD rr,d16 (16-bit immediate loads)
for pair, opcode in {"BC": 0x01, "DE": 0x11, "HL": 0x21, "SP": 0x31}.items():
    hi, lo = ("SPH", "SPL") if pair == "SP" else (pair[0].lower(), pair[1].lower())

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
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
            "misc_op": "MISC_OP_R16_WZ_COPY",
            "misc_op_dst": f"MISC_OP_DST_{pair}",
        },
    ]
    control_words[opcode] = cycles
    opcode_comments[opcode] = f"LD {pair},d16"

for name, opcode in {"RLCA": 0x07, "RRCA": 0x0F, "RLA": 0x17, "RRA": 0x1F}.items():
    control_words[opcode] = [
        {
            "addr_src": "ADDR_PC",
            "data_bus_op": "DATA_BUS_OP_READ",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "alu_op": f"ALU_OP_{name[:-1]}",
            "alu_src": "ALU_SRC_A",
            "alu_dst": "ALU_SRC_A",
            "idu_op": "IDU_OP_INC",
        }
    ]
    opcode_comments[opcode] = name

# INC/DEC rr
for i, pair in enumerate(["BC", "DE", "HL", "SP"]):
    # INC rr - opcodes 0x03, 0x13, 0x23, 0x33
    opcode_inc = 0x03 | (i << 4)
    cycles_inc = [
        {
            "addr_src": f"ADDR_{pair}",
            "data_bus_src": "DATA_BUS_SRC_NONE",
            "data_bus_op": "DATA_BUS_OP_NONE",
            "idu_op": "IDU_OP_INC",
        },
        NOP,
    ]
    control_words[opcode_inc] = cycles_inc
    opcode_comments[opcode_inc] = f"INC {pair}"

    # DEC rr - opcodes 0x0B, 0x1B, 0x2B, 0x3B
    opcode_dec = 0x0B | (i << 4)
    cycles_dec = [
        {
            "addr_src": f"ADDR_{pair}",
            "data_bus_src": "DATA_BUS_SRC_NONE",
            "data_bus_op": "DATA_BUS_OP_NONE",
            "idu_op": "IDU_OP_DEC",
        },
        control_words[0][0],
    ]
    control_words[opcode_dec] = cycles_dec
    opcode_comments[opcode_dec] = f"DEC {pair}"

# LD r, n8
for i, reg in enumerate(registers):
    if reg == "(HL)":
        control_words[0x36] = [
            {
                "addr_src": "ADDR_PC",
                "data_bus_src": "DATA_BUS_SRC_Z",
                "data_bus_op": "DATA_BUS_OP_READ",
                "idu_op": "IDU_OP_INC",
            },
            {
                "addr_src": "ADDR_HL",
                "data_bus_src": "DATA_BUS_SRC_Z",
                "data_bus_op": "DATA_BUS_OP_WRITE",
            },
            {
                "addr_src": "ADDR_PC",
                "data_bus_src": "DATA_BUS_SRC_IR",
                "data_bus_op": "DATA_BUS_OP_READ",
                "idu_op": "IDU_OP_INC",
            },
        ]
        opcode_comments[0x36] = "LD (HL), n8"
        continue

    opcode = 0x06 | (i << 3)
    cycles = [
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_Z",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
            "alu_op": "ALU_OP_COPY",
            "alu_dst": f"ALU_SRC_{reg}",
            "alu_src": "ALU_SRC_Z",
        },
    ]
    control_words[opcode] = cycles
    opcode_comments[opcode] = f"LD {reg}, n8"

# ADD HL, rr
for pair, opcode in {"BC": 0x09, "DE": 0x19, "HL": 0x29, "SP": 0x39}.items():
    HI, LO = ("SP_HIGH", "SP_LOW") if pair == "SP" else (pair[0], pair[1])
    cycles = [
        {
            "addr_src": "ADDR_NONE",
            "data_bus_op": "DATA_BUS_OP_NONE",
            "alu_op": "ALU_OP_ADD_LOW",
            "alu_dst": "ALU_SRC_L",
            "alu_src": f"ALU_SRC_{LO}",
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_op": "DATA_BUS_OP_READ",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "alu_op": "ALU_OP_ADD_HIGH",
            "alu_dst": "ALU_SRC_H",
            "alu_src": f"ALU_SRC_{HI}",
            "idu_op": "IDU_OP_INC",
        },
    ]
    control_words[opcode] = cycles
    opcode_comments[opcode] = f"ADD HL, {pair}"


def make_jr(control_words, opcode_comments, conditions):
    control_words[0x18] = [
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_Z",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        {
            "addr_src": "ADDR_NONE",
            "data_bus_op": "DATA_BUS_OP_NONE",
            "misc_op": "MISC_OP_JR_SIGNED",
        },
        NOP,
        None,
        None,
        None,
    ]
    opcode_comments[0x18] = "JR e"

    conditional_jr = {
        0x20: "NZ",
        0x28: "Z",
        0x30: "NC",
        0x38: "C",
    }

    for opcode, cond_name in conditional_jr.items():
        control_words[opcode] = [dict(c) if c else None for c in control_words[0x18]]
        control_words[opcode][0]["misc_op"] = "MISC_OP_COND_CHECK"
        control_words[opcode][0]["cond"] = conditions[cond_name]
        control_words[opcode][5] = NOP

        opcode_comments[opcode] = f"JR {cond_name}, e"


make_jr(control_words, opcode_comments, conditions)


def make_rst(vector):
    return [
        {
            "addr_src": "ADDR_SP",
            "idu_op": "IDU_OP_DEC",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_op": "DATA_BUS_OP_WRITE",
            "data_bus_src": "DATA_BUS_SRC_PC_HIGH",
            "idu_op": "IDU_OP_DEC",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_src": "DATA_BUS_SRC_PC_LOW",
            "data_bus_op": "DATA_BUS_OP_WRITE",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_src": "DATA_BUS_SRC_PC_LOW",
            "data_bus_op": "DATA_BUS_OP_WRITE",
            "misc_op": "MISC_OP_SET_PC_CONST",
        },
        NOP,
    ]


for i, opcode in enumerate(range(0xC7, 0x100, 0x08)):
    vector = i * 8
    control_words[opcode] = make_rst(vector)
    opcode_comments[opcode] = f"RST ${vector:02X}"

# SCF
control_words[0x37] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_op": "DATA_BUS_OP_READ",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "idu_op": "IDU_OP_INC",
        "alu_op": "ALU_OP_SCF",
    },
]
opcode_comments[0x37] = "SCF"

# CCF
control_words[0x3F] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_op": "DATA_BUS_OP_READ",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "idu_op": "IDU_OP_INC",
        "alu_op": "ALU_OP_CCF",
    },
]
opcode_comments[0x3F] = "CCF"

for opcode, mnemonic in {
    0xC6: "ADD",
    0xCE: "ADC",
    0xD6: "SUB",
    0xDE: "SBC",
    0xE6: "AND",
    0xEE: "XOR",
    0xF6: "OR",
    0xFE: "CP",
}.items():
    control_words[opcode] = [
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_Z",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
        },
        {
            "addr_src": "ADDR_PC",
            "data_bus_src": "DATA_BUS_SRC_IR",
            "data_bus_op": "DATA_BUS_OP_READ",
            "idu_op": "IDU_OP_INC",
            "alu_op": f"ALU_OP_{mnemonic}",
            "alu_dst": "ALU_SRC_A",
            "alu_src": "ALU_SRC_Z",
        },
    ]
    opcode_comments[opcode] = f"{mnemonic} A, n8"

# LDH (a8), A  (opcode E0)
# Writes A to address (0xFF00 + immediate)
control_words[0xE0] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_Z",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
    },
    {
        "addr_src": "ADDR_FF_Z",
        "data_bus_src": "DATA_BUS_SRC_A",
        "data_bus_op": "DATA_BUS_OP_WRITE",
    },
    NOP,
]
opcode_comments[0xE0] = "LDH (a8), A"

# LDH A, (a8)  (opcode F0)
# Reads from (0xFF00 + immediate) into A
control_words[0xF0] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_Z",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
    },
    {
        "addr_src": "ADDR_FF_Z",  # 0xFF00 + Z
        "data_bus_src": "DATA_BUS_SRC_Z",
        "data_bus_op": "DATA_BUS_OP_READ",
    },
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "alu_op": "ALU_OP_COPY",
        "alu_dst": "ALU_SRC_A",
        "alu_src": "ALU_SRC_Z",
    },
]
opcode_comments[0xF0] = "LDH A, n"

# LD (C), A  (opcode E2)
# Writes A to (0xFF00 + C)
control_words[0xE2] = [
    {
        "addr_src": "ADDR_FF_C",
        "data_bus_src": "DATA_BUS_SRC_A",
        "data_bus_op": "DATA_BUS_OP_WRITE",
    },
    NOP,
]
opcode_comments[0xE2] = "LD (C), A"

# LD A, (C)  (opcode F2)
# Reads from (0xFF00 + C) into A
control_words[0xF2] = [
    {
        "addr_src": "ADDR_FF_C",  # 0xFF00 + C
        "data_bus_src": "DATA_BUS_SRC_Z",
        "data_bus_op": "DATA_BUS_OP_READ",
    },
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "data_bus_op": "DATA_BUS_OP_READ",
        "alu_op": "ALU_OP_COPY",
        "alu_dst": "ALU_SRC_A",
        "alu_src": "ALU_SRC_Z",
        "idu_op": "IDU_OP_INC",
    },
]
opcode_comments[0xF2] = "LD A, (C)"

control_words[0xEA] = [
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
        "addr_src": "ADDR_WZ",
        "data_bus_src": "DATA_BUS_SRC_A",
        "data_bus_op": "DATA_BUS_OP_WRITE",
    },
    NOP,
]
opcode_comments[0xEA] = "LD (nn), A"

control_words[0xE8] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_Z",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
    },
    {
        "addr_src": "ADDR_NONE",
        "data_bus_op": "DATA_BUS_OP_NONE",
        "alu_op": "ALU_OP_ADD_LOW",
        "alu_dst": "ALU_SRC_Z",
        "alu_src": "ALU_SRC_SP_LOW",
    },
    {
        "addr_src": "ADDR_NONE",
        "data_bus_op": "DATA_BUS_OP_NONE",
        "alu_op": "ALU_OP_ADD_SIGNED_HIGH",
        "alu_dst": "ALU_SRC_W",
        "alu_src": "ALU_SRC_SP_HIGH",
    },
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "misc_op": "MISC_OP_R16_WZ_COPY",
        "misc_op_dst": "MISC_OP_DST_SP",
    },
]

control_words[0x2F] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "alu_op": "ALU_OP_CPL",
        "alu_dst": "ALU_SRC_A",
        "alu_src": "ALU_SRC_A",
    }
]
opcode_comments[0x2F] = "CPL"

control_words[0x27] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_op": "DATA_BUS_OP_READ",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "idu_op": "IDU_OP_INC",
        "alu_op": "ALU_OP_DAA",
        "alu_dst": "ALU_SRC_A",
        "alu_src": "ALU_SRC_A",
    }
]
opcode_comments[0x27] = "DAA"

control_words[0xFA] = [
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
        "addr_src": "ADDR_WZ",
        "data_bus_src": "DATA_BUS_SRC_Z",
        "data_bus_op": "DATA_BUS_OP_READ",
    },
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "alu_op": "ALU_OP_COPY",
        "alu_dst": "ALU_SRC_A",
        "alu_src": "ALU_SRC_Z",
    },
]
opcode_comments[0xFA] = "LD A, (nn)"

control_words[0xF9] = [
    {
        "misc_op": "MISC_OP_SP_HL_COPY",
    },
    NOP,
]
opcode_comments[0xF9] = "LD SP, HL"

# LD HL, SP + e8
control_words[0xF8] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_Z",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "alu_op": "ALU_OP_ADD_LOW",
        "alu_dst": "ALU_SRC_Z",
        "alu_src": "ALU_SRC_SP_LOW",
    },
    {
        "addr_src": "ADDR_NONE",
        "data_bus_op": "DATA_BUS_OP_NONE",
        "alu_op": "ALU_OP_COPY",
        "alu_dst": "ALU_SRC_L",
        "alu_src": "ALU_SRC_Z",
    },
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "alu_op": "ALU_OP_ADD_SIGNED_HIGH",
        "alu_dst": "ALU_SRC_H",
        "alu_src": "ALU_SRC_SP_HIGH",
    },
]
opcode_comments[0xF8] = "LD HL, SP + e8"

control_words[0xE9] = [
    {
        "addr_src": "ADDR_HL",
        "data_bus_src": "DATA_BUS_SRC_Z",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "idu_dst": "ADDR_PC",
    },
]

# // TODO: Comment
control_words[0xD9] = [
    {
        "addr_src": "ADDR_SP",
        "data_bus_src": "DATA_BUS_SRC_Z",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "idu_dst": "ADDR_SP",
    },
    {
        "addr_src": "ADDR_SP",
        "data_bus_src": "DATA_BUS_SRC_W",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "idu_dst": "ADDR_SP",
        "misc_op": "MISC_OP_IME_ENABLE",
    },
    {"misc_op": "MISC_OP_R16_WZ_COPY", "misc_op_dst": "MISC_OP_DST_PC"},
    NOP,
]

# BIT
for b in range(8):
    for r_index, r in enumerate(registers):
        opcode = 0b01000000 | (b << 3) | r_index

        if r == "(HL)":
            # BIT b,(HL)
            cycles = [
                {
                    "addr_src": "ADDR_HL",
                    "data_bus_op": "DATA_BUS_OP_READ",
                    "data_bus_src": "DATA_BUS_SRC_Z",
                },
                {
                    "addr_src": "ADDR_PC",
                    "data_bus_op": "DATA_BUS_OP_READ",
                    "data_bus_src": "DATA_BUS_SRC_IR",
                    "idu_op": "IDU_OP_INC",
                    "alu_op": "ALU_OP_BIT",
                    "alu_dst": "ALU_SRC_NONE",
                    "alu_src": "ALU_SRC_Z",
                    "alu_bit": f"ALU_BIT_{b}",
                },
            ]

        else:
            # BIT b,r
            cycles = [
                {
                    "addr_src": "ADDR_PC",
                    "data_bus_op": "DATA_BUS_OP_READ",
                    "data_bus_src": "DATA_BUS_SRC_IR",
                    "idu_op": "IDU_OP_INC",
                    "alu_op": "ALU_OP_BIT",
                    "alu_dst": "ALU_SRC_NONE",
                    "alu_src": f"ALU_SRC_{r}",
                    "alu_bit": f"ALU_BIT_{b}",
                }
            ]

        cb_control_words[opcode] = cycles
        cb_opcode_comments[opcode] = f"BIT {b}, {r}"

for alu_op_name, base_opcode in [
    ("ALU_OP_RES", 0b10000000),  # RES b,r
    ("ALU_OP_SET", 0b11000000),  # SET b,r
]:
    for b in range(8):
        for r_index, r in enumerate(registers):
            opcode = base_opcode | (b << 3) | r_index

            if r == "(HL)":
                cycles = [
                    {
                        "addr_src": "ADDR_HL",
                        "data_bus_op": "DATA_BUS_OP_READ",
                        "data_bus_src": "DATA_BUS_SRC_Z",
                        "alu_op": alu_op_name,
                        "alu_dst": "ALU_SRC_Z",
                        "alu_src": "ALU_SRC_Z",
                        "alu_bit": f"ALU_BIT_{b}",
                    },
                    {
                        "addr_src": "ADDR_HL",
                        "data_bus_op": "DATA_BUS_OP_WRITE",
                        "data_bus_src": "DATA_BUS_SRC_Z",
                    },
                    NOP,
                ]
            else:
                cycles = [
                    {
                        "addr_src": "ADDR_PC",
                        "data_bus_op": "DATA_BUS_OP_READ",
                        "data_bus_src": "DATA_BUS_SRC_IR",
                        "idu_op": "IDU_OP_INC",
                        "alu_op": alu_op_name,
                        "alu_dst": f"ALU_SRC_{r}",
                        "alu_src": f"ALU_SRC_{r}",
                        "alu_bit": f"ALU_BIT_{b}",
                    }
                ]

            cb_control_words[opcode] = cycles
            cb_opcode_comments[opcode] = f"{alu_op_name[7:10]} {b}, {r}"


for op in (
    ("RLC", 0b000, "ALU_OP_RLC"),
    ("RRC", 0b001, "ALU_OP_RRC"),
    ("RL", 0b010, "ALU_OP_RL"),
    ("RR", 0b011, "ALU_OP_RR"),
    ("SLA", 0b100, "ALU_OP_SLA"),
    ("SRA", 0b101, "ALU_OP_SRA"),
    ("SWAP", 0b110, "ALU_OP_SWAP"),
    ("SRL", 0b111, "ALU_OP_SRL"),
):
    mnemonic, ybits, alu_op = op

    for r_index, r in enumerate(registers):
        opcode = (ybits << 3) | r_index  # CB second byte

        if r == "(HL)":
            cycles = [
                {
                    "addr_src": "ADDR_HL",
                    "data_bus_op": "DATA_BUS_OP_READ",
                    "data_bus_src": "DATA_BUS_SRC_Z",
                    "alu_op": alu_op,
                    "alu_dst": "ALU_SRC_Z",
                    "alu_src": "ALU_SRC_Z",
                },
                {
                    "addr_src": "ADDR_HL",
                    "data_bus_op": "DATA_BUS_OP_WRITE",
                    "data_bus_src": "DATA_BUS_SRC_Z",
                },
                NOP,
            ]
        else:
            cycles = [
                {
                    "addr_src": "ADDR_PC",
                    "data_bus_op": "DATA_BUS_OP_READ",
                    "data_bus_src": "DATA_BUS_SRC_IR",
                    "idu_op": "IDU_OP_INC",
                    "alu_op": alu_op,
                    "alu_dst": f"ALU_SRC_{r}",
                    "alu_src": f"ALU_SRC_{r}",
                }
            ]

        cb_control_words[opcode] = cycles
        cb_opcode_comments[opcode] = f"{mnemonic} {r}"

# CB prefix (opcode 0xCB)
control_words[0xCB] = [
    {
        "addr_src": "ADDR_PC",
        "data_bus_src": "DATA_BUS_SRC_IR",
        "data_bus_op": "DATA_BUS_OP_READ",
        "idu_op": "IDU_OP_INC",
        "misc_op": "MISC_OP_CB_PREFIX",
    }
]

opcode_comments[0xCB] = "PREFIX CB"


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


forced_cycle_counts = {
    0xC0: 5,  # RET NZ
    0xC8: 5,  # RET Z
    0xD0: 5,  # RET NC
    0xD8: 5,  # RET C
    0xC9: 4,  # RET
    0xD9: 4,  # RETI
}


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
    lines.append('`include "cpu/opcodes.svh"\n\n')
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

            if opcode in forced_cycle_counts:
                num_real = forced_cycle_counts[opcode]

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


def generate_cb_sv(cb_control_words, cb_opcode_comments) -> str:
    lines = []
    lines.append("`ifndef CB_CONTROL_WORDS_SV\n`define CB_CONTROL_WORDS_SV\n")
    lines.append('`include "cpu/opcodes.svh"\n\n')
    lines.append("localparam control_word_t cb_control_words [0:255] = '{\n")

    for opcode in range(256):
        cycles = cb_control_words[opcode]
        comment = cb_opcode_comments.get(opcode, "UNDEFINED")
        comment_str = f" {comment}"

        lines.append(f"    'h{opcode:02X}: '{{  //{comment_str}\n")

        if cycles:
            num_real = count_real_cycles(cycles)

            lines.append(f"        num_cycles : 3'd{num_real},\n")
            lines.append("         cycles : '{\n")

            for i in range(MAX_CYCLES):
                is_last = i == MAX_CYCLES - 1
                entry = cycles[i] if i < len(cycles) else None
                lines.append(sv_literal(i, entry, is_last))

            lines.append("        }\n    }")
        else:
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

    lines.append("};\n`endif // CB_CONTROL_WORDS_SV\n")
    return "".join(lines)


output_path = "vemu/src/cpu/control_words.svh"
with open(output_path, "w", newline="\n") as f:
    f.write(generate_sv(control_words, opcode_comments))

output_path_cb = "vemu/src/cpu/cb_control_words.svh"
with open(output_path_cb, "w", newline="\n") as f:
    f.write(generate_cb_sv(cb_control_words, cb_opcode_comments))

interrupt_vectors = {
    0: "VBLANK",
    1: "STAT",
    2: "TIMER",
    3: "SERIAL",
    4: "JOYPAD",
}

interrupt_words = {}


def make_interrupt_word(index):
    return [
        {
            "addr_src": "ADDR_SP",
            "idu_op": "IDU_OP_DEC",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_op": "DATA_BUS_OP_WRITE",
            "data_bus_src": "DATA_BUS_SRC_PC_HIGH",
            "idu_op": "IDU_OP_DEC",
        },
        {
            "addr_src": "ADDR_SP",
            "data_bus_op": "DATA_BUS_OP_WRITE",
            "data_bus_src": "DATA_BUS_SRC_PC_LOW",
            "misc_op": "MISC_OP_SET_PC_INTERRUPT_VEC",
            "misc_op_dst": f"misc_op_dst_t'(3'd{index})",
        },
        NOP,
        None,
        None,
    ]


# Populate interrupt_words dict
for index in range(5):
    interrupt_words[index] = make_interrupt_word(index)


def generate_interrupt_sv(interrupt_words):
    lines = []
    lines.append(
        "`ifndef INTERRUPT_CONTROL_WORDS_SV\n`define INTERRUPT_CONTROL_WORDS_SV\n"
    )
    lines.append('`include "cpu/opcodes.svh"\n\n')
    lines.append("localparam control_word_t interrupt_words [0:4] = '{\n")

    for index in range(5):
        cycles = interrupt_words[index]
        name = interrupt_vectors[index]

        lines.append(f"    {index}: '{{  // INTERRUPT {name}\n")
        lines.append(f"        num_cycles : 3'd4,\n")
        lines.append("         cycles : '{\n")

        for i in range(MAX_CYCLES):
            entry = cycles[i] if i < len(cycles) else None
            is_last = i == MAX_CYCLES - 1
            lines.append(sv_literal(i, entry, is_last))

        lines.append("        }\n    }")

        if index != 4:
            lines.append(",\n")
        else:
            lines.append("\n")

    lines.append("};\n`endif // INTERRUPT_CONTROL_WORDS_SV\n")
    return "".join(lines)


output_path_int = "vemu/src/cpu/interrupt_control_words.svh"
with open(output_path_int, "w", newline="\n") as f:
    f.write(generate_interrupt_sv(interrupt_words))
