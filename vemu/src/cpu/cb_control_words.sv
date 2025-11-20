`ifndef CB_CONTROL_WORDS_SV
`define CB_CONTROL_WORDS_SV
`include "cpu/opcodes.sv"

localparam control_word_t cb_control_words [0:255] = '{
    'h00: '{  // RLC B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RLC,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h01: '{  // RLC C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RLC,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h02: '{  // RLC D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RLC,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h03: '{  // RLC E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RLC,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h04: '{  // RLC H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RLC,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h05: '{  // RLC L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RLC,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h06: '{  // RLC (HL)
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RLC,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h07: '{  // RLC A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RLC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h08: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h09: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h0A: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h0B: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h0C: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h0D: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h0E: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h0F: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h10: '{  // RL B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RL,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h11: '{  // RL C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RL,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h12: '{  // RL D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RL,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h13: '{  // RL E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RL,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h14: '{  // RL H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RL,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h15: '{  // RL L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RL,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h16: '{  // RL (HL)
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RL,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h17: '{  // RL A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RL,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h18: '{  // RR B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RR,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h19: '{  // RR C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RR,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h1A: '{  // RR D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RR,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h1B: '{  // RR E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RR,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h1C: '{  // RR H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RR,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h1D: '{  // RR L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RR,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h1E: '{  // RR (HL)
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RR,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h1F: '{  // RR A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h20: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h21: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h22: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h23: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h24: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h25: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h26: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h27: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h28: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h29: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h2A: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h2B: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h2C: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h2D: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h2E: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h2F: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h30: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h31: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h32: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h33: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h34: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h35: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h36: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h37: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h38: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h39: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h3A: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h3B: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h3C: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h3D: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h3E: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h3F: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h40: '{  // BIT 0, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h41: '{  // BIT 0, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h42: '{  // BIT 0, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h43: '{  // BIT 0, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h44: '{  // BIT 0, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h45: '{  // BIT 0, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h46: '{  // BIT 0, (HL)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h47: '{  // BIT 0, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h48: '{  // BIT 1, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h49: '{  // BIT 1, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h4A: '{  // BIT 1, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h4B: '{  // BIT 1, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h4C: '{  // BIT 1, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h4D: '{  // BIT 1, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h4E: '{  // BIT 1, (HL)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h4F: '{  // BIT 1, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h50: '{  // BIT 2, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h51: '{  // BIT 2, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h52: '{  // BIT 2, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h53: '{  // BIT 2, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h54: '{  // BIT 2, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h55: '{  // BIT 2, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h56: '{  // BIT 2, (HL)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h57: '{  // BIT 2, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h58: '{  // BIT 3, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h59: '{  // BIT 3, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h5A: '{  // BIT 3, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h5B: '{  // BIT 3, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h5C: '{  // BIT 3, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h5D: '{  // BIT 3, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h5E: '{  // BIT 3, (HL)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h5F: '{  // BIT 3, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h60: '{  // BIT 4, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h61: '{  // BIT 4, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h62: '{  // BIT 4, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h63: '{  // BIT 4, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h64: '{  // BIT 4, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h65: '{  // BIT 4, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h66: '{  // BIT 4, (HL)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h67: '{  // BIT 4, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h68: '{  // BIT 5, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h69: '{  // BIT 5, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h6A: '{  // BIT 5, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h6B: '{  // BIT 5, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h6C: '{  // BIT 5, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h6D: '{  // BIT 5, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h6E: '{  // BIT 5, (HL)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h6F: '{  // BIT 5, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h70: '{  // BIT 6, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h71: '{  // BIT 6, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h72: '{  // BIT 6, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h73: '{  // BIT 6, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h74: '{  // BIT 6, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h75: '{  // BIT 6, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h76: '{  // BIT 6, (HL)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h77: '{  // BIT 6, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h78: '{  // BIT 7, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_B,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h79: '{  // BIT 7, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_C,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h7A: '{  // BIT 7, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_D,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h7B: '{  // BIT 7, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_E,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h7C: '{  // BIT 7, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_H,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h7D: '{  // BIT 7, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_L,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h7E: '{  // BIT 7, (HL)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_Z,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h7F: '{  // BIT 7, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_BIT,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_A,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h80: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h81: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h82: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h83: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h84: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h85: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h86: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h87: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h88: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h89: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h8A: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h8B: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h8C: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h8D: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h8E: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h8F: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h90: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h91: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h92: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h93: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h94: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h95: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h96: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h97: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h98: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h99: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h9A: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h9B: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h9C: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h9D: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h9E: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'h9F: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hA0: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hA1: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hA2: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hA3: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hA4: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hA5: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hA6: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hA7: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hA8: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hA9: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hAA: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hAB: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hAC: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hAD: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hAE: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hAF: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hB0: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hB1: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hB2: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hB3: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hB4: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hB5: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hB6: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hB7: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hB8: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hB9: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hBA: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hBB: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hBC: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hBD: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hBE: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hBF: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hC0: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hC1: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hC2: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hC3: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hC4: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hC5: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hC6: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hC7: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hC8: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hC9: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hCA: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hCB: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hCC: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hCD: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hCE: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hCF: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hD0: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hD1: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hD2: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hD3: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hD4: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hD5: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hD6: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hD7: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hD8: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hD9: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hDA: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hDB: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hDC: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hDD: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hDE: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hDF: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hE0: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hE1: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hE2: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hE3: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hE4: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hE5: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hE6: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hE7: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hE8: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hE9: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hEA: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hEB: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hEC: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hED: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hEE: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hEF: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hF0: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hF1: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hF2: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hF3: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hF4: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hF5: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hF6: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hF7: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hF8: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hF9: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hFA: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hFB: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hFC: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hFD: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hFE: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    },
    'hFF: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE  // M-cycle 5
        }
    }
};
`endif // CB_CONTROL_WORDS_SV
