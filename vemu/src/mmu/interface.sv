/// MMU bus interface
/// Connects CPU to MMU, and MMU to peripherals.
/// CPU <--> MMU <--> Peripherals
///     BUS       BUS
/// Most data between the CPU and peripherals flows through this bus.
interface Bus_if;
  logic [15:0] addr;
  logic [ 7:0] wdata;
  logic [ 7:0] rdata;
  logic        read_en;
  logic        write_en;

  /// Bus master/router master: this connects to the Peripherals, and passes
  /// the CPU signals along to them, as well as gathering rdata from the Peripherals
  modport Master_side(output addr, wdata, read_en, write_en, input rdata);

  /// Peripherals (PPU/APU/etc.) are slaves: they listen to addr, write_en/read_en,
  /// and drive rdata when selected.
  modport Slave_side(input addr, wdata, read_en, write_en, output rdata);

endinterface

interface Interrupt_if;

  /// VBlank interrupt request
  logic vblank_req;

  /// STAT interrupt request
  logic stat_req;

  /// Timer interrupt request
  logic timer_req;

  /// Serial interrupt request
  logic serial_req;

  /// Joypad interrupt request
  logic joypad_req;

  /// CPU collects interrupt requests and updates IF & IE 
  /// through this modport
  modport CPU_side(
      /// VBlank interrupt request
      input vblank_req,

      /// STAT interrupt request
      input stat_req,

      /// Timer interrupt request
      input timer_req,

      /// Serial interrupt request
      input serial_req,

      /// Joypad interrupt request
      input joypad_req
  );

  /// PPU sets vblank/stat requests
  modport PPU_side(output vblank_req, output stat_req);

  /// Timer sets timer request
  modport Timer_side(output timer_req);

  /// Serial sets serial request
  modport Serial_side(output serial_req);

  /// Input sets joypad request
  modport Input_side(output joypad_req);

endinterface

interface DMA_if;
  logic [15:0] addr;
  logic [ 7:0] wdata;
  logic [ 7:0] rdata;
  logic        read_en;
  logic        write_en;
  logic        active;

  /// The DMA is the bus master: it drives addr/wdata/read/write_en
  modport DMA_side(output addr, wdata, read_en, write_en, active, input rdata);

  // TODO: Explain what this modport is for
  modport MMU_side(input addr, wdata, read_en, write_en, active, output rdata);

endinterface
