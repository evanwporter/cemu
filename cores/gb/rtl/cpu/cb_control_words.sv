import gb_cpu_opcodes_pkg::*;

package gb_cpu_cb_control_words_pkg;

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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h08: '{  // RRC B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RRC,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h09: '{  // RRC C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RRC,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0A: '{  // RRC D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RRC,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0B: '{  // RRC E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RRC,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0C: '{  // RRC H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RRC,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0D: '{  // RRC L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RRC,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0E: '{  // RRC (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RRC,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0F: '{  // RRC A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RRC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h20: '{  // SLA B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SLA,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h21: '{  // SLA C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SLA,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h22: '{  // SLA D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SLA,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h23: '{  // SLA E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SLA,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h24: '{  // SLA H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SLA,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h25: '{  // SLA L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SLA,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h26: '{  // SLA (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SLA,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h27: '{  // SLA A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SLA,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h28: '{  // SRA B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRA,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h29: '{  // SRA C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRA,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2A: '{  // SRA D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRA,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2B: '{  // SRA E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRA,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2C: '{  // SRA H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRA,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2D: '{  // SRA L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRA,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2E: '{  // SRA (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRA,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2F: '{  // SRA A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRA,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h30: '{  // SWAP B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SWAP,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h31: '{  // SWAP C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SWAP,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h32: '{  // SWAP D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SWAP,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h33: '{  // SWAP E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SWAP,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h34: '{  // SWAP H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SWAP,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h35: '{  // SWAP L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SWAP,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h36: '{  // SWAP (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SWAP,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h37: '{  // SWAP A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SWAP,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h38: '{  // SRL B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRL,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h39: '{  // SRL C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRL,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3A: '{  // SRL D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRL,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3B: '{  // SRL E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRL,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3C: '{  // SRL H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRL,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3D: '{  // SRL L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRL,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3E: '{  // SRL (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRL,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3F: '{  // SRL A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SRL,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
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
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h80: '{  // RES 0, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h81: '{  // RES 0, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h82: '{  // RES 0, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h83: '{  // RES 0, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h84: '{  // RES 0, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h85: '{  // RES 0, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h86: '{  // RES 0, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h87: '{  // RES 0, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h88: '{  // RES 1, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h89: '{  // RES 1, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8A: '{  // RES 1, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8B: '{  // RES 1, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8C: '{  // RES 1, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8D: '{  // RES 1, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8E: '{  // RES 1, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_1,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8F: '{  // RES 1, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h90: '{  // RES 2, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h91: '{  // RES 2, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h92: '{  // RES 2, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h93: '{  // RES 2, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h94: '{  // RES 2, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h95: '{  // RES 2, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h96: '{  // RES 2, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_2,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h97: '{  // RES 2, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h98: '{  // RES 3, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h99: '{  // RES 3, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9A: '{  // RES 3, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9B: '{  // RES 3, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9C: '{  // RES 3, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9D: '{  // RES 3, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9E: '{  // RES 3, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_3,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9F: '{  // RES 3, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA0: '{  // RES 4, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA1: '{  // RES 4, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA2: '{  // RES 4, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA3: '{  // RES 4, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA4: '{  // RES 4, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA5: '{  // RES 4, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA6: '{  // RES 4, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_4,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA7: '{  // RES 4, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA8: '{  // RES 5, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA9: '{  // RES 5, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAA: '{  // RES 5, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAB: '{  // RES 5, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAC: '{  // RES 5, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAD: '{  // RES 5, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAE: '{  // RES 5, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_5,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAF: '{  // RES 5, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB0: '{  // RES 6, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB1: '{  // RES 6, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB2: '{  // RES 6, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB3: '{  // RES 6, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB4: '{  // RES 6, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB5: '{  // RES 6, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB6: '{  // RES 6, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_6,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB7: '{  // RES 6, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB8: '{  // RES 7, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB9: '{  // RES 7, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBA: '{  // RES 7, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBB: '{  // RES 7, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBC: '{  // RES 7, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBD: '{  // RES 7, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBE: '{  // RES 7, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_7,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBF: '{  // RES 7, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_RES,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC0: '{  // SET 0, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC1: '{  // SET 0, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC2: '{  // SET 0, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC3: '{  // SET 0, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC4: '{  // SET 0, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC5: '{  // SET 0, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC6: '{  // SET 0, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC7: '{  // SET 0, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC8: '{  // SET 1, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC9: '{  // SET 1, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hCA: '{  // SET 1, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hCB: '{  // SET 1, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hCC: '{  // SET 1, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hCD: '{  // SET 1, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hCE: '{  // SET 1, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_1,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hCF: '{  // SET 1, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_1,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD0: '{  // SET 2, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD1: '{  // SET 2, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD2: '{  // SET 2, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD3: '{  // SET 2, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD4: '{  // SET 2, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD5: '{  // SET 2, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD6: '{  // SET 2, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_2,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD7: '{  // SET 2, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_2,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD8: '{  // SET 3, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD9: '{  // SET 3, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hDA: '{  // SET 3, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hDB: '{  // SET 3, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hDC: '{  // SET 3, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hDD: '{  // SET 3, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hDE: '{  // SET 3, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_3,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hDF: '{  // SET 3, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_3,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE0: '{  // SET 4, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE1: '{  // SET 4, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE2: '{  // SET 4, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE3: '{  // SET 4, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE4: '{  // SET 4, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE5: '{  // SET 4, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE6: '{  // SET 4, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_4,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE7: '{  // SET 4, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_4,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE8: '{  // SET 5, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE9: '{  // SET 5, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hEA: '{  // SET 5, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hEB: '{  // SET 5, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hEC: '{  // SET 5, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hED: '{  // SET 5, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hEE: '{  // SET 5, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_5,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hEF: '{  // SET 5, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_5,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF0: '{  // SET 6, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF1: '{  // SET 6, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF2: '{  // SET 6, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF3: '{  // SET 6, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF4: '{  // SET 6, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF5: '{  // SET 6, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF6: '{  // SET 6, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_6,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF7: '{  // SET 6, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_6,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF8: '{  // SET 7, B
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF9: '{  // SET 7, C
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFA: '{  // SET 7, D
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFB: '{  // SET 7, E
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFC: '{  // SET 7, H
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFD: '{  // SET 7, L
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFE: '{  // SET 7, (HL)
        num_cycles : 3'd3,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_7,
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
                alu_bit : ALU_BIT_0,
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
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFF: '{  // SET 7, A
        num_cycles : 3'd1,
         cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SET,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_7,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: DEFAULT_CYCLE,  // M-cycle 2
            2: DEFAULT_CYCLE,  // M-cycle 3
            3: DEFAULT_CYCLE,  // M-cycle 4
            4: DEFAULT_CYCLE,  // M-cycle 5
            5: DEFAULT_CYCLE  // M-cycle 6
        }
    }
};
endpackage : gb_cpu_cb_control_words_pkg
