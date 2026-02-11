#include <verilated.h>

/// Global Verilator time variable
vluint64_t g_verilator_time = 0;

double sc_time_stamp() {
    return static_cast<double>(g_verilator_time);
}
