package cpu_util_pkg;

  function automatic logic eval_cond(input logic [3:0] cond, input logic N, input logic Z,
                                     input logic C, input logic V);
    case (cond)
      4'b0000: eval_cond = Z;  // EQ
      4'b0001: eval_cond = !Z;  // NE
      4'b0010: eval_cond = C;  // CS/HS
      4'b0011: eval_cond = !C;  // CC/LO
      4'b0100: eval_cond = N;  // MI
      4'b0101: eval_cond = !N;  // PL
      4'b0110: eval_cond = V;  // VS
      4'b0111: eval_cond = !V;  // VC
      4'b1000: eval_cond = C && !Z;  // HI
      4'b1001: eval_cond = !C || Z;  // LS
      4'b1010: eval_cond = (N == V);  // GE
      4'b1011: eval_cond = (N != V);  // LT
      4'b1100: eval_cond = !Z && (N == V);  // GT
      4'b1101: eval_cond = Z || (N != V);  // LE
      4'b1110: eval_cond = 1'b1;  // AL
      4'b1111: eval_cond = 1'b0;  // NV (never)
      default: eval_cond = 1'b0;
    endcase
  endfunction

endpackage : cpu_util_pkg
