`ifndef MMU_TYPES_SV
`define MMU_TYPES_SV 

typedef logic [15:0] address_t;

typedef enum logic {
  DMA_DIRECTION_READ,
  DMA_DIRECTION_WRITE
} dma_direction_t;

`endif
