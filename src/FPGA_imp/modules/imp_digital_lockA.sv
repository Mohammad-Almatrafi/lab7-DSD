module imp_digital_lockA (
    input wire CLK100MHZ,  // using the same name as pin names
    input wire CPU_RESETN,
    output wire CA,
    CB,
    CC,
    CD,
    CE,
    CF,
    CG,
    DP,
    output wire [7:0] AN,
    input wire [15:0] SW,
    input wire BTNC
);


  logic reset_n;
  logic clk;
  assign reset_n = CPU_RESETN;
  assign clk = CLK100MHZ;


  // Seven segments Controller
  wire [6:0] Seg;
  wire [3:0] digits[0:7];
  logic clk_out;
  logic [7:0] Ro;


  // assign digits[0] = 4'b1111;
  // assign digits[1] = 4'b1111;
  assign digits[2] = 4'b1111;
  assign digits[3] = 4'b1111;
  assign digits[4] = 4'b1111;
  assign digits[5] = 4'b1111;
  assign digits[6] = 4'b1111;
  assign digits[7] = 4'b1111;

  //   assign digits[0] = Ro[3:0];
  //   assign digits[1] = Ro[7:4];

  modN_clk #(
      .n(20_000_000)
  ) slowed_clock (
      .clk(clk),
      .en(1'b1),
      .rst_n(reset_n),
      .clk_out(clk_out)
  );

  DataTransferExecution #(
      .bits(8)
  ) DataTransfer (
      .clk(clk_out),
      .rst_n(reset_n),
      .Ro(Ro)
  );


  sev_seg_controller ssc (
      .clk(clk),
      .resetn(reset_n),
      .digits(digits),
      .Seg(Seg),
      .AN(AN)
  );


  assign {CG, CF, CE, CD, CC, CB, CA} = Seg;
  assign DP = 1'b1;  // turn off the dot point on seven segs


endmodule
