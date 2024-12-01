
module tb_SD;

  logic Q;
  logic in, reset, clk;
  logic [3:0] count;

  SD dut (.*);

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    reset = 1;
    #1 reset = 0;
    #1 reset = 1;
    #1 in = 1;
    #3 @(negedge clk) in = 1;
    @(negedge clk) in = 1;
    @(negedge clk) in = 1;
    @(negedge clk) in = 0;
    @(negedge clk) in = 1;
    @(negedge clk) in = 1;
    @(negedge clk) in = 0;
    @(negedge clk) in = 1;
    @(negedge clk) in = 1;
    @(negedge clk) in = 0;
    @(negedge clk) in = 1;
    @(negedge clk) in = 1;
    @(negedge clk) in = 0;
    @(negedge clk) in = 1;
    @(negedge clk) in = 1;
    $finish;
  end

endmodule
