module tb_even_odd;

  logic clk, reset, in;
  logic out_1_even, out_0_even;

  even_odd dut (.*);

  initial clk = 0;
  always #5 clk = ~clk;


  initial begin
    reset = 1;
    #1 reset = 0;
    #1 reset = 1;
    #1 in = 1;
    #5 @(negedge clk) in = 0;
    @(negedge clk) in = 1;
    @(negedge clk) in = 0;
    @(negedge clk) in = 0;
    @(negedge clk) in = 1;
    @(negedge clk) in = 0;
    @(negedge clk) in = 1;
    @(negedge clk) in = 1;
    #5 $finish;
  end

endmodule
