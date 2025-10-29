import json
from pathlib import Path


def reg_sel(operand: dict) -> str:
    if operand is None:
        return "REG_NONE"

    name = operand.get("name", "").upper()

    immediate = operand.get("immediate")
    if immediate is None:
        raise ValueError("Operand missing 'immediate' field")

    # Means we are dealing with [HL]
    if not immediate:
        mapping = {
            "HL": "REG_ADDR_HL",
            "BC": "REG_ADDR_BC",
            "DE": "REG_ADDR_DE",
            "SP": "REG_ADDR_SP",
            "A8": "REG_ADDR_IMM8",
            "A16": "REG_ADDR_IMM16",
        }
        ret = mapping.get(name)
        if ret is None:
            raise ValueError(f"Invalid memory-indirect register: {name}")
        return ret

    mapping = {
        "A": "REG_A",
        "B": "REG_B",
        "C": "REG_C",
        "D": "REG_D",
        "E": "REG_E",
        "H": "REG_H",
        "L": "REG_L",
        "AF": "REG_AF",
        "BC": "REG_BC",
        "DE": "REG_DE",
        "HL": "REG_HL",
        "SP": "REG_SP",
        "PC": "REG_PC",
        "N16": "REG_IMM16",
        "N8": "REG_IMM8",
        "E8": "REG_IMM_S8",
        "A16": "REG_IMM16",
    }

    ret = mapping.get(name)

    if ret is None:
        raise ValueError(f"Invalid register name: {name}")

    return ret


def flag_update(flag: str, code: str) -> str:
    if code == "-":
        return "UNTOUCHED"
    if code == flag:
        return "SAME_FLAG"
    if code == "0":
        return "RESET"
    if code == "1":
        return "SET"

    raise ValueError(f"Invalid flag update code: {code}")


def parse_condition(cond_name: str):
    """Return cond_enable, cond_type, cond_value for conditional jumps."""
    cond_name = cond_name.upper()
    cond_map = {
        "NZ": ("1'b1", "2'b00", "1'b0"),
        "Z": ("1'b1", "2'b00", "1'b1"),
        "NC": ("1'b1", "2'b01", "1'b0"),
        "C": ("1'b1", "2'b01", "1'b1"),
    }
    return cond_map.get(cond_name, ("1'b0", "2'b00", "1'b0"))


def gen_ld_control_word(ops: list[dict]) -> dict:
    """
    Generate a control word for any LD instruction:
    """
    cw = {
        "src_sel": "REG_NONE",
        "dst_sel": "REG_NONE",
        "post_delta_t": "POST_NO_CHANGE",
    }

    # Parse operands
    dst_op = ops[0] if len(ops) > 0 else None
    src_op = ops[1] if len(ops) > 1 else None

    dst = reg_sel(dst_op)
    src = reg_sel(src_op)
    cw["dst_sel"] = dst
    cw["src_sel"] = src

    # Handle post increment/decrement (HL+ / HL-)
    if dst_op and dst_op.get("increment") and dst_op.get("decrement"):
        raise ValueError("Operand cannot have both increment and decrement")
    if src_op and src_op.get("increment") and src_op.get("decrement"):
        raise ValueError("Operand cannot have both increment and decrement")

    if dst_op and dst_op.get("increment"):
        cw["post_delta_t"] = "POST_INC"
    if dst_op and dst_op.get("decrement"):
        cw["post_delta_t"] = "POST_DEC"
    if src_op and src_op.get("increment"):
        cw["post_delta_t"] = "POST_INC"
    if src_op and src_op.get("decrement"):
        cw["post_delta_t"] = "POST_DEC"

    return cw


def gen_alu_control_word(mnem: str, ops: list[dict], flags: dict) -> dict:
    ALU_OPS = {
        "ADD": "ALU_ADD",
        "ADC": "ALU_ADD",
        "SUB": "ALU_SUB",
        "SBC": "ALU_SUB",
        "AND": "ALU_AND",
        "OR": "ALU_OR",
        "XOR": "ALU_XOR",
        "INC": "ALU_INC",
        "DEC": "ALU_DEC",
        "SRA": "ALU_SRA",
        "SRL": "ALU_SRL",
        "SLA": "ALU_SLA",
        "SWAP": "ALU_SWAP",
    }

    cw = {
        "src_sel": "REG_NONE",
        "dst_sel": "REG_NONE",
        "alu_op": ALU_OPS.get(mnem.upper(), "ALU_NONE"),
        "flag_zero": "UNTOUCHED",
        "flag_subtract": "UNTOUCHED",
        "flag_half_carry": "UNTOUCHED",
        "flag_carry": "UNTOUCHED",
    }

    dst_op = ops[0] if len(ops) > 0 else None
    src_op = ops[1] if len(ops) > 1 else None

    dst = reg_sel(dst_op)
    src = reg_sel(src_op)
    cw["dst_sel"] = dst
    cw["src_sel"] = src

    # Update flags from JSON flag descriptions
    for flag in ["Z", "N", "H", "C"]:
        key = {
            "Z": "flag_zero",
            "N": "flag_subtract",
            "H": "flag_half_carry",
            "C": "flag_carry",
        }[flag]
        cw[key] = flag_update(flag, flags.get(flag, "-"))

    return cw


# JR cond, e8
def gen_jr_control_word(ops: list[dict]) -> dict:
    # PC ← PC + e8

    # operand[0] = condition (NZ, Z, NC, C) or e8 if unconditional
    # operand[1] = e8 (the signed relative offset)
    cond_enable, cond_type, cond_value = ("1'b0", "2'b00", "1'b0")

    if len(ops) == 2 and ops[0].get("name", "").upper() in ("NZ", "Z", "NC", "C"):
        cond_enable, cond_type, cond_value = parse_condition(ops[0]["name"])

    cw = {
        "src_sel": "REG_IMM8",  # signed offset e8
        "dst_sel": "REG_PC",  # result goes into PC
        "alu_op": "ALU_ADD",  # PC = PC + e8
        "pc_load": "1'b1",
        "pc_src": "REG_PC",
        "cond_enable": cond_enable,
        "cond_type": cond_type,
        "cond_value": cond_value,
    }

    return cw


def gen_jp_control_word(ops: list[dict]) -> dict:
    cond_enable, cond_type, cond_value = ("1'b0", "2'b00", "1'b0")

    if len(ops) == 2 and ops[0]["name"].upper() in ("NZ", "Z", "NC", "C"):
        cond_enable, cond_type, cond_value = parse_condition(ops[0]["name"])
        target_op = ops[1]
    else:
        # JP a16 or JP (HL)
        target_op = ops[0]

    src = reg_sel(target_op)

    cw = {
        "src_sel": src,
        "dst_sel": "REG_PC",
        "alu_op": "ALU_NONE",
        "pc_load": "1'b1",
        "pc_src": "REG_NONE",
        "cond_enable": cond_enable,
        "cond_type": cond_type,
        "cond_value": cond_value,
    }

    return cw


def gen_rotate_control_word(mnem: str, ops: list[dict]) -> dict:
    """
    Generate control word for rotate / bit operations.
    Uses reg_sel() for operand decoding.
    """
    cw = {
        "src_sel": "REG_NONE",
        "dst_sel": "REG_NONE",
        "alu_op": "ALU_NONE",
        "rot_op": "ROT_NONE",
    }

    # Mapping to rot_op_t
    ROT_OPS = {
        "RLCA": "ROT_RLCA",
        "RLA": "ROT_RLA",
        "RRCA": "ROT_RRCA",
        "RRA": "ROT_RRA",
        "RLC": "ROT_RLC",
        "RRC": "ROT_RRC",
        "RL": "ROT_RL",
        "RR": "ROT_RR",
        "SLA": "ROT_SLA",
        "SRA": "ROT_SRA",
        "SWAP": "ROT_SWAP",
        "BIT": "ROT_BIT",
        "RES": "ROT_RES",
        "SET": "ROT_SET",
    }

    cw["rot_op"] = ROT_OPS[mnem]

    # BIT/RES/SET have two operands (bit number, target)
    if mnem in ("BIT", "RES", "SET") and len(ops) == 2:
        reg_op = ops[1]
        dst = reg_sel(reg_op)
        src = dst
        cw["src_sel"] = src
        cw["dst_sel"] = dst
    else:
        # Single operand or implicit A
        dst_op = ops[0] if len(ops) > 0 else None
        if dst_op:
            dst = reg_sel(dst_op)
        else:
            # For A-only ops (RLCA, RRCA, etc.)
            dst = "REG_A"
        cw["src_sel"] = dst
        cw["dst_sel"] = dst

    return cw


def handle_special_opcode(
    opcode_hex: str, mnem: str, ops: list[dict], flags: dict
) -> dict | None:
    """
    Handle opcodes with unique control behavior not covered by generic rules.
    """
    opcode_hex = opcode_hex.lower()
    mnem = mnem.upper()

    # Base template
    base = {
        "post_delta": "POST_NO_CHANGE",
        "src_sel": "REG_NONE",
        "dst_sel": "REG_NONE",
        "alu_op": "ALU_NONE",
        "pc_load": "1'b0",
        "pc_src": "REG_NONE",
        "sp_push": "1'b0",
        "sp_pop": "1'b0",
        "flag_zero": "UNTOUCHED",
        "flag_subtract": "UNTOUCHED",
        "flag_half_carry": "UNTOUCHED",
        "flag_carry": "UNTOUCHED",
        "cond_enable": "1'b0",
        "cond_type": "2'b00",
        "cond_value": "1'b0",
    }

    # LD HL, SP+e8
    # 0xF8
    if opcode_hex == "0xf8" or (
        mnem == "LD"
        and len(ops) == 2
        and ops[0]["name"].upper() == "HL"
        and "SP" in ops[1]["name"].upper()
    ):
        cw = base.copy()
        cw.update(
            {
                "src_sel": "REG_IMM8",
                "dst_sel": "REG_HL",
                "alu_op": "ALU_ADD",
                "flag_zero": "RESET",
                "flag_subtract": "RESET",
                "flag_half_carry": "SAME_FLAG",
                "flag_carry": "SAME_FLAG",
            }
        )
        return cw

    return None


def main():
    src_json = Path("./scripts/opcodes.json")
    dst_sv = Path("verilog/control_words.sv")

    with open(src_json) as f:
        table = json.load(f)["unprefixed"]

    default_cw = {
        "post_delta": "POST_NO_CHANGE",
        "src_sel": "REG_NONE",
        "dst_sel": "REG_NONE",
        "alu_op": "ALU_NONE",
        "rot_op": "ROT_NONE",
        "pc_load": "1'b0",
        "pc_src": "REG_NONE",
        "sp_push": "1'b0",
        "sp_pop": "1'b0",
        "flag_zero": "UNTOUCHED",
        "flag_subtract": "UNTOUCHED",
        "flag_half_carry": "UNTOUCHED",
        "flag_carry": "UNTOUCHED",
        "cond_enable": "1'b0",
        "cond_type": "2'b00",
        "cond_value": "1'b0",
    }

    # Pre-fill 256 empty slots
    rom = [default_cw.copy() for _ in range(256)]
    comments = ["UNDEFINED" for _ in range(256)]

    # Populate from JSON
    for opcode_hex, info in table.items():
        opcode = int(opcode_hex, 16)
        mnem = info.get("mnemonic", "").upper()
        ops = info.get("operands", [])
        flags = info.get("flags", {})

        special_cw = handle_special_opcode(opcode_hex, mnem, ops, flags)
        if special_cw is not None:
            cw = special_cw
        elif mnem == "LD":
            cw = gen_ld_control_word(ops)
        elif mnem in (
            "ADD",
            "ADC",
            "SUB",
            "SBC",
            "AND",
            "OR",
            "XOR",
            "INC",
            "DEC",
            "SRA",
            "SRL",
            "SLA",
            "SWAP",
        ):
            cw = gen_alu_control_word(mnem, ops, flags)
        elif mnem == "JP":
            cw = gen_jp_control_word(ops)
        elif mnem == "JR":
            cw = gen_jr_control_word(ops)
        elif mnem in ("RLCA", "RLA", "RRCA", "RRA"):
            cw = gen_rotate_control_word(mnem, ops)
        else:
            continue

        rom[opcode] = cw
        comments[opcode] = f"{mnem} {', '.join(o['name'] for o in ops)}"

    with open(dst_sv, "w") as out:
        out.write("// Auto-generated 256-entry control ROM\n\n")
        out.write("`ifndef CONTROL_ROM_SV\n")
        out.write("`define CONTROL_ROM_SV\n\n")
        out.write('`include "opcodes.sv"\n\n')
        out.write("control_word_t control_words[0:255] = '{\n")

        for i in range(256):
            cw = rom[i]
            out.write(f"  // 0x{i:02X}: {comments[i]}\n")
            out.write("  '{\n")

            keys = list(cw.keys())
            for j, k in enumerate(keys):
                v = cw[k]
                comma = "," if j < len(keys) - 1 else ""
                out.write(f"    {k}: {v}{comma}\n")

            out.write("  }")
            if i != 255:
                out.write(",\n\n")
            else:
                out.write("\n")

        out.write("};\n")

        out.write("\n`endif // CONTROL_ROM_SV\n")

    print(f"Generated {dst_sv}")


if __name__ == "__main__":
    main()
