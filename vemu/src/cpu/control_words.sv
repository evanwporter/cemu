`ifndef CONTROL_WORDS_SV
`define CONTROL_WORDS_SV
`include "cpu/opcodes.sv"

localparam control_word_t control_words [0:255] = '{
    'h00: '{  //  NOP
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
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
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h01: '{  //  LD BC,d16
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
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
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_BC,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h02: '{  //  LD (BC),A
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_BC,
                data_bus_src : DATA_BUS_SRC_A,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h03: '{  //  INC BC
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_BC,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h04: '{  //  INC B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_INC,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h05: '{  //  DEC B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_DEC,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h06: '{  //  LD B, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h07: '{  //  RLCA
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
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h08: '{  //  LD (a16), SP
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_WZ,
                data_bus_src : DATA_BUS_SRC_SP_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_WZ,
                data_bus_src : DATA_BUS_SRC_SP_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
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
            4: '{  // M-cycle 5
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
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h09: '{  //  ADD HL, BC
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD_LOW,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_C,
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
                alu_op : ALU_OP_ADD_HIGH,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0A: '{  //  LD A,(BC)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_BC,
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0B: '{  //  DEC BC
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_BC,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0C: '{  //  INC C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_INC,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0D: '{  //  DEC C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_DEC,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0E: '{  //  LD C, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h0F: '{  //  RRCA
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
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h10: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h11: '{  //  LD DE,d16
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
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
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_DE,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h12: '{  //  LD (DE),A
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_DE,
                data_bus_src : DATA_BUS_SRC_A,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h13: '{  //  INC DE
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_DE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h14: '{  //  INC D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_INC,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h15: '{  //  DEC D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_DEC,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h16: '{  //  LD D, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h17: '{  //  RLA
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
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h18: '{  //  JR e
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_JR_SIGNED,
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
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h19: '{  //  ADD HL, DE
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD_LOW,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_E,
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
                alu_op : ALU_OP_ADD_HIGH,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h1A: '{  //  LD A,(DE)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_DE,
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h1B: '{  //  DEC DE
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_DE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h1C: '{  //  INC E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_INC,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h1D: '{  //  DEC E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_DEC,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h1E: '{  //  LD E, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h1F: '{  //  RRA
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
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h20: '{  //  JR NZ, e
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NZ
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_JR_SIGNED,
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
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: '{  // M-cycle 6
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
            }
        }
    },
    'h21: '{  //  LD HL,d16
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
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
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_HL,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h22: '{  //  LD (HL+),A
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_A,
                data_bus_op : DATA_BUS_OP_WRITE,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h23: '{  //  INC HL
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h24: '{  //  INC H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_INC,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h25: '{  //  DEC H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_DEC,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h26: '{  //  LD H, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h27: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h28: '{  //  JR Z, e
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_Z
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_JR_SIGNED,
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
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: '{  // M-cycle 6
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
            }
        }
    },
    'h29: '{  //  ADD HL, HL
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD_LOW,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
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
                alu_op : ALU_OP_ADD_HIGH,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2A: '{  //  LD A,(HL+)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2B: '{  //  DEC HL
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2C: '{  //  INC L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_INC,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2D: '{  //  DEC L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_DEC,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2E: '{  //  LD L, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h2F: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h30: '{  //  JR NC, e
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NC
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_JR_SIGNED,
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
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: '{  // M-cycle 6
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
            }
        }
    },
    'h31: '{  //  LD SP,d16
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
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
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_SP,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h32: '{  //  LD (HL-),A
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_A,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h33: '{  //  INC SP
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h34: '{  //  INC (HL)
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_INC,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_NONE,
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
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h35: '{  //  DEC (HL)
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_DEC,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_NONE,
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
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h36: '{  //  LD (HL), n8
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h37: '{  //  SCF
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SCF,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h38: '{  //  JR C, e
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_C
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_JR_SIGNED,
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
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: '{  // M-cycle 6
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
            }
        }
    },
    'h39: '{  //  ADD HL, SP
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD_LOW,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_SP_LOW,
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
                alu_op : ALU_OP_ADD_HIGH,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_SP_HIGH,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3A: '{  //  LD A,(HL-)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_DEC,
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3B: '{  //  DEC SP
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3C: '{  //  INC A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_INC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3D: '{  //  DEC A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_DEC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3E: '{  //  LD A, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h3F: '{  //  CCF
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_CCF,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h40: '{  //  LD B, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h41: '{  //  LD B, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h42: '{  //  LD B, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h43: '{  //  LD B, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h44: '{  //  LD B, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h45: '{  //  LD B, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h46: '{  //  LD B, (HL)
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h47: '{  //  LD B, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h48: '{  //  LD C, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h49: '{  //  LD C, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h4A: '{  //  LD C, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h4B: '{  //  LD C, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h4C: '{  //  LD C, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h4D: '{  //  LD C, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h4E: '{  //  LD C, (HL)
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h4F: '{  //  LD C, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h50: '{  //  LD D, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h51: '{  //  LD D, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h52: '{  //  LD D, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h53: '{  //  LD D, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h54: '{  //  LD D, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h55: '{  //  LD D, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h56: '{  //  LD D, (HL)
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h57: '{  //  LD D, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h58: '{  //  LD E, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h59: '{  //  LD E, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h5A: '{  //  LD E, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h5B: '{  //  LD E, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h5C: '{  //  LD E, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h5D: '{  //  LD E, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h5E: '{  //  LD E, (HL)
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h5F: '{  //  LD E, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h60: '{  //  LD H, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h61: '{  //  LD H, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h62: '{  //  LD H, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h63: '{  //  LD H, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h64: '{  //  LD H, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h65: '{  //  LD H, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h66: '{  //  LD H, (HL)
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h67: '{  //  LD H, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h68: '{  //  LD L, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h69: '{  //  LD L, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h6A: '{  //  LD L, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h6B: '{  //  LD L, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h6C: '{  //  LD L, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h6D: '{  //  LD L, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h6E: '{  //  LD L, (HL)
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h6F: '{  //  LD L, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h70: '{  //  LD (HL), B
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_B,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h71: '{  //  LD (HL), C
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_C,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h72: '{  //  LD (HL), D
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_D,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h73: '{  //  LD (HL), E
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_E,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h74: '{  //  LD (HL), H
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_H,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h75: '{  //  LD (HL), L
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_L,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h76: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h77: '{  //  LD (HL), A
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_A,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h78: '{  //  LD A, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h79: '{  //  LD A, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h7A: '{  //  LD A, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h7B: '{  //  LD A, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h7C: '{  //  LD A, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h7D: '{  //  LD A, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h7E: '{  //  LD A, (HL)
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h7F: '{  //  LD A, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h80: '{  //  ADD A, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h81: '{  //  ADD A, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h82: '{  //  ADD A, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h83: '{  //  ADD A, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h84: '{  //  ADD A, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h85: '{  //  ADD A, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h86: '{  //  ADD A, (HL)
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
                alu_op : ALU_OP_ADD,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h87: '{  //  ADD A, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h88: '{  //  ADC A, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h89: '{  //  ADC A, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8A: '{  //  ADC A, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8B: '{  //  ADC A, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8C: '{  //  ADC A, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8D: '{  //  ADC A, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8E: '{  //  ADC A, (HL)
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
                alu_op : ALU_OP_ADC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h8F: '{  //  ADC A, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h90: '{  //  SUB A, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SUB,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h91: '{  //  SUB A, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SUB,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h92: '{  //  SUB A, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SUB,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h93: '{  //  SUB A, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SUB,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h94: '{  //  SUB A, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SUB,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h95: '{  //  SUB A, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SUB,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h96: '{  //  SUB A, (HL)
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
                alu_op : ALU_OP_SUB,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h97: '{  //  SUB A, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SUB,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h98: '{  //  SBC A, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SBC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h99: '{  //  SBC A, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SBC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9A: '{  //  SBC A, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SBC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9B: '{  //  SBC A, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SBC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9C: '{  //  SBC A, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SBC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9D: '{  //  SBC A, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SBC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9E: '{  //  SBC A, (HL)
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
                alu_op : ALU_OP_SBC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'h9F: '{  //  SBC A, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SBC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA0: '{  //  AND A, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_AND,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA1: '{  //  AND A, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_AND,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA2: '{  //  AND A, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_AND,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA3: '{  //  AND A, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_AND,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA4: '{  //  AND A, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_AND,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA5: '{  //  AND A, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_AND,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA6: '{  //  AND A, (HL)
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
                alu_op : ALU_OP_AND,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA7: '{  //  AND A, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_AND,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA8: '{  //  XOR A, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_XOR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hA9: '{  //  XOR A, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_XOR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAA: '{  //  XOR A, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_XOR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAB: '{  //  XOR A, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_XOR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAC: '{  //  XOR A, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_XOR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAD: '{  //  XOR A, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_XOR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAE: '{  //  XOR A, (HL)
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
                alu_op : ALU_OP_XOR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hAF: '{  //  XOR A, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_XOR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB0: '{  //  OR A, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_OR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB1: '{  //  OR A, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_OR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB2: '{  //  OR A, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_OR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB3: '{  //  OR A, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_OR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB4: '{  //  OR A, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_OR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB5: '{  //  OR A, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_OR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB6: '{  //  OR A, (HL)
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
                alu_op : ALU_OP_OR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB7: '{  //  OR A, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_OR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB8: '{  //  CP A, B
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_CP,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_B,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hB9: '{  //  CP A, C
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_CP,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_C,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBA: '{  //  CP A, D
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_CP,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_D,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBB: '{  //  CP A, E
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_CP,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_E,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBC: '{  //  CP A, H
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_CP,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_H,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBD: '{  //  CP A, L
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_CP,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_L,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBE: '{  //  CP A, (HL)
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
                alu_op : ALU_OP_CP,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hBF: '{  //  CP A, A
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_CP,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC0: '{  //  RET NZ
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NZ
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_Z,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_W,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hC1: '{  //  POP BC
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_W,
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
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_BC,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC2: '{  //  JP NZ, nn
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NZ
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hC3: '{  //  JP nn
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC4: '{  //  CALL NZ, nn
        num_cycles : 3'd6,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NZ
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hC5: '{  //  PUSH BC
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_B,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_C,
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
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC6: '{  //  ADD A, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC7: '{  //  RST $00
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_SET_PC_CONST,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hC8: '{  //  RET Z
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_Z
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_Z,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_W,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hC9: '{  //  RET
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_W,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hCA: '{  //  JP Z, nn
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_Z
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hCB: '{  //  PREFIX CB
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_CB_PREFIX,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hCC: '{  //  CALL Z, nn
        num_cycles : 3'd6,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_Z
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hCD: '{  //  CALL nn
        num_cycles : 3'd6,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hCE: '{  //  ADC A, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hCF: '{  //  RST $08
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_SET_PC_CONST,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD0: '{  //  RET NC
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NC
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_Z,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_W,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hD1: '{  //  POP DE
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_W,
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
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_DE,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD2: '{  //  JP NC, nn
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NC
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hD3: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD4: '{  //  CALL NC, nn
        num_cycles : 3'd6,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NC
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hD5: '{  //  PUSH DE
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_D,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_E,
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
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD6: '{  //  SUB A, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SUB,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD7: '{  //  RST $10
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_SET_PC_CONST,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hD8: '{  //  RET C
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_C
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_Z,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_W,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hD9: '{  //  UNDEFINED
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_SP,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_W,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_SP,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_IME_ENABLE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hDA: '{  //  JP C, nn
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_C
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hDB: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hDC: '{  //  CALL C, nn
        num_cycles : 3'd6,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_COND_CHECK,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_C
            },
            2: '{  // M-cycle 3
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_PC,
                cond : COND_NONE
            },
            5: '{  // M-cycle 6
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
            }
        }
    },
    'hDD: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hDE: '{  //  SBC A, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_SBC,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hDF: '{  //  RST $18
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_SET_PC_CONST,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE0: '{  //  LDH (a8), A
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_WZ,
                data_bus_src : DATA_BUS_SRC_A,
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
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE1: '{  //  POP HL
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_W,
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
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_HL,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE2: '{  //  LD (C), A
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_WZ,
                data_bus_src : DATA_BUS_SRC_A,
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
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE3: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE4: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE5: '{  //  PUSH HL
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_H,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_L,
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
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE6: '{  //  AND A, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_AND,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE7: '{  //  RST $20
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_SET_PC_CONST,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE8: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hE9: '{  //  UNDEFINED
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_PC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hEA: '{  //  LD (nn), A
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_WZ,
                data_bus_src : DATA_BUS_SRC_A,
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
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hEB: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hEC: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hED: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hEE: '{  //  XOR A, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_XOR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hEF: '{  //  RST $28
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_SET_PC_CONST,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF0: '{  //  LDH A, n
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_FF_Z,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF1: '{  //  POP AF
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_W,
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
                misc_op : MISC_OP_R16_WZ_COPY,
                misc_op_dst : MISC_OP_DST_AF,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF2: '{  //  LD A, (C)
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_FF_C,
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
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF3: '{  //  DI
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_IME_DISABLE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF4: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF5: '{  //  PUSH AF
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_A,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_FLAGS,
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
            3: '{  // M-cycle 4
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
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF6: '{  //  OR A, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_OR,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF7: '{  //  RST $30
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_SET_PC_CONST,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF8: '{  //  LD HL, SP + e8
        num_cycles : 3'd3,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_ADD,
                alu_dst : ALU_SRC_Z,
                alu_src : ALU_SRC_SP_LOW,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_Z,
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
                alu_op : ALU_OP_ADD_SIGNED,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_SP_HIGH,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hF9: '{  //  LD SP, HL
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_NONE,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_SP_HL_COPY,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: '{  // M-cycle 2
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
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFA: '{  //  LD A, (nn)
        num_cycles : 3'd4,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_W,
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
            2: '{  // M-cycle 3
                addr_src : ADDR_WZ,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFB: '{  //  EI
        num_cycles : 3'd1,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_IME_ENABLE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            1: `DEFAULT_CYCLE,  // M-cycle 2
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFC: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFD: '{  //  UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFE: '{  //  CP A, n8
        num_cycles : 3'd2,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_Z,
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
            1: '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_CP,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_NONE,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            2: `DEFAULT_CYCLE,  // M-cycle 3
            3: `DEFAULT_CYCLE,  // M-cycle 4
            4: `DEFAULT_CYCLE,  // M-cycle 5
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    'hFF: '{  //  RST $38
        num_cycles : 3'd5,
        cycles : '{
            0: '{  // M-cycle 1
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_NONE,
                data_bus_op : DATA_BUS_OP_NONE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_HIGH,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_DEC,
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
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
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
            3: '{  // M-cycle 4
                addr_src : ADDR_SP,
                data_bus_src : DATA_BUS_SRC_PC_LOW,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_NONE,
                idu_dst : ADDR_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE,
                alu_bit : ALU_BIT_0,
                misc_op : MISC_OP_SET_PC_CONST,
                misc_op_dst : MISC_OP_DST_NONE,
                cond : COND_NONE
            },
            4: '{  // M-cycle 5
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
            5: `DEFAULT_CYCLE  // M-cycle 6
        }
    }
};
`endif // CONTROL_WORDS_SV
