module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    
    
    assign out = (~a&~d) | (c&d&b) | (c&d&a) | (~c&a&~b) | (~c&d&~b);
    
endmodule
