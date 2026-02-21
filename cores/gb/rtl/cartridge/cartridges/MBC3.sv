import gb_mmu_addresses_pkg::*;

package MBC3_pkg;
  localparam address_t RAM_enable_start = 16'h0000;
  localparam address_t RAM_enable_end = 16'h1FFF;

  localparam address_t ROM_bank_number_start = 16'h2000;
  localparam address_t ROM_bank_number_end = 16'h3FFF;

  localparam address_t RAM_bank_number_start = 16'h4000;
  localparam address_t RAM_bank_number_end = 16'h5FFF;

  localparam address_t LATCH_CLOCK_start = 16'h6000;
  localparam address_t LATCH_CLOCK_end = 16'h7FFF;

  typedef struct packed {
    /// RAM Enable Switch
    // Before using RAM must be enabled by writing 0x0A to address range 0x0000-0x1FFF
    logic RAM_enable;

    logic [6:0] ROM_bank_select;  // 7-bit ROM bank

    logic [1:0] RAM_bank_select;  // 0–3 only
  } mbc3_t;

  function automatic logic [8:0] get_rom_bank(mbc3_t mbc3);
    logic [8:0] bank;
    bank = {2'b00, mbc3.ROM_bank_select};

    // Bank 0 forbidden
    if (bank == 9'd0) bank = 9'd1;

    return bank;
  endfunction
endpackage : MBC3_pkg
