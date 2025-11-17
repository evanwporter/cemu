`ifndef MMU_INTERFACE_SV
`define MMU_INTERFACE_SV 

interface Bus_if;
  logic [15:0] addr;
  logic [ 7:0] wdata;
  logic [ 7:0] rdata;
  logic        read_en;
  logic        write_en;

  // The CPU is the bus master: it drives addr/wdata/read/write_en
  modport CPU_side(output addr, wdata, read_en, write_en, input rdata);

  // The MMU is a router: it reads CPU’s signals, passes them along,
  // and gathers rdata from peripherals
  modport MMU_side(input addr, wdata, read_en, write_en, output rdata);

  // Second part of the MMU.
  modport MMU_master(output addr, wdata, read_en, write_en, input rdata);

  // Peripherals (PPU/APU/etc.) are slaves: they listen to addr, write_en/read_en,
  // and drive rdata when selected.
  modport Peripheral_side(input addr, wdata, read_en, write_en, output rdata);
endinterface

interface Interrupt_if;

  // Hardware source requests — one bit per interrupt
  logic vblank_req;
  logic stat_req;
  logic timer_req;
  logic serial_req;
  logic joypad_req;

  // MMU updates IF_reg through this modport
  modport MMU_side(
      input vblank_req,
      input stat_req,
      input timer_req,
      input serial_req,
      input joypad_req
  );

  // Hardware modules only set bits
  modport Source_side(
      output vblank_req,
      output stat_req,
      output timer_req,
      output serial_req,
      output joypad_req
  );

endinterface

`endif
