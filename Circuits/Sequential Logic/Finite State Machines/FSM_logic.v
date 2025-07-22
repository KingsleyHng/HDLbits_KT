module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    
    reg[2:0] state, next;
    
    always@(*) begin
        case(y)
            A: next = x ? B : A;
            B: next = x ? E : B;            
            C: next = x ? B : C;            
            D: next = x ? C : B;  
            E: next = x ? E : D;   
            default: next = A;
        endcase      
    end
    

    
    
    assign z = (y == D) | (y == E);
    assign Y0 = next[0];
    
endmodule
