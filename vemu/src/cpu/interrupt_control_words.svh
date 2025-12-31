`ifndef INTERRUPT_CONTROL_WORDS_SV
`define INTERRUPT_CONTROL_WORDS_SV
`include "cpu/opcodes.svh"

localparam control_word_t interrupt_words [0:4] = '{
    0: '{  // INTERRUPT VBLANK
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
                misc_op : MISC_OP_SET_PC_INTERRUPT_VEC,
                misc_op_dst : misc_op_dst_t'(3'd0),
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
    1: '{  // INTERRUPT STAT
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
                misc_op : MISC_OP_SET_PC_INTERRUPT_VEC,
                misc_op_dst : misc_op_dst_t'(3'd1),
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
    2: '{  // INTERRUPT TIMER
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
                misc_op : MISC_OP_SET_PC_INTERRUPT_VEC,
                misc_op_dst : misc_op_dst_t'(3'd2),
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
    3: '{  // INTERRUPT SERIAL
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
                misc_op : MISC_OP_SET_PC_INTERRUPT_VEC,
                misc_op_dst : misc_op_dst_t'(3'd3),
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
    4: '{  // INTERRUPT JOYPAD
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
                misc_op : MISC_OP_SET_PC_INTERRUPT_VEC,
                misc_op_dst : misc_op_dst_t'(3'd4),
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
    }
};
`endif // INTERRUPT_CONTROL_WORDS_SV
