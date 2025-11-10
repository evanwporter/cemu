`ifndef PPU_INTERFACE_SV
`define PPU_INTERFACE_SV 

interface PPU_MMU_IF;

  //--------------------------------------------------------------------
  // PPU <-> MMU : VRAM / OAM bus
  //--------------------------------------------------------------------
  // PPU makes read requests into MMU's VRAM or OAM
  logic        ppu_req_read;
  logic        ppu_req_write;
  logic [15:0] ppu_addr;
  logic [ 7:0] ppu_wdata;
  logic [ 7:0] ppu_rdata;

  //--------------------------------------------------------------------
  // MMU <-> PPU : Register bus
  //--------------------------------------------------------------------
  logic [15:0] reg_addr;

  // MMU makes register write requests into PPU
  logic        reg_write_en;
  logic [ 7:0] reg_wdata;

  // MMU reads register values from PPU
  logic [ 7:0] reg_rdata;
  logic        reg_read_en;

  //--------------------------------------------------------------------
  // Modports
  //--------------------------------------------------------------------
  modport MMU_side(
      // VRAM / OAM
      input ppu_req_read, ppu_req_write, ppu_addr, ppu_wdata,
      output ppu_rdata,

      // Registers
      output reg_write_en, reg_addr, reg_wdata, reg_read_en,
      input reg_rdata
  );

  modport PPU_side(
      // VRAM / OAM
      output ppu_req_read, ppu_req_write, ppu_addr, ppu_wdata,
      input ppu_rdata,

      // Registers
      input reg_write_en, reg_addr, reg_wdata, reg_read_en,
      output reg_rdata
  );

endinterface

`endif  // PPU_INTERFACE_SV
