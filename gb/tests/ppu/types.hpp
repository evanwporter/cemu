#pragma once

#include <verilated.h>

#include "Vppu_top.h"

using vram_t = VlUnpacked<CData, 8192>;
using oam_t = VlUnpacked<CData, 160>;
using ppu_regs_t = Vppu_top_ppu_regs_t__struct__0;