`ifndef TIMER_SV
`define TIMER_SV 

// https://gbdev.io/pandocs/Timer_and_Divider_Registers.html#timer-and-divider-registers

module Timer (
    input logic clk,
    input logic reset,
    input gameboy_types_pkg::t_phase_t t_phase,
    Bus_if.Slave_side bus,
    Interrupt_if.Timer_side IF_bus
);
  /// Divider Register
  // To the CPU the DIV appears as an 8-bit register at address 0xFF04. However,
  // internally it is a 16-bit counter that increments at every t-cycle, where
  // only the upper 8 bits are exposed to the CPU.
  // Source: https://github.com/Ashiepaws/GBEDG/blob/97f198d330a51be558aa8fc9f3f0760846d02d95/timers/index.md#ff04---divider-register-div
  logic [15:0] DIV;

  /// Timer Counter
  logic [ 7:0] TIMA;

  /// Timer Modulo
  logic [ 7:0] TMA;

  /// Timer Control
  logic [ 7:0] TAC;

  logic sel_div_bit, sel_div_bit_prev;

  logic write_block;

  wire  timer_enable = TAC[2];

  always_comb begin
    unique case (TAC[1:0])
      2'b00:
      sel_div_bit = DIV[9] & timer_enable;  // DMG ANDs with timer_enable before falling edge detections
      2'b01: sel_div_bit = DIV[3] & timer_enable;
      2'b10: sel_div_bit = DIV[5] & timer_enable;
      2'b11: sel_div_bit = DIV[7] & timer_enable;
    endcase
  end

  wire div_selected = bus.addr == 16'hFF04;
  wire tima_selected = bus.addr == 16'hFF05;
  wire tma_selected = bus.addr == 16'hFF06;
  wire tac_selected = bus.addr == 16'hFF07;

  /// Timer Tick (Falling Edge Detection)
  wire timer_tick = (sel_div_bit_prev == 1'b1) && (sel_div_bit == 1'b0);

  // ======================================================
  // Tick
  // ======================================================
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      DIV <= 16'h0000;
      TIMA <= 8'h00;
      TMA <= 8'h00;
      TAC <= 8'b11111000;

      IF_bus.timer_req <= 1'b0;

      write_block <= 1'b0;
      sel_div_bit_prev <= 1'b0;

    end else begin
      // Clear interrupt state by default
      IF_bus.timer_req <= 1'b0;

      // Divider always increments
      DIV <= DIV + 16'd1;

      sel_div_bit_prev <= sel_div_bit;

      // ======================================================
      // Write
      // ======================================================
      if (bus.write_en && div_selected) begin
        if (sel_div_bit) begin
          if (TIMA == 8'hFF) begin
            TIMA <= 8'h00;
            IF_bus.timer_req <= 1'b1;
          end else begin
            TIMA <= TIMA + 8'd1;
          end
        end

        // Writing any value resets DIV to 4.
        // TODO: Why 4? Idk, but this is what this does:
        // https://github.com/zephray/VerilogBoy/blob/ba256042fbd3274090df86828d84d09527559113/rtl/timer.v#L87
        DIV <= 16'd4;

      end else if (bus.write_en && tma_selected) begin
        // TMA write
        TMA <= bus.wdata;

        // fall-through during reload M-cycle
        if (write_block) TIMA <= bus.wdata;

      end else if (bus.write_en && tac_selected) begin
        // TAC write
        TAC <= bus.wdata | 8'b11111000;

      end else if (bus.write_en && tima_selected && !write_block) begin
        // TIMA write (blocked during reload M-cycle)
        TIMA <= bus.wdata;

      end else begin
        // ======================================================
        // Timer tick
        // ======================================================
        if (timer_tick) begin
          // Timer increments on falling edge of selected DIV bit
          TIMA <= TIMA + 8'd1;

          if (TIMA == 8'hFF) begin
            // interrupt not delayed
            IF_bus.timer_req <= 1'b1;
          end

        end else begin
          if (t_phase == gameboy_types_pkg::T1 && timer_enable) begin
            if (TIMA == 8'd0) begin
              TIMA <= TMA;
              write_block <= 1'b1;
            end else begin
              write_block <= 1'b0;
            end
          end
        end
      end
    end
  end

  // ======================================================
  // Read
  // ======================================================
  always_comb begin
    bus.rdata = 8'hFF;
    if (bus.read_en) begin
      if (div_selected) bus.rdata = DIV[15:8];  // Return the upper 8 bytes of DIV (MSB)
      else if (tima_selected) bus.rdata = TIMA;
      else if (tma_selected) bus.rdata = TMA;
      else if (tac_selected) bus.rdata = TAC;
    end
  end

endmodule

`endif
