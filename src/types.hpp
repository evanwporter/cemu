#pragma once
#include <cstddef>
#include <cstdint>

/// 8-bit unsigned
using u8 = uint8_t;

/// 16-bit unsigned
using u16 = uint16_t;

/// 8-bit signed
using s8 = int8_t;

/// 16-bit signed
using s16 = int16_t;

/// 32-bit unsigned
#ifndef _UINT_T
using uint = unsigned int;
#endif

enum class GBColors {
    Color1,
    Color2,
    Color3,
    Color4
};