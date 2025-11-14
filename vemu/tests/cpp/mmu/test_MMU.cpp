#include <verilated.h>

static vluint64_t timestamp = 0;

double sc_time_stamp() { return timestamp; }