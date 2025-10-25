#include "io/serial.hpp"

#include "util/bitops.hpp"
#include "util/log.hpp"

#include <cstdio>

u8 Serial::read() const { return data; }

void Serial::write(const u8 byte) {
    data = byte;
}

void Serial::write_control(const u8 byte) const {
    if (check_bit(byte, 7) && options.print_serial) {
        printf("%c", data);
        fflush(stdout);
    }
}
