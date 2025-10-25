// tests/mock_mmu.cpp
#include "mmu/mmu.hpp"

static std::array<u8, 0x10000> test_memory {};

u8 MMU::read(const Address& addr) const {
    return test_memory[addr.value()];
}

void MMU::write(const Address& addr, u8 val) {
    test_memory[addr.value()] = val;
}
