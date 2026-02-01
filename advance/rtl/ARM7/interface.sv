import cpu_types_pkg::*;

interface Decoder_if (
    input word_t IR
);

  decoded_word_t word;

  modport Decoder_side(input IR, output word);

endinterface
