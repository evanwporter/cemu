`ifndef MMU_UTIL_SV
`define MMU_UTIL_SV 

`include "ppu/types.sv"

function automatic logic is_cpu_blocked(input [15:0] addr, input ppu_mode_t mode);
  unique case (mode)
    // PPU_MODE_3: Pixel transfer (VRAM and OAM blocked)
    PPU_MODE_3: begin
      if ((addr >= 16'h8000 && addr <= 16'h9FFF) ||  // VRAM
          (addr >= 16'hFE00 && addr <= 16'hFE9F))  // OAM
        return 1'b1;
    end

    // PPU_MODE_2: OAM scan (OAM blocked)
    PPU_MODE_2: begin
      if (addr >= 16'hFE00 && addr <= 16'hFE9F) return 1'b1;
    end

    default: ;  // Modes 0 and 1: always accessible
  endcase

  return 1'b0;
endfunction

`endif  // MMU_UTIL_SV
