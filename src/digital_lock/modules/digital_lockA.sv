module digital_lockA (
    clk,
    rst_n,
    open,
    close,
    pwd,
    out
);

  input logic clk, open, close, rst_n;
  input logic [3:0] pwd;
  output logic [3:0] out;
  logic p_state, n_state;
  localparam C = 1'b0, O = 1'b1;

  always @(p_state, close, open, pwd) begin
    case (p_state)
      C: n_state = open ? ((pwd == 4'hf) ? O : C) : C;
      O: n_state = close ? C : O;
      //   default: n_state = 1'b0;
    endcase
  end

  assign out = (p_state == C) ? 4'hc : 4'h0;

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) p_state <= C;
    else p_state <= n_state;
  end

endmodule
