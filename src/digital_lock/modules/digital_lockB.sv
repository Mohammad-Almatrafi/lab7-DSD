module digital_lockB (
    clk,
    rst_n,
    open,
    close,
    pwd,
    out
);

  input logic clk, rst_n, open, close, pwd;
  output logic [3:0] out;
  logic open_d;
  logic [1:0]p_state, n_state;
  logic [$clog2(500_000_000):0] n_count,p_count;
  localparam C = 2'b00, O = 2'b01,F = 2'b10;

  button_debouncer open_btn (
      .clk(clk),
      .rst_n(rst_n),
      .d(open),
      .q(open_d)
  );


  always @(p_state, close, open_d, pwd) begin
    case (p_state)
      C: begin 
        n_state = open_d ? ((pwd == 4'hf) ? O : C) : C;
      countEn = 1;end 
      O: n_state = close ? C : O;
      //   default: n_state = 1'b0;
    endcase
  end

  assign out = (p_state == C) ? 4'hc : 4'h0;

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) p_state <= C;
    else p_state <= n_state;
  end

always @(posedge clk,negedge rst_n) begin
    if(~rst_n) count = 'b0;
    else if (countEn) begin
        count = count+1;
    end

end
endmodule





endmodule
