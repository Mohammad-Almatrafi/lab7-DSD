

module digital_lockC (
    clk,
    rst_n,
    open,
    close,
    change,
    pwd,
    out
);

  input logic clk, open, change, close, rst_n;
  input logic [3:0] pwd;
  output logic [3:0] out;
  logic [3:0] True_pwd;
  logic [1:0] p_state, n_state;
  localparam C = 2'b00, O = 2'b01, F = 2'b10, E = 2'b11;
  logic [2:0] count;
  logic [$clog2(500_000_000):0] timer;
  logic wChange;

  button_debouncer debouncer (
      .clk(clk),
      .rst_n(rst_n),
      .d(change),
      .q(wChange)
  );

  always @(wChange, p_state, close, open, pwd) begin
    case (p_state)
      C: begin
        n_state  = count > 3 ? F : (open ? ((pwd == True_pwd) ? O : C) : C);
        timerRST = 1'b0;
        trialRST = 1'b1;
      end
      O: begin
        n_state  = close ? C : (wChange ? E : O);
        timerRST = 1'b0;
        trialRST = 1'b0;
      end
      F: begin
        n_state  = timer > 500_000_000 ? C : F;
        timerRST = 1'b1;
        trialRST = 1'b0;
      end
      E: begin
        n_state  = wChange ? O : E;
        True_pwd = pwd;
        timerRST = 1'b0;
        trialRST = 1'b0;
      end
    endcase
  end

  assign out = (p_state == C) ? 4'hc : ((p_state == F) ? 4'hf : (p_state == E ? 4'he : 4'h0));

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) p_state <= C;
    else p_state <= n_state;
  end

  logic trialRst, timerRst;
  logic trialRST, timerRST;
  assign trialRst = rst_n & trialRST;
  assign timerRst = rst_n & timerRST;
  always @(posedge open, negedge trialRst) begin
    if (~trialRst) begin
      count <= 'b0;
    end else count <= count + 1;

  end

  always @(posedge clk, negedge timerRst) begin
    if (~timerRst) begin
      timer <= 'b0;
    end else timer <= timer + 1;

  end
endmodule
