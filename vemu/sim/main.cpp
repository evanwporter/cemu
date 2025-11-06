#include "VGameboy.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

vluint64_t main_time = 0;

double sc_time_stamp() {
    return main_time;
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
