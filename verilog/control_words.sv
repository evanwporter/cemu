`ifndef CONTROL_WORDS_SV
`define CONTROL_WORDS_SV
`include "opcodes.sv"

localparam control_word_t control_words [0:255] = '{
    8'h00: '{  // UNDEFINED
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
    8'h01: '{  // UNDEFINED
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
    8'h02: '{  // UNDEFINED
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
    8'h03: '{  // UNDEFINED
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
    8'h04: '{  // UNDEFINED
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
    8'h05: '{  // UNDEFINED
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
    8'h06: '{  // UNDEFINED
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
    8'h07: '{  // UNDEFINED
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
    8'h08: '{  // UNDEFINED
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
    8'h09: '{  // UNDEFINED
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
    8'h0A: '{  // UNDEFINED
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
    8'h0B: '{  // UNDEFINED
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
    8'h0C: '{  // UNDEFINED
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
    8'h0D: '{  // UNDEFINED
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
    8'h0E: '{  // UNDEFINED
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
    8'h0F: '{  // UNDEFINED
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
    8'h10: '{  // UNDEFINED
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
    8'h11: '{  // UNDEFINED
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
    8'h12: '{  // UNDEFINED
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
    8'h13: '{  // UNDEFINED
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
    8'h14: '{  // UNDEFINED
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
    8'h15: '{  // UNDEFINED
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
    8'h16: '{  // UNDEFINED
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
    8'h17: '{  // UNDEFINED
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
    8'h18: '{  // UNDEFINED
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
    8'h19: '{  // UNDEFINED
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
    8'h1A: '{  // UNDEFINED
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
    8'h1B: '{  // UNDEFINED
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
    8'h1C: '{  // UNDEFINED
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
    8'h1D: '{  // UNDEFINED
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
    8'h1E: '{  // UNDEFINED
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
    8'h1F: '{  // UNDEFINED
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
    8'h20: '{  // UNDEFINED
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
    8'h21: '{  // UNDEFINED
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
    8'h22: '{  // UNDEFINED
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
    8'h23: '{  // UNDEFINED
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
    8'h24: '{  // UNDEFINED
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
    8'h25: '{  // UNDEFINED
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
    8'h26: '{  // UNDEFINED
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
    8'h27: '{  // UNDEFINED
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
    8'h28: '{  // UNDEFINED
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
    8'h29: '{  // UNDEFINED
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
    8'h2A: '{  // UNDEFINED
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
    8'h2B: '{  // UNDEFINED
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
    8'h2C: '{  // UNDEFINED
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
    8'h2D: '{  // UNDEFINED
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
    8'h2E: '{  // UNDEFINED
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
    8'h2F: '{  // UNDEFINED
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
    8'h30: '{  // UNDEFINED
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
    8'h31: '{  // UNDEFINED
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
    8'h32: '{  // UNDEFINED
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
    8'h33: '{  // UNDEFINED
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
    8'h34: '{  // UNDEFINED
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
    8'h35: '{  // UNDEFINED
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
    8'h36: '{  // UNDEFINED
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
    8'h37: '{  // UNDEFINED
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
    8'h38: '{  // UNDEFINED
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
    8'h39: '{  // UNDEFINED
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
    8'h3A: '{  // UNDEFINED
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
    8'h3B: '{  // UNDEFINED
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
    8'h3C: '{  // UNDEFINED
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
    8'h3D: '{  // UNDEFINED
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
    8'h3E: '{  // UNDEFINED
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
    8'h3F: '{  // UNDEFINED
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
    8'h40: '{  // LD B, B
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_B
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h41: '{  // LD B, C
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_C
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h42: '{  // LD B, D
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_D
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h43: '{  // LD B, E
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_E
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h44: '{  // LD B, H
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_H
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h45: '{  // LD B, L
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_L
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h46: '{  // LD B, (HL)
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_Z
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h47: '{  // LD B, A
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_B,
                alu_src : ALU_SRC_A
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h48: '{  // LD C, B
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_B
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h49: '{  // LD C, C
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_C
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h4A: '{  // LD C, D
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_D
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h4B: '{  // LD C, E
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_E
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h4C: '{  // LD C, H
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_H
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h4D: '{  // LD C, L
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_L
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h4E: '{  // LD C, (HL)
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_Z
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h4F: '{  // LD C, A
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_C,
                alu_src : ALU_SRC_A
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h50: '{  // LD D, B
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_B
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h51: '{  // LD D, C
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_C
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h52: '{  // LD D, D
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_D
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h53: '{  // LD D, E
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_E
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h54: '{  // LD D, H
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_H
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h55: '{  // LD D, L
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_L
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h56: '{  // LD D, (HL)
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_Z
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h57: '{  // LD D, A
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_D,
                alu_src : ALU_SRC_A
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h58: '{  // LD E, B
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_B
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h59: '{  // LD E, C
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_C
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h5A: '{  // LD E, D
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_D
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h5B: '{  // LD E, E
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_E
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h5C: '{  // LD E, H
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_H
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h5D: '{  // LD E, L
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_L
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h5E: '{  // LD E, (HL)
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_Z
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h5F: '{  // LD E, A
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_E,
                alu_src : ALU_SRC_A
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h60: '{  // LD H, B
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_B
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h61: '{  // LD H, C
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_C
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h62: '{  // LD H, D
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_D
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h63: '{  // LD H, E
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_E
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h64: '{  // LD H, H
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_H
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h65: '{  // LD H, L
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_L
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h66: '{  // LD H, (HL)
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_Z
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h67: '{  // LD H, A
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_H,
                alu_src : ALU_SRC_A
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h68: '{  // LD L, B
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_B
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h69: '{  // LD L, C
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_C
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h6A: '{  // LD L, D
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_D
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h6B: '{  // LD L, E
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_E
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h6C: '{  // LD L, H
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_H
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h6D: '{  // LD L, L
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_L
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h6E: '{  // LD L, (HL)
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_Z
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h6F: '{  // LD L, A
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_L,
                alu_src : ALU_SRC_A
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h70: '{  // LD (HL), B
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_B,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h71: '{  // LD (HL), C
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_C,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h72: '{  // LD (HL), D
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_D,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h73: '{  // LD (HL), E
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_E,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h74: '{  // LD (HL), H
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_H,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h75: '{  // LD (HL), L
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_L,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h76: '{  // UNDEFINED
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
    8'h77: '{  // LD (HL), A
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_A,
                data_bus_op : DATA_BUS_OP_WRITE,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h78: '{  // LD A, B
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_B
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h79: '{  // LD A, C
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_C
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h7A: '{  // LD A, D
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_D
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h7B: '{  // LD A, E
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_E
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h7C: '{  // LD A, H
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_H
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h7D: '{  // LD A, L
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_L
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h7E: '{  // LD A, (HL)
        num_cycles : 3'd2,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_HL,
                data_bus_src : DATA_BUS_SRC_Z,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_NONE,
                alu_op : ALU_OP_NONE,
                alu_dst : ALU_SRC_NONE,
                alu_src : ALU_SRC_NONE
            },
            '{  // M-cycle 2
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_Z
            },
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h7F: '{  // LD A, A
        num_cycles : 3'd1,
        cycles : '{
            '{  // M-cycle 1
                addr_src : ADDR_PC,
                data_bus_src : DATA_BUS_SRC_IR,
                data_bus_op : DATA_BUS_OP_READ,
                idu_op : IDU_OP_INC,
                alu_op : ALU_OP_COPY,
                alu_dst : ALU_SRC_A,
                alu_src : ALU_SRC_A
            },
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    },
    8'h80: '{  // UNDEFINED
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
    8'h81: '{  // UNDEFINED
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
    8'h82: '{  // UNDEFINED
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
    8'h83: '{  // UNDEFINED
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
    8'h84: '{  // UNDEFINED
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
    8'h85: '{  // UNDEFINED
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
    8'h86: '{  // UNDEFINED
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
    8'h87: '{  // UNDEFINED
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
    8'h88: '{  // UNDEFINED
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
    8'h89: '{  // UNDEFINED
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
    8'h8A: '{  // UNDEFINED
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
    8'h8B: '{  // UNDEFINED
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
    8'h8C: '{  // UNDEFINED
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
    8'h8D: '{  // UNDEFINED
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
    8'h8E: '{  // UNDEFINED
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
    8'h8F: '{  // UNDEFINED
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
    8'h90: '{  // UNDEFINED
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
    8'h91: '{  // UNDEFINED
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
    8'h92: '{  // UNDEFINED
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
    8'h93: '{  // UNDEFINED
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
    8'h94: '{  // UNDEFINED
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
    8'h95: '{  // UNDEFINED
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
    8'h96: '{  // UNDEFINED
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
    8'h97: '{  // UNDEFINED
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
    8'h98: '{  // UNDEFINED
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
    8'h99: '{  // UNDEFINED
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
    8'h9A: '{  // UNDEFINED
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
    8'h9B: '{  // UNDEFINED
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
    8'h9C: '{  // UNDEFINED
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
    8'h9D: '{  // UNDEFINED
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
    8'h9E: '{  // UNDEFINED
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
    8'h9F: '{  // UNDEFINED
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
    8'hA0: '{  // UNDEFINED
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
    8'hA1: '{  // UNDEFINED
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
    8'hA2: '{  // UNDEFINED
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
    8'hA3: '{  // UNDEFINED
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
    8'hA4: '{  // UNDEFINED
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
    8'hA5: '{  // UNDEFINED
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
    8'hA6: '{  // UNDEFINED
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
    8'hA7: '{  // UNDEFINED
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
    8'hA8: '{  // UNDEFINED
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
    8'hA9: '{  // UNDEFINED
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
    8'hAA: '{  // UNDEFINED
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
    8'hAB: '{  // UNDEFINED
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
    8'hAC: '{  // UNDEFINED
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
    8'hAD: '{  // UNDEFINED
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
    8'hAE: '{  // UNDEFINED
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
    8'hAF: '{  // UNDEFINED
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
    8'hB0: '{  // UNDEFINED
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
    8'hB1: '{  // UNDEFINED
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
    8'hB2: '{  // UNDEFINED
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
    8'hB3: '{  // UNDEFINED
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
    8'hB4: '{  // UNDEFINED
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
    8'hB5: '{  // UNDEFINED
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
    8'hB6: '{  // UNDEFINED
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
    8'hB7: '{  // UNDEFINED
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
    8'hB8: '{  // UNDEFINED
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
    8'hB9: '{  // UNDEFINED
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
    8'hBA: '{  // UNDEFINED
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
    8'hBB: '{  // UNDEFINED
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
    8'hBC: '{  // UNDEFINED
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
    8'hBD: '{  // UNDEFINED
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
    8'hBE: '{  // UNDEFINED
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
    8'hBF: '{  // UNDEFINED
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
    8'hC0: '{  // UNDEFINED
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
    8'hC1: '{  // UNDEFINED
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
    8'hC2: '{  // UNDEFINED
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
    8'hC3: '{  // UNDEFINED
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
    8'hC4: '{  // UNDEFINED
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
    8'hC5: '{  // UNDEFINED
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
    8'hC6: '{  // UNDEFINED
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
    8'hC7: '{  // UNDEFINED
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
    8'hC8: '{  // UNDEFINED
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
    8'hC9: '{  // UNDEFINED
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
    8'hCA: '{  // UNDEFINED
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
    8'hCB: '{  // UNDEFINED
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
    8'hCC: '{  // UNDEFINED
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
    8'hCD: '{  // UNDEFINED
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
    8'hCE: '{  // UNDEFINED
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
    8'hCF: '{  // UNDEFINED
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
    8'hD0: '{  // UNDEFINED
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
    8'hD1: '{  // UNDEFINED
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
    8'hD2: '{  // UNDEFINED
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
    8'hD3: '{  // UNDEFINED
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
    8'hD4: '{  // UNDEFINED
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
    8'hD5: '{  // UNDEFINED
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
    8'hD6: '{  // UNDEFINED
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
    8'hD7: '{  // UNDEFINED
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
    8'hD8: '{  // UNDEFINED
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
    8'hD9: '{  // UNDEFINED
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
    8'hDA: '{  // UNDEFINED
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
    8'hDB: '{  // UNDEFINED
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
    8'hDC: '{  // UNDEFINED
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
    8'hDD: '{  // UNDEFINED
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
    8'hDE: '{  // UNDEFINED
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
    8'hDF: '{  // UNDEFINED
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
    8'hE0: '{  // UNDEFINED
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
    8'hE1: '{  // UNDEFINED
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
    8'hE2: '{  // UNDEFINED
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
    8'hE3: '{  // UNDEFINED
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
    8'hE4: '{  // UNDEFINED
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
    8'hE5: '{  // UNDEFINED
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
    8'hE6: '{  // UNDEFINED
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
    8'hE7: '{  // UNDEFINED
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
    8'hE8: '{  // UNDEFINED
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
    8'hE9: '{  // UNDEFINED
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
    8'hEA: '{  // UNDEFINED
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
    8'hEB: '{  // UNDEFINED
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
    8'hEC: '{  // UNDEFINED
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
    8'hED: '{  // UNDEFINED
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
    8'hEE: '{  // UNDEFINED
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
    8'hEF: '{  // UNDEFINED
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
    8'hF0: '{  // UNDEFINED
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
    8'hF1: '{  // UNDEFINED
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
    8'hF2: '{  // UNDEFINED
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
    8'hF3: '{  // UNDEFINED
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
    8'hF4: '{  // UNDEFINED
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
    8'hF5: '{  // UNDEFINED
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
    8'hF6: '{  // UNDEFINED
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
    8'hF7: '{  // UNDEFINED
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
    8'hF8: '{  // UNDEFINED
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
    8'hF9: '{  // UNDEFINED
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
    8'hFA: '{  // UNDEFINED
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
    8'hFB: '{  // UNDEFINED
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
    8'hFC: '{  // UNDEFINED
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
    8'hFD: '{  // UNDEFINED
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
    8'hFE: '{  // UNDEFINED
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
    8'hFF: '{  // UNDEFINED
        num_cycles : 3'd0,
        cycles : '{
            `DEFAULT_CYCLE,  // M-cycle 1
            `DEFAULT_CYCLE,  // M-cycle 2
            `DEFAULT_CYCLE,  // M-cycle 3
            `DEFAULT_CYCLE,  // M-cycle 4
            `DEFAULT_CYCLE,  // M-cycle 5
            `DEFAULT_CYCLE  // M-cycle 6
        }
    }
};
`endif // CONTROL_WORDS_SV
