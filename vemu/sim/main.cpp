#include <VGameboy.h>
#include <VGameboy___024root.h>
#include <verilated.h>

#include <fstream>
#include <iostream>
#include <string>

vluint64_t main_time = 0;

double sc_time_stamp() {
    return main_time;
}

bool load_rom(VGameboy* top, const char* filename) {
    std::ifstream rom(filename, std::ios::binary);
    if (!rom.good()) {
        printf("Cannot open ROM!\n");
        return false;
    }

    for (int i = 0; i < 0x8000; i++) {
        char byte;
        rom.read(&byte, 1);
        top->rootp->Gameboy__DOT__cart_inst__DOT__ROM[i] = (uint8_t)byte;
    }
    return true;
}

static void tick(VGameboy* top, VerilatedContext& ctx) {
    top->clk = 0;
    top->eval();
    ctx.timeInc(5);

    top->clk = 1;
    top->eval();
    ctx.timeInc(5);
}

int main() {
    VerilatedContext ctx;
    ctx.debug(0);
    ctx.time(0);

    const char* rom_path = "C:\\Users\\evanw\\cemu\\tests\\gb-test-roms\\cpu_instrs\\cpu_instrs.gb";

    VGameboy* top = new VGameboy(&ctx);

    if (!load_rom(top, rom_path)) {
        return 1;
    }

    top->reset = 1;
    for (int i = 0; i < 10; ++i) {
        tick(top, ctx);
    }
    top->reset = 0;

    uint8_t prev_SC = top->rootp->Gameboy__DOT__serial_inst__DOT__SC;
    std::string serial_out;

    const uint64_t max_cycles = 20'000'000; // safety timeout

    for (uint64_t cyc = 0; cyc < max_cycles && !ctx.gotFinish(); ++cyc) {
        tick(top, ctx);

        uint8_t& SC = top->rootp->Gameboy__DOT__serial_inst__DOT__SC;
        uint8_t& SB = top->rootp->Gameboy__DOT__serial_inst__DOT__SB;

        bool new_transfer = ((SC & 0x80) && !(prev_SC & 0x80));
        if (new_transfer && (SC & 0x01)) {
            char c = static_cast<char>(SB);
            serial_out.push_back(c);

            SC &= ~0x80;

            std::cout << c << std::flush;
        }

        prev_SC = SC;

        if (serial_out.find("Passed") != std::string::npos || serial_out.find("passed") != std::string::npos) {
            std::cout << "\nTest ROM reported success.\n";
            break;
        }
    }

    if (serial_out.find("Passed") == std::string::npos && serial_out.find("passed") == std::string::npos) {
        std::cerr << "\nERROR: serial output did not contain \"Passed\".\n";
        std::cerr << "Captured output:\n"
                  << serial_out << "\n";
        delete top;
        return 1;
    }

    delete top;
    return 0;
}
