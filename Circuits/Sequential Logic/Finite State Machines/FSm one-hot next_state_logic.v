
module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    
    reg [6:1] next_state;
    
    assign next_state[1] = (y[1]|y[4])&w;
    assign next_state[2] = (y[1]&~w);
    assign next_state[3] = (y[2]|y[6])&~w;
    assign next_state[4] = (y[2]|y[3]|y[5]|y[6])&w;
    assign next_state[5] = (y[3]|y[5])&~w;
    assign next_state[6] = (y[4]&~w);
    
    assign Y2 = next_state[2];
    assign Y4 = next_state[4];
 
endmodule


 
