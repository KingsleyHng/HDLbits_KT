module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output reg start_shifting);
    
    localparam A = 0;
    localparam B = 1;
    localparam C = 2;
    localparam D = 3;
    localparam E = 4;

    
    reg[2:0] state, next_state;
    


always @(posedge clk) begin
    if (reset) begin
        state <= A;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
        if (next_state == E)
            start_shifting <= 1;
        else
            start_shifting <= 0;
    end
end

always @(*) begin
    case (state)
        A: next_state = data ? B : A;
        B: next_state = data ? C : A;
        C: next_state = data ? C : D;
        D: next_state = data ? E : A;
        E: next_state = E;
        default: next_state = A;
    endcase
end

endmodule
