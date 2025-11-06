#pragma once

#include "definitions.hpp"
#include "options.hpp"

class Serial {
public:
    Serial(Options& options) :
        options(options) { }

    u8 read() const;
    void write(u8 byte);
    void write_control(u8 byte) const;

private:
    Options& options;

    u8 data;
};
