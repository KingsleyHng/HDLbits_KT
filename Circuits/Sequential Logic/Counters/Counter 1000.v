module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
	
   reg [3:0] Q0, Q1, Q2;

// Generate a one-cycle pulse when Q2 reaches 9
    assign OneHertz = (Q2 == 4'b1001  && Q1== 4'b1001 && Q0== 4'b1001) ? 1'b1:1'b0;

// Enable signals for the counters
assign c_enable[0] = ~reset;
assign c_enable[1] = (Q0 == 4'b1001) && ~reset ? 1'b1 : 1'b0;
    assign c_enable[2] = (Q1 == 4'b1001 && Q0 ==4'b1001) ? 1'b1 : 1'b0;

// Counter instantiations
bcdcount counter0 (.clk(clk), .reset(reset), .enable(c_enable[0]), .Q(Q0));
bcdcount counter1 (.clk(clk), .reset(reset), .enable(c_enable[1]), .Q(Q1));
bcdcount counter2 (.clk(clk), .reset(reset), .enable(c_enable[2]), .Q(Q2));
endmodule
