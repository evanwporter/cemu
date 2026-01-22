`ifndef CARTRIDGE_SV
`define CARTRIDGE_SV 

import mmu_addresses_pkg::*;

`include "boot.svh"

`include "util/logger.svh"

module Cartridge (
    input logic clk,
    input logic reset,
    Bus_if.Slave_side bus
);

  /// Maximum ROM Size is 8 MiB
  // However only 32 KiB can be addressed at a time.
  localparam MAX_ROM_SIZE = 8 * 1024 * 1024;  // 8MiB

  /// Maximum RAM Size is 124 KiB
  // However only 8 KiB can be addressed at a time
  localparam MAX_RAM_SIZE = 124 * 1024;  // 124KiB

  localparam logic [9:0] MAX_ROM_BANKS = 512;

  localparam logic [14:0] ROM_BANK_SIZE = 16 * 1024;

  logic [7:0] ROM[MAX_ROM_SIZE];

  logic [7:0] boot_rom_switch;

  wire boot_rom_active = boot_rom_switch != 8'd1;

  wire boot_rom_selected = (bus.addr inside {[ROM_start : 8'h00FF]}) && boot_rom_active;
  wire rom_bank0_selected = (bus.addr inside {[16'h0000 : 16'h3FFF]});
  wire rom_selected = bus.addr inside {[ROM_start : ROM_end]};
  wire boot_switch_selected = bus.addr == 16'hFF50;

  MBC1_pkg::mbc1_t mbc1;

  // ======================================================
  // Determine Cartridge Type
  // ======================================================

  /// Cartridge Type
  typedef enum logic [2:0] {
    CARTRIDGE_ROM_ONLY,
    CARTRIDGE_MBC1,
    CARTRIDGE_MBC2
  } cartridge_type_t;

  cartridge_type_t cartridge_type;

  always_comb begin
    case (ROM[23'h0147])
      8'h00: cartridge_type = CARTRIDGE_ROM_ONLY;
      8'h01, 8'h02, 8'h03: cartridge_type = CARTRIDGE_MBC1;
      8'h05, 8'h06: cartridge_type = CARTRIDGE_MBC2;
      default: cartridge_type = CARTRIDGE_ROM_ONLY;
    endcase
  end

  logic [22:0] rom_index;

  logic [ 8:0] selected_rom_bank;

  always_comb begin
    case (cartridge_type)
      CARTRIDGE_ROM_ONLY: selected_rom_bank = 9'd1;
      CARTRIDGE_MBC1: selected_rom_bank = MBC1_pkg::get_rom_bank(mbc1);
      default: selected_rom_bank = 9'd1;
    endcase
  end

  // ======================================================
  // Determine ROM Size
  // ======================================================

  /// Size of ROM in Cartridge
  // Sizes are in binary (so KiB, MiB).
  // See: https://gbdev.io/pandocs/The_Cartridge_Header.html#0148--rom-size
  typedef enum logic [3:0] {
    ROM_SIZE_32KB,  // 2 banks
    ROM_SIZE_64KB,  // 4 banks
    ROM_SIZE_128KB,  // 8 banks
    ROM_SIZE_256KB,  // 16 banks
    ROM_SIZE_512KB,  // 32 banks
    ROM_SIZE_1MB,  // 64 banks
    ROM_SIZE_2MB,  // 128 banks
    ROM_SIZE_4MB,  // 256 banks
    ROM_SIZE_8MB  // 512 banks
  } rom_size_t;

  rom_size_t rom_size;

  always_comb begin
    case (ROM[23'h0148])
      8'h00:   rom_size = ROM_SIZE_32KB;
      8'h01:   rom_size = ROM_SIZE_64KB;
      8'h02:   rom_size = ROM_SIZE_128KB;
      8'h03:   rom_size = ROM_SIZE_256KB;
      8'h04:   rom_size = ROM_SIZE_512KB;
      8'h05:   rom_size = ROM_SIZE_1MB;
      8'h06:   rom_size = ROM_SIZE_2MB;
      8'h07:   rom_size = ROM_SIZE_4MB;
      8'h08:   rom_size = ROM_SIZE_8MB;
      default: rom_size = ROM_SIZE_32KB;
    endcase
  end

  // ======================================================
  // Determine RAM Size
  // ======================================================

  typedef enum logic [2:0] {
    RAM_SIZE_0KB,  // No RAM
    RAM_SIZE_UNUSED,
    RAM_SIZE_8KB,  // 1 bank
    RAM_SIZE_32KB,  // 4 banks
    RAM_SIZE_128KB,  // 16 banks
    RAM_SIZE_64KB  // 8 banks
  } ram_size_t;

  ram_size_t ram_size;

  always_comb begin
    case (ROM[23'h0149])
      8'h00:   ram_size = RAM_SIZE_0KB;
      8'h01:   ram_size = RAM_SIZE_UNUSED;
      8'h02:   ram_size = RAM_SIZE_8KB;
      8'h03:   ram_size = RAM_SIZE_32KB;
      8'h04:   ram_size = RAM_SIZE_128KB;
      8'h05:   ram_size = RAM_SIZE_64KB;
      default: ram_size = RAM_SIZE_0KB;
    endcase
  end

  // ======================================================
  // Read/Write Logic
  // ======================================================

  // Write
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      boot_rom_switch <= 8'd0;
      mbc1 <= '0;
      // $display("Cartridge Type: %s", cartridge_type);
    end else if (bus.write_en) begin
      if (rom_selected) begin
        case (cartridge_type)
          CARTRIDGE_ROM_ONLY: ;
          CARTRIDGE_MBC1: begin
            unique case (1'b1)
              // RAM Enable
              bus.addr inside {[MBC1_pkg::RAM_enable_start : MBC1_pkg::RAM_enable_end]} : begin
                mbc1.RAM_enable <= bus.wdata[3:0] == 4'hA;
              end

              // ROM Bank Number
              // Selects the ROM bank number for addresses 0x4000-0x7FFF
              bus.addr inside {[MBC1_pkg::ROM_bank_number_start : MBC1_pkg::ROM_bank_number_end]} : begin
                mbc1.ROM_bank_select <= bus.wdata[4:0];
              end

              // ROM/RAM Bank Number
              bus.addr inside {[MBC1_pkg::RAM_bank_number_start : MBC1_pkg::RAM_bank_number_end]} : begin
                mbc1.ROM_RAM_bank_select <= bus.wdata[1:0];
              end

              // Banking Mode Select
              bus.addr inside {[MBC1_pkg::ROM_RAM_mode_start : MBC1_pkg::ROM_RAM_mode_end]} : begin
                mbc1.bank_mode <= bus.wdata[0];
              end
            endcase
          end
          default: ;
        endcase
        // $display("Wrote to ROM at address 0x%h with data 0x%h, selected_bank 0x%h", bus.addr,
        //          bus.wdata, selected_rom_bank);
      end else if (boot_switch_selected) begin
        boot_rom_switch <= bus.wdata;
        `LOG_INFO(("Boot ROM disabled"))
      end
    end
  end

  // Read
  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en) begin
      if (boot_rom_selected) bus.rdata = BOOT_DMG[bus.addr[7:0]];
      else if (rom_bank0_selected) bus.rdata = ROM[23'(bus.addr)];
      else if (rom_selected) begin
        case (cartridge_type)
          CARTRIDGE_ROM_ONLY: bus.rdata = ROM[23'(bus.addr)];
          CARTRIDGE_MBC1: begin
            bus.rdata = ROM[23'(15'(selected_rom_bank)*ROM_BANK_SIZE)+23'(bus.addr-16'h4000)];
          end
          default: ;
        endcase
      end else if (boot_switch_selected) bus.rdata = boot_rom_switch;
    end
  end
endmodule

`endif
