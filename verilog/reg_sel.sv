function automatic void decode_read_sel(
    input reg_sel_t reg_sel,  // selected register
    input logic [7:0] reg_a, reg_b, reg_c, reg_d, reg_e, reg_h, reg_l,  // 8-bit registers
    input logic [15:0] reg_sp, reg_pc,  // 16-bit registers
    input logic [7:0] immediate_data, input logic [15:0] immediate_data16,
    output logic [15:0] selected_val, output logic [15:0] mem_addr, output logic mem_read_req);

  // default values
  selected_val = 16'b0;
  mem_addr = 16'b0;

  // default no memory read
  mem_read_req = 1'b0;

  case (reg_sel)
    // Normal registers
    REG_A:  selected_val = {8'h00, reg_a};
    REG_B:  selected_val = {8'h00, reg_b};
    REG_C:  selected_val = {8'h00, reg_c};
    REG_D:  selected_val = {8'h00, reg_d};
    REG_E:  selected_val = {8'h00, reg_e};
    REG_H:  selected_val = {8'h00, reg_h};
    REG_L:  selected_val = {8'h00, reg_l};
    REG_HL: selected_val = {reg_h, reg_l};
    REG_BC: selected_val = {reg_b, reg_c};
    REG_DE: selected_val = {reg_d, reg_e};
    REG_SP: selected_val = reg_sp;
    REG_PC: selected_val = reg_pc;

    // Memory-indirect registers
    REG_ADDR_HL: begin
      mem_addr = {reg_h, reg_l};
      mem_read_req = 1'b1;
    end

    REG_ADDR_BC: begin
      mem_addr = {reg_b, reg_c};
      mem_read_req = 1'b1;
    end

    REG_ADDR_DE: begin
      mem_addr = {reg_d, reg_e};
      mem_read_req = 1'b1;
    end

    REG_ADDR_SP: begin
      mem_addr = reg_sp;
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
task automatic decode_write_sel(
    input logic clk, input logic write_enable, input reg_sel_t reg_sel, input logic [15:0] new_val,
    inout logic [7:0] reg_a, reg_b, reg_c, reg_d, reg_e, reg_h, reg_l, inout logic [15:0] reg_sp,
    reg_pc, input logic [7:0] immediate_data, input logic [15:0] immediate_data16,
    output logic [15:0] mem_addr, output logic [7:0] mem_data_out, output logic mem_write_req);

  if (write_enable) begin
    mem_addr = 16'b0;

    // Default no memory write
    mem_write_req <= 1'b0;

    case (reg_sel)
      // Normal registers
      REG_A:  reg_a <= new_val[7:0];
      REG_B:  reg_b <= new_val[7:0];
      REG_C:  reg_c <= new_val[7:0];
      REG_D:  reg_d <= new_val[7:0];
      REG_E:  reg_e <= new_val[7:0];
      REG_H:  reg_h <= new_val[7:0];
      REG_L:  reg_l <= new_val[7:0];
      REG_HL: begin
        reg_h <= new_val[15:8];
        reg_l <= new_val[7:0];
      end
      REG_SP: reg_sp <= new_val;
      REG_PC: reg_pc <= new_val;

      // Memory-indirect registers
      REG_ADDR_HL: begin
        mem_addr <= {reg_h, reg_l};
        mem_data_out <= new_val[7:0];
        mem_write_req <= 1'b1;
      end

      REG_ADDR_BC: begin
        mem_addr <= {reg_b, reg_c};
        mem_data_out <= new_val[7:0];
        mem_write_req <= 1'b1;
      end

      REG_ADDR_DE: begin
        mem_addr <= {reg_d, reg_e};
        mem_data_out <= new_val[7:0];
        mem_write_req <= 1'b1;
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
