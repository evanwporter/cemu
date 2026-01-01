#include <filesystem>
#include <string>
#include <unordered_set>
#include <vector>

std::vector<std::filesystem::path> collect_files_in_directory(
    const std::filesystem::path& dir,
    const std::string& extension,
    std::unordered_set<std::string> exclude = {});