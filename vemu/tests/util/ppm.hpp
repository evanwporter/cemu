#pragma once

#include <cstdint>
#include <filesystem>
#include <vector>

static constexpr std::size_t GB_WIDTH = 160;
static constexpr std::size_t GB_HEIGHT = 144;
static constexpr std::size_t FB_SIZE = GB_WIDTH * GB_HEIGHT;

/// Source: https://rosettacode.org/wiki/Bitmap/Write_a_PPM_file#C++
void write_ppm(const uint32_t framebuffer[FB_SIZE], const std::filesystem::path& path);

std::vector<uint32_t> read_ppm(
    const std::filesystem::path& path,
    std::size_t& width,
    std::size_t& height);