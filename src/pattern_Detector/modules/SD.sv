module SD (
    input clk,
    input reset,
    input in,
    output logic Q,
    output logic [3:0] count
);

  logic [2:0] n_state, p_state;

  localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, R = 3'b100;
  //Regester
  always @(posedge clk or negedge reset) begin
    if (~reset) p_state <= A;
    else p_state <= n_state;
  end

  //Next State
  always @(p_state, in) begin
    case (p_state)
      A: n_state = in ? B : A;
      B: n_state = in ? B : C;
      C: n_state = in ? D : A;
      D: n_state = in ? R : C;
      R: n_state = in ? B : C;
      default: n_state = 'b0;
    endcase
  end

  //Output

  assign Q = (p_state == R);

  //counter 
  always @(posedge clk or negedge reset) begin
    if (~reset) count <= 0;
    else if (Q) count <= count + 1;
  end
endmodule
