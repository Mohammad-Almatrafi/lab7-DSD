module even_odd (
    input clk,
    input reset,
    input in,
    output logic out_1_even,
    output logic out_0_even
);

  logic [1:0] n_state, p_state;

  localparam e_e = 2'b00, e_o = 2'b01, o_e = 2'b10, o_o = 2'b11;

  //Regester
  always @(posedge clk or negedge reset) begin

    if (~reset) begin
      p_state <= e_e;
    end else p_state <= n_state;
  end

  //Next State
  always @(p_state, in) begin
    case (p_state)
      e_e: n_state = in ? e_o : o_e;
      e_o: n_state = in ? e_e : o_o;
      o_e: n_state = in ? o_o : e_e;
      o_o: n_state = in ? o_e : e_o;

      default: n_state = 'b0;
    endcase
  end

  //Output  
  assign out_1_even = (p_state == e_e) || (p_state == o_e);
  assign out_0_even = (p_state == e_o) || (p_state == e_e);



endmodule
