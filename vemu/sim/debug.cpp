#define SDL_MAIN_HANDLED

#include <iostream>

#include "debugger.hpp"
#include "gb.hpp"

vluint64_t main_time = 0;

double sc_time_stamp() {
    return main_time;
}

int main(int argc, char** argv) {
    GameboyHarness emu(false, false, true);

    // load ROM from command line
    if (argc > 1) {
        if (!emu.setup(argv[1])) {
            std::cerr << "Failed to load ROM: " << argv[1] << "\n";
        }
    }

    debug::Debugger debugger;

    if (!debugger.init(argc, argv)) {
        std::cerr << "Failed to initialize debugger\n";
        return -1;
    }

    debugger.run();

    debugger.shutdown();
    return 0;
}
