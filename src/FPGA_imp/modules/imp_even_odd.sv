module imp_even_odd (
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
    output wire [1:0] LED,
    input wire [15:0] SW,
    input wire BTNC
);


  logic reset_n;
  logic clk;
  assign reset_n = CPU_RESETN;
  assign clk = CLK100MHZ;


  // Seven segments Controller
  wire  [6:0] Seg;
  wire  [3:0] digits[0:7];
  logic [3:0] count;


  assign digits[0] = 4'b1111;
  assign digits[1] = 4'b1111;
  assign digits[2] = 4'b1111;
  assign digits[3] = 4'b1111;
  assign digits[4] = 4'b1111;
  assign digits[5] = 4'b1111;
  assign digits[6] = 4'b1111;
  assign digits[7] = 4'b1111;
  //   assign digits[0] = ;

  logic out_1_even, out_0_even;
  even_odd d (
      .clk(BTNC),
      .reset(reset_n),
      .in(SW[0]),
      .out_1_even(out_1_even),
      .out_0_even(out_0_even)
  );
  //   assign digits[1] = Ro[7:4];

  assign LED[0] = out_0_even;
  assign LED[1] = out_1_even;


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