#pragma once
#include "types.hpp"
#include <string>
#include <vector>

class Cartridge {
public:
    Cartridge() = default;
    ~Cartridge() = default;

    bool load(const std::string& path);

    u8 read(u16 address) const { return 0; };
    void write(u16 address, u8 value) { };

private:
    std::vector<u8> rom;
    std::vector<u8> ram;
};
