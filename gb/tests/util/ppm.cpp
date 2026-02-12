#include "ppm.hpp"

#include <cstdint>
#include <filesystem>
#include <fstream>
#include <stdexcept>
#include <string>
#include <vector>

namespace fs = std::filesystem;
void write_ppm(
    const uint32_t framebuffer[FB_SIZE],
    const fs::path& path) {
    std::ofstream ofs(path, std::ios::binary);
    if (!ofs) {
        throw std::runtime_error("Failed to open " + path.string());
    }

    ofs << "P6\n"
        << GB_WIDTH << ' ' << GB_HEIGHT << "\n255\n";

    for (auto j = 0u; j < FB_SIZE; ++j) {
        uint32_t px = framebuffer[j];

        const char r = static_cast<unsigned char>((px >> 16) & 0xFF);
        const char g = static_cast<unsigned char>((px >> 8) & 0xFF);
        const char b = static_cast<unsigned char>(px & 0xFF);

        ofs << r << g << b;
    }
}

std::vector<uint32_t> read_ppm(
    const fs::path& path,
    std::size_t& width,
    std::size_t& height) {

    std::ifstream in(path, std::ios::binary);
    if (!in)
        throw std::runtime_error("open failed");

    std::string magic;
    int maxval;

    in >> magic >> width >> height >> maxval;
    in.get(); // consume newline

    if (magic != "P6" || maxval != 255)
        throw std::runtime_error("bad ppm");

    std::vector<uint8_t> raw(width * height * 3);
    in.read(reinterpret_cast<char*>(raw.data()), raw.size());

    std::vector<uint32_t> out(width * height);
    for (size_t i = 0; i < out.size(); ++i) {
        out[i] = 0xFF000000u | (raw[i * 3 + 0] << 16) | (raw[i * 3 + 1] << 8) | raw[i * 3 + 2];
    }
    return out;
}
