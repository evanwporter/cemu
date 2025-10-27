function automatic void decode_read_sel(input reg_sel_t reg_sel,  //
                                        input cpu_regs_t regs,  //
                                        input logic [7:0] imm8, input logic [15:0] imm16,
                                        output logic [15:0] selected_val,
                                        output logic [15:0] mem_addr, output logic mem_read_req);

  // default values
  selected_val = 16'b0;
  mem_addr = 16'b0;

  // default no memory read
  mem_read_req = 1'b0;

  case (reg_sel)
    // Normal registers
    REG_A: selected_val = {8'h00, regs.a};
    REG_B: selected_val = {8'h00, regs.b};
    REG_C: selected_val = {8'h00, regs.c};
    REG_D: selected_val = {8'h00, regs.d};
    REG_E: selected_val = {8'h00, regs.e};
    REG_H: selected_val = {8'h00, regs.h};
    REG_L: selected_val = {8'h00, regs.l};

    REG_AF: selected_val = get_af(regs);
    REG_BC: selected_val = get_bc(regs);
    REG_DE: selected_val = get_de(regs);
    REG_HL: selected_val = get_hl(regs);
    REG_SP: selected_val = regs.sp;
    REG_PC: selected_val = regs.pc;

    // Memory-indirects
    REG_ADDR_HL: begin
      mem_addr     = get_hl(regs);
      mem_read_req = 1'b1;
    end

    REG_ADDR_BC: begin
      mem_addr     = get_bc(regs);
      mem_read_req = 1'b1;
    end

    REG_ADDR_DE: begin
      mem_addr     = get_de(regs);
      mem_read_req = 1'b1;
    end

    REG_ADDR_SP: begin
      mem_addr     = regs.sp;
      mem_read_req = 1'b1;
    end

    // Immediate address modes
    REG_ADDR_IMM8: begin
      // [0xFF00 + immediate byte]
      mem_addr = {8'hFF, immediate_data[7:0]};
      mem_read_req = 1'b1;
    end

    REG_ADDR_IMM16: begin
      // [(a16)]  — absolute address
      mem_addr = immediate_data16;
      mem_read_req = 1'b1;
    end

    default: ;
  endcase
endfunction

// Outputs 
// 
task automatic decode_write_sel(input logic write_enable, input reg_sel_t reg_sel,
                                input logic [15:0] new_val, input cpu_regs_t regs_in,
                                input logic [7:0] imm8, input logic [15:0] imm16,
                                output cpu_regs_t regs_out, output logic [15:0] mem_addr,
                                output logic [7:0] mem_data_out, output logic mem_write_req);

  if (write_enable) begin
    mem_addr = 16'b0;

    // Default no memory write
    mem_write_req <= 1'b0;

    case (reg_sel)
      // Normal registers
      REG_A: regs_out.a = new_val[7:0];
      REG_B: regs_out.b = new_val[7:0];
      REG_C: regs_out.c = new_val[7:0];
      REG_D: regs_out.d = new_val[7:0];
      REG_E: regs_out.e = new_val[7:0];
      REG_H: regs_out.h = new_val[7:0];
      REG_L: regs_out.l = new_val[7:0];

      // 16-bit pairs
      REG_AF: set_af(regs_out, new_val);
      REG_BC: set_bc(regs_out, new_val);
      REG_DE: set_de(regs_out, new_val);
      REG_HL: set_hl(regs_out, new_val);
      REG_SP: regs_out.sp = new_val;
      REG_PC: regs_out.pc = new_val;

      REG_HL: begin
        reg_h <= new_val[15:8];
        reg_l <= new_val[7:0];
      end
      REG_SP: reg_sp <= new_val;
      REG_PC: reg_pc <= new_val;

      // Memory-indirect registers
      REG_ADDR_HL: begin
        mem_addr = get_hl(regs_in);
        mem_data_out = new_val[7:0];
        mem_write_req = 1'b1;
      end
      REG_ADDR_BC: begin
        mem_addr = get_bc(regs_in);
        mem_data_out = new_val[7:0];
        mem_write_req = 1'b1;
      end
      REG_ADDR_DE: begin
        mem_addr = get_de(regs_in);
        mem_data_out = new_val[7:0];
        mem_write_req = 1'b1;
      end

      REG_ADDR_IMM8: begin
        mem_addr <= {8'hFF, immediate_data[7:0]};
        mem_data_out <= new_val[7:0];
        mem_write_req <= 1'b1;
      end

      REG_ADDR_IMM16: begin
        mem_addr <= immediate_data16;
        mem_data_out <= new_val[7:0];
        mem_write_req <= 1'b1;
      end
    endcase
  end
endtask
