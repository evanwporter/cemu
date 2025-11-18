#include <gtest/gtest.h>
#include <verilated.h>

#include <Vcartridge_cpu_top.h>
#include <Vcartridge_cpu_top___024root.h>

#include "util.hpp"

vluint64_t global_timestamp = 0;

TEST(CartridgeIntegrationTest, BootRomDisablesItself) {
    VerilatedContext ctx;
    Vcartridge_cpu_top top(&ctx);

    reset_dut(top, ctx);

    const uint64_t max_cycles = 500'000;
    bool boot_disabled = false;

    for (uint64_t cycle = 0; cycle < max_cycles; cycle++) {
        tick(top, ctx);

        // Boot ROM is active when boot_switch_out != 1
        if (top.rootp->cartridge_cpu_top__DOT__cart_inst__DOT__boot_rom_switch == 1) {
            boot_disabled = true;
            printf("Boot ROM disabled at cycle %llu, PC=%04X\n", cycle, (unsigned)top.pc_out);
            break;
        }
    }

    EXPECT_TRUE(boot_disabled)
        << "CPU never wrote 0x01 to FF50";
}
