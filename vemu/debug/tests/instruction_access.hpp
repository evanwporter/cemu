#pragma once

#include <cstdint>
#include <vector>

uint8_t read_memory(uint16_t addr);

struct OperandAccess {
    const char* name;
    bool read;
    bool write;
};

struct InstructionAccess {
    uint8_t opcode;
    const char* mnemonic;
    std::vector<OperandAccess> operands;
    int immediate_reads;
};

std::vector<InstructionAccess> instruction_access = {
    { 0x00, "NOP", {}, 0 },
    { 0x01, "LD", {
                      { "BC", false, true },
                  },
      2 },
    { 0x02, "LD", {
                      { "A", true, false },
                      { "BC", false, true },
                  },
      0 },
    { 0x03, "INC", {
                       { "BC", true, true },
                   },
      0 },
    { 0x04, "INC", {
                       { "B", true, true },
                   },
      0 },
    { 0x05, "DEC", {
                       { "B", true, true },
                   },
      0 },
    { 0x06, "LD", {
                      { "B", false, true },
                  },
      1 },
    { 0x07, "RLCA", {
                        { "A", true, true },
                        { "F", false, true },
                    },
      0 },
    { 0x08, "LD", {
                      { "SP", true, false },
                      { "a16", false, true },
                  },
      0 },
    { 0x09, "ADD", {
                       { "BC", true, false },
                       { "HL", true, false },
                   },
      0 },
    { 0x0A, "LD", {
                      { "A", false, true },
                      { "BC", true, false },
                  },
      0 },
    { 0x0B, "DEC", {
                       { "BC", true, true },
                   },
      0 },
    { 0x0C, "INC", {
                       { "C", true, true },
                   },
      0 },
    { 0x0D, "DEC", {
                       { "C", true, true },
                   },
      0 },
    { 0x0E, "LD", {
                      { "C", false, true },
                  },
      1 },
    { 0x0F, "RRCA", {}, 0 },
    { 0x10, "STOP", {
                        { "n8", true, false },
                    },
      0 },
    { 0x11, "LD", {
                      { "DE", false, true },
                  },
      2 },
    { 0x12, "LD", {
                      { "A", true, false },
                      { "DE", false, true },
                  },
      0 },
    { 0x13, "INC", {
                       { "DE", true, true },
                   },
      0 },
    { 0x14, "INC", {
                       { "D", true, true },
                   },
      0 },
    { 0x15, "DEC", {
                       { "D", true, true },
                   },
      0 },
    { 0x16, "LD", {
                      { "D", false, true },
                  },
      1 },
    { 0x17, "RLA", {
                       { "A", true, true },
                       { "F", false, true },
                   },
      0 },
    { 0x18, "JR", {
                      { "e8", true, false },
                  },
      0 },
    { 0x19, "ADD", {
                       { "DE", true, false },
                       { "HL", true, false },
                   },
      0 },
    { 0x1A, "LD", {
                      { "A", false, true },
                      { "DE", true, false },
                  },
      0 },
    { 0x1B, "DEC", {
                       { "DE", true, true },
                   },
      0 },
    { 0x1C, "INC", {
                       { "E", true, true },
                   },
      0 },
    { 0x1D, "DEC", {
                       { "E", true, true },
                   },
      0 },
    { 0x1E, "LD", {
                      { "E", false, true },
                  },
      1 },
    { 0x1F, "RRA", {}, 0 },
    { 0x20, "JR", {
                      { "NZ", true, false },
                      { "e8", true, false },
                  },
      0 },
    { 0x21, "LD", {
                      { "HL", false, true },
                  },
      2 },
    { 0x22, "LD", {
                      { "A", true, false },
                      { "HL", false, true },
                  },
      0 },
    { 0x23, "INC", {
                       { "HL", true, true },
                   },
      0 },
    { 0x24, "INC", {
                       { "H", true, true },
                   },
      0 },
    { 0x25, "DEC", {
                       { "H", true, true },
                   },
      0 },
    { 0x26, "LD", {
                      { "H", false, true },
                  },
      1 },
    { 0x27, "DAA", {}, 0 },
    { 0x28, "JR", {
                      { "Z", true, false },
                      { "e8", true, false },
                  },
      0 },
    { 0x29, "ADD", {
                       { "HL", true, false },
                   },
      0 },
    { 0x2A, "LD", {
                      { "A", false, true },
                      { "HL", true, false },
                  },
      0 },
    { 0x2B, "DEC", {
                       { "HL", true, true },
                   },
      0 },
    { 0x2C, "INC", {
                       { "L", true, true },
                   },
      0 },
    { 0x2D, "DEC", {
                       { "L", true, true },
                   },
      0 },
    { 0x2E, "LD", {
                      { "L", false, true },
                  },
      1 },
    { 0x2F, "CPL", {}, 0 },
    { 0x30, "JR", {
                      { "NC", true, false },
                      { "e8", true, false },
                  },
      0 },
    { 0x31, "LD", {
                      { "SP", false, true },
                  },
      2 },
    { 0x32, "LD", {
                      { "A", true, false },
                      { "HL", false, true },
                  },
      0 },
    { 0x33, "INC", {
                       { "SP", true, true },
                   },
      0 },
    { 0x34, "INC", {
                       { "HL", true, true },
                   },
      0 },
    { 0x35, "DEC", {
                       { "HL", true, true },
                   },
      0 },
    { 0x36, "LD", {
                      { "HL", false, true },
                  },
      1 },
    { 0x37, "SCF", {}, 0 },
    { 0x38, "JR", {
                      { "C", true, false },
                      { "e8", true, false },
                  },
      0 },
    { 0x39, "ADD", {
                       { "HL", true, false },
                       { "SP", true, false },
                   },
      0 },
    { 0x3A, "LD", {
                      { "A", false, true },
                      { "HL", true, false },
                  },
      0 },
    { 0x3B, "DEC", {
                       { "SP", true, true },
                   },
      0 },
    { 0x3C, "INC", {
                       { "A", true, true },
                   },
      0 },
    { 0x3D, "DEC", {
                       { "A", true, true },
                   },
      0 },
    { 0x3E, "LD", {
                      { "A", false, true },
                  },
      1 },
    { 0x3F, "CCF", {}, 0 },
    { 0x40, "LD", {
                      { "B", true, true },
                  },
      0 },
    { 0x41, "LD", {
                      { "B", false, true },
                      { "C", true, false },
                  },
      0 },
    { 0x42, "LD", {
                      { "B", false, true },
                      { "D", true, false },
                  },
      0 },
    { 0x43, "LD", {
                      { "B", false, true },
                      { "E", true, false },
                  },
      0 },
    { 0x44, "LD", {
                      { "B", false, true },
                      { "H", true, false },
                  },
      0 },
    { 0x45, "LD", {
                      { "B", false, true },
                      { "L", true, false },
                  },
      0 },
    { 0x46, "LD", {
                      { "B", false, true },
                      { "HL", true, false },
                  },
      0 },
    { 0x47, "LD", {
                      { "A", true, false },
                      { "B", false, true },
                  },
      0 },
    { 0x48, "LD", {
                      { "B", true, false },
                      { "C", false, true },
                  },
      0 },
    { 0x49, "LD", {
                      { "C", true, true },
                  },
      0 },
    { 0x4A, "LD", {
                      { "C", false, true },
                      { "D", true, false },
                  },
      0 },
    { 0x4B, "LD", {
                      { "C", false, true },
                      { "E", true, false },
                  },
      0 },
    { 0x4C, "LD", {
                      { "C", false, true },
                      { "H", true, false },
                  },
      0 },
    { 0x4D, "LD", {
                      { "C", false, true },
                      { "L", true, false },
                  },
      0 },
    { 0x4E, "LD", {
                      { "C", false, true },
                      { "HL", true, false },
                  },
      0 },
    { 0x4F, "LD", {
                      { "A", true, false },
                      { "C", false, true },
                  },
      0 },
    { 0x50, "LD", {
                      { "B", true, false },
                      { "D", false, true },
                  },
      0 },
    { 0x51, "LD", {
                      { "C", true, false },
                      { "D", false, true },
                  },
      0 },
    { 0x52, "LD", {
                      { "D", true, true },
                  },
      0 },
    { 0x53, "LD", {
                      { "D", false, true },
                      { "E", true, false },
                  },
      0 },
    { 0x54, "LD", {
                      { "D", false, true },
                      { "H", true, false },
                  },
      0 },
    { 0x55, "LD", {
                      { "D", false, true },
                      { "L", true, false },
                  },
      0 },
    { 0x56, "LD", {
                      { "D", false, true },
                      { "HL", true, false },
                  },
      0 },
    { 0x57, "LD", {
                      { "A", true, false },
                      { "D", false, true },
                  },
      0 },
    { 0x58, "LD", {
                      { "B", true, false },
                      { "E", false, true },
                  },
      0 },
    { 0x59, "LD", {
                      { "C", true, false },
                      { "E", false, true },
                  },
      0 },
    { 0x5A, "LD", {
                      { "D", true, false },
                      { "E", false, true },
                  },
      0 },
    { 0x5B, "LD", {
                      { "E", true, true },
                  },
      0 },
    { 0x5C, "LD", {
                      { "E", false, true },
                      { "H", true, false },
                  },
      0 },
    { 0x5D, "LD", {
                      { "E", false, true },
                      { "L", true, false },
                  },
      0 },
    { 0x5E, "LD", {
                      { "E", false, true },
                      { "HL", true, false },
                  },
      0 },
    { 0x5F, "LD", {
                      { "A", true, false },
                      { "E", false, true },
                  },
      0 },
    { 0x60, "LD", {
                      { "B", true, false },
                      { "H", false, true },
                  },
      0 },
    { 0x61, "LD", {
                      { "C", true, false },
                      { "H", false, true },
                  },
      0 },
    { 0x62, "LD", {
                      { "D", true, false },
                      { "H", false, true },
                  },
      0 },
    { 0x63, "LD", {
                      { "E", true, false },
                      { "H", false, true },
                  },
      0 },
    { 0x64, "LD", {
                      { "H", true, true },
                  },
      0 },
    { 0x65, "LD", {
                      { "H", false, true },
                      { "L", true, false },
                  },
      0 },
    { 0x66, "LD", {
                      { "H", false, true },
                      { "HL", true, false },
                  },
      0 },
    { 0x67, "LD", {
                      { "A", true, false },
                      { "H", false, true },
                  },
      0 },
    { 0x68, "LD", {
                      { "B", true, false },
                      { "L", false, true },
                  },
      0 },
    { 0x69, "LD", {
                      { "C", true, false },
                      { "L", false, true },
                  },
      0 },
    { 0x6A, "LD", {
                      { "D", true, false },
                      { "L", false, true },
                  },
      0 },
    { 0x6B, "LD", {
                      { "E", true, false },
                      { "L", false, true },
                  },
      0 },
    { 0x6C, "LD", {
                      { "H", true, false },
                      { "L", false, true },
                  },
      0 },
    { 0x6D, "LD", {
                      { "L", true, true },
                  },
      0 },
    { 0x6E, "LD", {
                      { "HL", true, false },
                      { "L", false, true },
                  },
      0 },
    { 0x6F, "LD", {
                      { "A", true, false },
                      { "L", false, true },
                  },
      0 },
    { 0x70, "LD", {
                      { "B", true, false },
                      { "HL", false, true },
                  },
      0 },
    { 0x71, "LD", {
                      { "C", true, false },
                      { "HL", false, true },
                  },
      0 },
    { 0x72, "LD", {
                      { "D", true, false },
                      { "HL", false, true },
                  },
      0 },
    { 0x73, "LD", {
                      { "E", true, false },
                      { "HL", false, true },
                  },
      0 },
    { 0x74, "LD", {
                      { "H", true, false },
                      { "HL", false, true },
                  },
      0 },
    { 0x75, "LD", {
                      { "HL", false, true },
                      { "L", true, false },
                  },
      0 },
    { 0x76, "HALT", {}, 0 },
    { 0x77, "LD", {
                      { "A", true, false },
                      { "HL", false, true },
                  },
      0 },
    { 0x78, "LD", {
                      { "A", false, true },
                      { "B", true, false },
                  },
      0 },
    { 0x79, "LD", {
                      { "A", false, true },
                      { "C", true, false },
                  },
      0 },
    { 0x7A, "LD", {
                      { "A", false, true },
                      { "D", true, false },
                  },
      0 },
    { 0x7B, "LD", {
                      { "A", false, true },
                      { "E", true, false },
                  },
      0 },
    { 0x7C, "LD", {
                      { "A", false, true },
                      { "H", true, false },
                  },
      0 },
    { 0x7D, "LD", {
                      { "A", false, true },
                      { "L", true, false },
                  },
      0 },
    { 0x7E, "LD", {
                      { "A", false, true },
                      { "HL", true, false },
                  },
      0 },
    { 0x7F, "LD", {
                      { "A", true, true },
                  },
      0 },
    { 0x80, "ADD", {
                       { "A", true, false },
                       { "B", true, false },
                   },
      0 },
    { 0x81, "ADD", {
                       { "A", true, false },
                       { "C", true, false },
                   },
      0 },
    { 0x82, "ADD", {
                       { "A", true, false },
                       { "D", true, false },
                   },
      0 },
    { 0x83, "ADD", {
                       { "A", true, false },
                       { "E", true, false },
                   },
      0 },
    { 0x84, "ADD", {
                       { "A", true, false },
                       { "H", true, false },
                   },
      0 },
    { 0x85, "ADD", {
                       { "A", true, false },
                       { "L", true, false },
                   },
      0 },
    { 0x86, "ADD", {
                       { "A", true, false },
                       { "HL", true, false },
                   },
      0 },
    { 0x87, "ADD", {
                       { "A", true, false },
                   },
      0 },
    { 0x88, "ADC", {
                       { "A", true, false },
                       { "B", true, false },
                   },
      0 },
    { 0x89, "ADC", {
                       { "A", true, false },
                       { "C", true, false },
                   },
      0 },
    { 0x8A, "ADC", {
                       { "A", true, false },
                       { "D", true, false },
                   },
      0 },
    { 0x8B, "ADC", {
                       { "A", true, false },
                       { "E", true, false },
                   },
      0 },
    { 0x8C, "ADC", {
                       { "A", true, false },
                       { "H", true, false },
                   },
      0 },
    { 0x8D, "ADC", {
                       { "A", true, false },
                       { "L", true, false },
                   },
      0 },
    { 0x8E, "ADC", {
                       { "A", true, false },
                       { "HL", true, false },
                   },
      0 },
    { 0x8F, "ADC", {
                       { "A", true, false },
                   },
      0 },
    { 0x90, "SUB", {
                       { "A", true, false },
                       { "B", true, false },
                   },
      0 },
    { 0x91, "SUB", {
                       { "A", true, false },
                       { "C", true, false },
                   },
      0 },
    { 0x92, "SUB", {
                       { "A", true, false },
                       { "D", true, false },
                   },
      0 },
    { 0x93, "SUB", {
                       { "A", true, false },
                       { "E", true, false },
                   },
      0 },
    { 0x94, "SUB", {
                       { "A", true, false },
                       { "H", true, false },
                   },
      0 },
    { 0x95, "SUB", {
                       { "A", true, false },
                       { "L", true, false },
                   },
      0 },
    { 0x96, "SUB", {
                       { "A", true, false },
                       { "HL", true, false },
                   },
      0 },
    { 0x97, "SUB", {
                       { "A", true, false },
                   },
      0 },
    { 0x98, "SBC", {
                       { "A", true, false },
                       { "B", true, false },
                   },
      0 },
    { 0x99, "SBC", {
                       { "A", true, false },
                       { "C", true, false },
                   },
      0 },
    { 0x9A, "SBC", {
                       { "A", true, false },
                       { "D", true, false },
                   },
      0 },
    { 0x9B, "SBC", {
                       { "A", true, false },
                       { "E", true, false },
                   },
      0 },
    { 0x9C, "SBC", {
                       { "A", true, false },
                       { "H", true, false },
                   },
      0 },
    { 0x9D, "SBC", {
                       { "A", true, false },
                       { "L", true, false },
                   },
      0 },
    { 0x9E, "SBC", {
                       { "A", true, false },
                       { "HL", true, false },
                   },
      0 },
    { 0x9F, "SBC", {
                       { "A", true, false },
                   },
      0 },
    { 0xA0, "AND", {
                       { "A", true, false },
                       { "B", true, false },
                   },
      0 },
    { 0xA1, "AND", {
                       { "A", true, false },
                       { "C", true, false },
                   },
      0 },
    { 0xA2, "AND", {
                       { "A", true, false },
                       { "D", true, false },
                   },
      0 },
    { 0xA3, "AND", {
                       { "A", true, false },
                       { "E", true, false },
                   },
      0 },
    { 0xA4, "AND", {
                       { "A", true, false },
                       { "H", true, false },
                   },
      0 },
    { 0xA5, "AND", {
                       { "A", true, false },
                       { "L", true, false },
                   },
      0 },
    { 0xA6, "AND", {
                       { "A", true, false },
                       { "HL", true, false },
                   },
      0 },
    { 0xA7, "AND", {
                       { "A", true, false },
                   },
      0 },
    { 0xA8, "XOR", {
                       { "A", true, false },
                       { "B", true, false },
                   },
      0 },
    { 0xA9, "XOR", {
                       { "A", true, false },
                       { "C", true, false },
                   },
      0 },
    { 0xAA, "XOR", {
                       { "A", true, false },
                       { "D", true, false },
                   },
      0 },
    { 0xAB, "XOR", {
                       { "A", true, false },
                       { "E", true, false },
                   },
      0 },
    { 0xAC, "XOR", {
                       { "A", true, false },
                       { "H", true, false },
                   },
      0 },
    { 0xAD, "XOR", {
                       { "A", true, false },
                       { "L", true, false },
                   },
      0 },
    { 0xAE, "XOR", {
                       { "A", true, false },
                       { "HL", true, false },
                   },
      0 },
    { 0xAF, "XOR", {
                       { "A", true, false },
                   },
      0 },
    { 0xB0, "OR", {
                      { "A", true, false },
                      { "B", true, false },
                  },
      0 },
    { 0xB1, "OR", {
                      { "A", true, false },
                      { "C", true, false },
                  },
      0 },
    { 0xB2, "OR", {
                      { "A", true, false },
                      { "D", true, false },
                  },
      0 },
    { 0xB3, "OR", {
                      { "A", true, false },
                      { "E", true, false },
                  },
      0 },
    { 0xB4, "OR", {
                      { "A", true, false },
                      { "H", true, false },
                  },
      0 },
    { 0xB5, "OR", {
                      { "A", true, false },
                      { "L", true, false },
                  },
      0 },
    { 0xB6, "OR", {
                      { "A", true, false },
                      { "HL", true, false },
                  },
      0 },
    { 0xB7, "OR", {
                      { "A", true, false },
                  },
      0 },
    { 0xB8, "CP", {
                      { "A", true, false },
                      { "B", true, false },
                  },
      0 },
    { 0xB9, "CP", {
                      { "A", true, false },
                      { "C", true, false },
                  },
      0 },
    { 0xBA, "CP", {
                      { "A", true, false },
                      { "D", true, false },
                  },
      0 },
    { 0xBB, "CP", {
                      { "A", true, false },
                      { "E", true, false },
                  },
      0 },
    { 0xBC, "CP", {
                      { "A", true, false },
                      { "H", true, false },
                  },
      0 },
    { 0xBD, "CP", {
                      { "A", true, false },
                      { "L", true, false },
                  },
      0 },
    { 0xBE, "CP", {
                      { "A", true, false },
                      { "HL", true, false },
                  },
      0 },
    { 0xBF, "CP", {
                      { "A", true, false },
                  },
      0 },
    { 0xC0, "RET", {
                       { "NZ", true, false },
                   },
      0 },
    { 0xC1, "POP", {
                       { "BC", true, false },
                   },
      0 },
    { 0xC2, "JP", {
                      { "NZ", true, false },
                      { "a16", true, false },
                  },
      0 },
    { 0xC3, "JP", {
                      { "a16", true, false },
                  },
      0 },
    { 0xC4, "CALL", {
                        { "NZ", true, false },
                        { "a16", true, false },
                    },
      0 },
    { 0xC5, "PUSH", {
                        { "BC", true, false },
                    },
      0 },
    { 0xC6, "ADD", {
                       { "A", true, false },
                       { "n8", true, false },
                   },
      0 },
    { 0xC7, "RST", {
                       { "$00", true, false },
                   },
      0 },
    { 0xC8, "RET", {
                       { "Z", true, false },
                   },
      0 },
    { 0xC9, "RET", {}, 0 },
    { 0xCA, "JP", {
                      { "Z", true, false },
                      { "a16", true, false },
                  },
      0 },
    { 0xCB, "PREFIX", {}, 0 },
    { 0xCC, "CALL", {
                        { "Z", true, false },
                        { "a16", true, false },
                    },
      0 },
    { 0xCD, "CALL", {
                        { "a16", true, false },
                    },
      0 },
    { 0xCE, "ADC", {
                       { "A", true, false },
                       { "n8", true, false },
                   },
      0 },
    { 0xCF, "RST", {
                       { "$08", true, false },
                   },
      0 },
    { 0xD0, "RET", {
                       { "NC", true, false },
                   },
      0 },
    { 0xD1, "POP", {
                       { "DE", true, false },
                   },
      0 },
    { 0xD2, "JP", {
                      { "NC", true, false },
                      { "a16", true, false },
                  },
      0 },
    { 0xD3, "ILLEGAL_D3", {}, 0 },
    { 0xD4, "CALL", {
                        { "NC", true, false },
                        { "a16", true, false },
                    },
      0 },
    { 0xD5, "PUSH", {
                        { "DE", true, false },
                    },
      0 },
    { 0xD6, "SUB", {
                       { "A", true, false },
                       { "n8", true, false },
                   },
      0 },
    { 0xD7, "RST", {
                       { "$10", true, false },
                   },
      0 },
    { 0xD8, "RET", {
                       { "C", true, false },
                   },
      0 },
    { 0xD9, "RETI", {}, 0 },
    { 0xDA, "JP", {
                      { "C", true, false },
                      { "a16", true, false },
                  },
      0 },
    { 0xDB, "ILLEGAL_DB", {}, 0 },
    { 0xDC, "CALL", {
                        { "C", true, false },
                        { "a16", true, false },
                    },
      0 },
    { 0xDD, "ILLEGAL_DD", {}, 0 },
    { 0xDE, "SBC", {
                       { "A", true, false },
                       { "n8", true, false },
                   },
      0 },
    { 0xDF, "RST", {
                       { "$18", true, false },
                   },
      0 },
    { 0xE0, "LDH", {
                       { "A", true, false },
                       { "a8", true, false },
                   },
      0 },
    { 0xE1, "POP", {
                       { "HL", true, false },
                   },
      0 },
    { 0xE2, "LDH", {
                       { "A", true, false },
                       { "C", true, false },
                   },
      0 },
    { 0xE3, "ILLEGAL_E3", {}, 0 },
    { 0xE4, "ILLEGAL_E4", {}, 0 },
    { 0xE5, "PUSH", {
                        { "HL", true, false },
                    },
      0 },
    { 0xE6, "AND", {
                       { "A", true, false },
                       { "n8", true, false },
                   },
      0 },
    { 0xE7, "RST", {
                       { "$20", true, false },
                   },
      0 },
    { 0xE8, "ADD", {
                       { "SP", true, false },
                       { "e8", true, false },
                   },
      0 },
    { 0xE9, "JP", {
                      { "HL", true, false },
                  },
      0 },
    { 0xEA, "LD", {
                      { "A", true, false },
                      { "a16", false, true },
                  },
      0 },
    { 0xEB, "ILLEGAL_EB", {}, 0 },
    { 0xEC, "ILLEGAL_EC", {}, 0 },
    { 0xED, "ILLEGAL_ED", {}, 0 },
    { 0xEE, "XOR", {
                       { "A", true, false },
                       { "n8", true, false },
                   },
      0 },
    { 0xEF, "RST", {
                       { "$28", true, false },
                   },
      0 },
    { 0xF0, "LDH", {
                       { "A", true, false },
                       { "a8", true, false },
                   },
      0 },
    { 0xF1, "POP", {
                       { "AF", true, false },
                   },
      0 },
    { 0xF2, "LDH", {
                       { "A", true, false },
                       { "C", true, false },
                   },
      0 },
    { 0xF3, "DI", {}, 0 },
    { 0xF4, "ILLEGAL_F4", {}, 0 },
    { 0xF5, "PUSH", {
                        { "AF", true, false },
                    },
      0 },
    { 0xF6, "OR", {
                      { "A", true, false },
                      { "n8", true, false },
                  },
      0 },
    { 0xF7, "RST", {
                       { "$30", true, false },
                   },
      0 },
    { 0xF8, "LD", {}, 0 },
    { 0xF9, "LD", {
                      { "HL", true, false },
                      { "SP", false, true },
                  },
      0 },
    { 0xFA, "LD", {
                      { "A", false, true },
                  },
      2 },
    { 0xFB, "EI", {}, 0 },
    { 0xFC, "ILLEGAL_FC", {}, 0 },
    { 0xFD, "ILLEGAL_FD", {}, 0 },
    { 0xFE, "CP", {
                      { "A", true, false },
                      { "n8", true, false },
                  },
      0 },
    { 0xFF, "RST", {
                       { "$38", true, false },
                   },
      0 },
};
