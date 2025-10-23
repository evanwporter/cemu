#include "types.hpp"

inline bool check_bit(const u8 value, const u8 bit) {
    return (value & (1 << bit)) != 0;
}
