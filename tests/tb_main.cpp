#include "Vcpu_tb.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>

static vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

static inline void tick(Vcpu_tb& top, VerilatedVcdC& trace) {
    // Half period (falling edge)
    top.clk = 0;
    top.eval();
    trace.dump(main_time);
    main_time += 5;

    // Rising edge
    top.clk = 1;
    top.eval();
    trace.dump(main_time);
    main_time += 5;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    Vcpu_tb top;
    VerilatedVcdC trace;
    top.trace(&trace, 99);
    trace.open("waves.vcd");

    // Manual reset
    top.reset = 1;
    for (int i = 0; i < 10; ++i)
        tick(top, trace);
    top.reset = 0;

    // Manual run
    for (int i = 0; i < 1000 && !Verilated::gotFinish(); ++i) {
        tick(top, trace);
    }

    trace.close();
    return 0;
}
