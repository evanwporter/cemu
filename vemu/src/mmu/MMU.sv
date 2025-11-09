`ifndef MMU_SV
`define MMU_SV 

`include "ppu/types.sv"
`include "mmu/util.sv"

module MMU (
    input logic clk,
    input logic reset,

    // CPU Bus interface
    input logic        cpu_req_read,
    input logic        cpu_req_write,
    input logic [15:0] cpu_addr_bus,
    inout logic [ 7:0] cpu_data_bus,

    // PPU Bus interface
    input  logic        ppu_req_read,
    input  logic [15:0] ppu_addr_bus,
    output logic [ 7:0] ppu_data_bus,

    input ppu_mode_t PPU_mode
);

  logic [7:0] memory[0:65535];

  // VRAM (8KB)
  logic [7:0] vram[0:8191];
  // OAM (160B)
  logic [7:0] oam[0:159];


  // Only drive when CPU requests a read
  always_comb begin
    if (is_cpu_blocked(cpu_addr_bus, PPU_mode)) begin
      // Blocked access
      cpu_data_bus = 8'hFF;
    end else if (cpu_req_read) begin
      cpu_data_bus = memory[cpu_addr_bus];
    end else begin
      cpu_data_bus = 'z;  // release bus otherwise
    end
  end

  // Writes occur on the rising clock edge
  always_ff @(posedge clk) begin
    if (reset) begin
      // clear memory or maybe just leave uninitialized
      // for (int i = 0; i < 65536; i++) memory[i] <= 8'h00;
    end else if (cpu_req_write && !is_cpu_blocked(cpu_addr_bus, PPU_mode)) begin
      memory[cpu_addr_bus] <= cpu_data_bus;
    end
  end

  always_comb begin
    unique case (ppu_addr_bus) inside
      [16'h8000 : 16'h9FFF]: ppu_data_bus = vram[ppu_addr_bus-16'h8000];
      [16'hFE00 : 16'hFE9F]: ppu_data_bus = oam[ppu_addr_bus-16'hFE00];
      default: ppu_data_bus = 8'h00;
    endcase
  end

endmodule

`endif  // MMU_SV
