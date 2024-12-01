module button_debouncer (
    clk,
    rst_n,
    d,
    q
);

  input logic clk, rst_n, d;
  output logic q;
  logic n_state, p_state;

  always @(p_state, d) begin
    case (p_state)
      'b0: begin
        n_state = d;
        q = d;
      end
      'b1: begin
        n_state = d;
        q = 0;
      end
    endcase
  end

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) p_state <= 'b0;
    else p_state <= n_state;
  end

endmodule
