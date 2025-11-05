#include "VCPU.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

double sc_time_stamp() {
    return 0; // or return (main_time * 1.0);
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    auto top = new VCPU;

    VerilatedVcdC* tfp = nullptr;
    Verilated::traceEverOn(true);
    tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("wave.vcd");

    top->reset = 1;
    for (int i = 0; i < 5; i++) {
        top->clk = !top->clk;
        top->eval();
        tfp->dump(i);
    }
    top->reset = 0;

    for (int i = 0; i < 100; i++) {
        top->clk = !top->clk;
        top->eval();
        tfp->dump(i + 10);
    }

    tfp->close();
    delete tfp;
    delete top;
    return 0;
}
