#include "VGameboy.h"
#include "VGameboy___024root.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include <fstream>

vluint64_t main_time = 0;

double sc_time_stamp() {
    return main_time;
}

void load_rom(VGameboy* top, const char* filename) {
    std::ifstream rom(filename, std::ios::binary);
    if (!rom.good()) {
        printf("Cannot open ROM!\n");
        exit(1);
    }

    for (int i = 0; i < 0x8000; i++) {
        char byte;
        rom.read(&byte, 1);
        top->rootp->Gameboy__DOT__cart_inst__DOT__ROM[i] = (uint8_t)byte;
    }
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    VGameboy* top = new VGameboy;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("wave.vcd");

    top->reset = 1;
    for (int i = 0; i < 10; i++) {
        top->clk = (i & 1);
        top->eval();
        tfp->dump(main_time++);
    }
    top->reset = 0;

    for (int i = 0; i < 500; i++) {
        top->clk = (i & 1);
        top->eval();
        tfp->dump(main_time++);
    }

    tfp->close();
    delete tfp;
    delete top;

    return 0;
}
