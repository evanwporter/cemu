module cpu_tb (
    input logic clk,
    input logic reset
);
  Gameboy dut (
      .clk  (clk),
      .reset(reset)
  );

  initial begin
    $display("---- Gameboy CPU NOP Test ----");
    @(negedge reset);
    $display("[%0t] Reset released", $time);
    repeat (10) @(posedge clk);
    $display("[%0t] Done!", $time);
    $finish;
  end
endmodule
