import mmu_addresses_pkg::*;

package MBC1_pkg;
  localparam address_t RAM_enable_start = 16'h0000;
  localparam address_t RAM_enable_end = 16'h1FFF;

  localparam address_t ROM_bank_number_start = 16'h2000;
  localparam address_t ROM_bank_number_end = 16'h3FFF;

  localparam address_t RAM_bank_number_start = 16'h4000;
  localparam address_t RAM_bank_number_end = 16'h5FFF;

  localparam address_t ROM_RAM_mode_start = 16'h6000;
  localparam address_t ROM_RAM_mode_end = 16'h7FFF;

  // 16KiB per ROM bank
  localparam logic [16:0] ROM_bank_size = 16 * 1024;

  typedef struct packed {
    /// RAM Enable Switch
    // Before using RAM must be enabled by writing 0x0A to address range 0x0000-0x1FFF
    logic RAM_enable;

    logic [4:0] ROM_bank_select;
    logic [1:0] ROM_RAM_bank_select;

    logic bank_mode;

  } mbc1_t;

  function automatic logic [8:0] get_rom_bank(mbc1_t mbc1);
    logic [6:0] bank;

    if (mbc1.bank_mode == 1'b0) begin
      // ROM banking mode: use upper + lower bits
      bank = {mbc1.ROM_RAM_bank_select, mbc1.ROM_bank_select};
    end else begin
      // RAM banking mode: upper bits ignored
      bank = {2'b00, mbc1.ROM_bank_select};
    end

    // Bank 0 is forbidden, map to bank 1 instead
    if (bank[4:0] == 5'd0) bank[4:0] = 5'd1;

    return 9'(bank);
  endfunction
endpackage : MBC1_pkg
