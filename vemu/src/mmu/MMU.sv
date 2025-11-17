`ifndef MMU_SV
`define MMU_SV 

`include "mmu/util.sv"
`include "mmu/interface.sv"
`include "mmu/addresses.sv"

`include "ppu/types.sv"

module MMU (
    input logic clk,
    input logic reset,

    Bus_if.MMU_side cpu_bus,
    Bus_if.MMU_master ppu_bus,
    Bus_if.MMU_master apu_bus,
    Bus_if.MMU_master cart_bus,
    Bus_if.MMU_master ram_bus,
    Interrupt_if.MMU_side IF_bus
);

  logic [7:0] IF;

  assign ppu_bus.addr  = cpu_bus.addr;
  assign apu_bus.addr  = cpu_bus.addr;

  assign ppu_bus.wdata = cpu_bus.wdata;
  assign apu_bus.wdata = cpu_bus.wdata;

  // PPU VRAM: $8000–$9FFF, OAM: $FE00–$FE9F, PPU I/O: $FF40–$FF4B
  wire ppu_selected =
       (cpu_bus.addr inside {[VRAM_start : VRAM_end]})  ||
       (cpu_bus.addr inside {[OAM_start : OAM_end]})   ||
       (cpu_bus.addr inside {[PPU_regs_start : PPU_regs_end]});
  assign ppu_bus.read_en  = cpu_bus.read_en && ppu_selected;
  assign ppu_bus.write_en = cpu_bus.write_en && ppu_selected;

  // APU I/O: $FF10–$FF3F
  wire apu_selected = cpu_bus.addr inside {[AUDIO_addr_start : AUDIO_addr_end]};
  assign apu_bus.read_en  = cpu_bus.read_en && apu_selected;
  assign apu_bus.write_en = cpu_bus.write_en && apu_selected;

  // Cartridge ROM: $0000–$7FFF, Cartridge RAM: $A000–$BFFF
  wire cart_selected = (cpu_bus.addr inside {[ROM_start : ROM_end]}) || (cpu_bus.addr == 16'hFF50);
  assign cart_bus.read_en  = cpu_bus.read_en && cart_selected;
  assign cart_bus.write_en = cpu_bus.write_en && cart_selected;

  // RAM
  wire ram_selected = (cpu_bus.addr inside {[WRAM_start : Echo_RAM_end]}) ||
                      (cpu_bus.addr inside {[HRAM_start : HRAM_end]});
  assign ram_bus.read_en  = cpu_bus.read_en && ram_selected;
  assign ram_bus.write_en = cpu_bus.write_en && ram_selected;

  // Map Read Data
  always_comb begin
    cpu_bus.rdata = 8'h00;

    if (ppu_selected) begin
      cpu_bus.rdata = ppu_bus.rdata;

    end else if (apu_selected) begin
      cpu_bus.rdata = apu_bus.rdata;

    end else if (cart_selected) begin
      cpu_bus.rdata = cart_bus.rdata;

    end else if (ram_selected) begin
      cpu_bus.rdata = ram_bus.rdata;

    end else begin
      // TODO
    end
  end

  always_ff @(posedge clk) begin
    if (reset) begin
      IF <= 8'b11100000;
    end else begin
      // CPU writing IF
      if (cpu_bus.write_en && cpu_bus.addr == 16'hFF0F) begin
        IF <= (cpu_bus.wdata & 8'b00011111) | 8'b11100000;
      end

      // Hardware interrupt sources only SET bits
      if (IF_bus.vblank_req) IF[0] <= 1'b1;
      if (IF_bus.stat_req) IF[1] <= 1'b1;
      if (IF_bus.timer_req) IF[2] <= 1'b1;
      if (IF_bus.serial_req) IF[3] <= 1'b1;
      if (IF_bus.joypad_req) IF[4] <= 1'b1;
    end
  end


endmodule

`endif  // MMU_SV
