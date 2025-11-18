#include <Vcartridge_top.h>
#include <Vcartridge_top___024root.h>
#include <gtest/gtest.h>
#include <verilated.h>

#include "boot.hpp"
#include "util.hpp"

vluint64_t global_timestamp = 0;

// Helper to idle the CPU bus
static void cpu_idle(Vcartridge_top& top) {
    top.cpu_addr = 0;
    top.cpu_wdata = 0;
    top.cpu_read_en = 0;
    top.cpu_write_en = 0;
}

TEST(CartridgeTest, BootRomActiveAtReset) {
    VerilatedContext ctx;
    Vcartridge_top top(&ctx);

    reset_dut(top, ctx);
    cpu_idle(top);

    // Ensure boot ROM switch starts in the enabled state (0)
    EXPECT_EQ(top.rootp->cartridge_top__DOT__cart_inst__DOT__boot_rom_switch, 0)
        << "Boot ROM should be active at reset.";

    // Verify the first 256 bytes map to the boot ROM, not the cartridge ROM
    for (uint16_t addr = 0x0000; addr <= 0x00FF; addr++) {
        top.cpu_addr = addr;
        top.cpu_read_en = 1;

        tick(top, ctx);

        uint8_t val = top.cpu_rdata;
        uint8_t expected = bootDMG[addr];

        EXPECT_EQ(val, expected)
            << "Boot ROM mismatch at address 0x"
            << std::hex << addr
            << ": expected 0x" << int(expected)
            << ", got 0x" << int(val);

        top.cpu_read_en = 0;
        tick(top, ctx); // settle
    }
}

TEST(CartridgeTest, BootRomDisablesOnWriteToFF50) {
    VerilatedContext ctx;
    Vcartridge_top top(&ctx);

    reset_dut(top, ctx);
    cpu_idle(top);

    top.cpu_addr = 0xFF50;
    top.cpu_wdata = 0x01;
    top.cpu_write_en = 1;

    tick(top, ctx);

    // Boot switch inside cartridge should now equal 1
    u8 sw = top.rootp->cartridge_top__DOT__cart_inst__DOT__boot_rom_switch;
    EXPECT_EQ(sw, 1);

    // Reads from 0x0000 should now come from ROM[], not BOOT[]
    top.cpu_write_en = 0;
    tick(top, ctx);

    top.cpu_addr = 0x0000;
    top.cpu_read_en = 1;

    tick(top, ctx);

    u8 read_val = top.cpu_rdata;

    EXPECT_EQ(read_val, top.rootp->cartridge_top__DOT__cart_inst__DOT__ROM[0]);

    top.cpu_read_en = 0;
}