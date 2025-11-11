`ifndef MMU_interface
`define MMU_interface 

interface BusIF;
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

  // Peripherals (PPU/APU/etc.) are slaves: they listen to addr, write_en/read_en,
  // and drive rdata when selected.
  modport Peripheral_side(input addr, wdata, read_en, write_en, output rdata);
endinterface

`endif
