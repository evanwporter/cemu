import cpu_types_pkg::*;
import types_pkg::*;

module ALU (
    ALU_if.ALU_side bus,
    Shifter_if.ALU_side shifter_bus
);

  logic [32:0] temp;

  always_comb begin
    // Defaults
    bus.result = 32'h0;
    bus.flags_out.n = 1'b0;
    bus.flags_out.z = 1'b0;
    bus.flags_out.c = bus.flags_out.c;

    case (bus.alu_op)

      ALU_OP_MOV: begin
        bus.result = shifter_bus.op_b;
      end

      ALU_OP_NOT: begin
        bus.result = ~shifter_bus.op_b;
      end

      ALU_OP_AND, ALU_OP_TEST: begin
        bus.result = bus.op_a & shifter_bus.op_b;
      end

      ALU_OP_XOR, ALU_OP_TEST_EXCLUSIVE: begin
        bus.result = bus.op_a ^ shifter_bus.op_b;
      end

      ALU_OP_OR: begin
        bus.result = bus.op_a | shifter_bus.op_b;
      end

      ALU_OP_BIT_CLEAR: begin
        bus.result = bus.op_a & ~shifter_bus.op_b;
      end

      ALU_OP_ADD, ALU_OP_CMP_NEG: begin
        temp            = {1'b0, bus.op_a} + {1'b0, shifter_bus.op_b};
        bus.result      = temp[31:0];
        bus.flags_out.c = temp[32];
        bus.flags_out.v = ~(bus.op_a[31] ^ shifter_bus.op_b[31]) & (bus.op_a[31] ^ bus.result[31]);
      end

      ALU_OP_ADC: begin
        temp            = {1'b0, bus.op_a} + {1'b0, shifter_bus.op_b} + bus.carry_in;
        bus.result      = temp[31:0];
        bus.flags_out.c = temp[32];
        bus.flags_out.v = ~(bus.op_a[31] ^ shifter_bus.op_b[31]) & (bus.op_a[31] ^ bus.result[31]);
      end

      ALU_OP_SUB, ALU_OP_CMP: begin
        temp            = {1'b0, bus.op_a} - {1'b0, shifter_bus.op_b};
        bus.result      = temp[31:0];
        bus.flags_out.c = ~temp[32];  // NOT borrow
        bus.flags_out.v = (bus.op_a[31] ^ shifter_bus.op_b[31]) & (bus.op_a[31] ^ bus.result[31]);
      end

      ALU_OP_SBC: begin
        temp            = {1'b0, bus.op_a} - {1'b0, shifter_bus.op_b} - ~bus.carry_in;
        bus.result      = temp[31:0];
        bus.flags_out.c = ~temp[32];
        bus.flags_out.v = (bus.op_a[31] ^ shifter_bus.op_b[31]) & (bus.op_a[31] ^ bus.result[31]);
      end

      ALU_OP_SUB_REVERSED: begin
        temp = {1'b0, shifter_bus.op_b} - {1'b0, bus.op_a};
        bus.result = temp[31:0];
        bus.flags_out.c = ~temp[32];
        bus.flags_out.v = (bus.op_a[31] ^ shifter_bus.op_b[31]) & (shifter_bus.op_b[31] ^ bus.result[31]);
      end

      default: begin
        bus.result = 32'h0;
      end

    endcase

    // Common flags
    bus.flags_out.n = bus.result[31];
    bus.flags_out.z = (bus.result == 32'h0);
  end


endmodule : ALU
