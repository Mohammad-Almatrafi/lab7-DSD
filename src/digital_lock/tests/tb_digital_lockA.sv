//`include "digital_lock/modules/digital_lockA.sv"
module tb_digital_lockA;

  logic clk = 0, rst_n, open, close;
  logic [3:0] pwd, out;
  digital_lockA DUT (
      .clk  (clk),
      .rst_n(rst_n),
      .open (open),
      .close(close),
      .pwd  (pwd),
      .out  (out)
  );

  always #5 clk = ~clk;

  initial begin
    rst_n = 1;
    open  = 0;
    close = 0;
    pwd   = 0;
    #1;
    rst_n = 0;
    #1;
    rst_n = 1;

    repeat (3) @(negedge clk);

    open = 1;
    repeat (2) @(negedge clk);
    pwd = 4'hf;

    repeat (2) @(negedge clk);

    close = 1;
    open  = 0;
    repeat (2) @(negedge clk);

    $finish;

  end



endmodule
