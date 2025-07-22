module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    localparam A = 0;
    localparam B = 1;
    localparam C = 2;
    localparam D = 3;
    localparam E = 4;
    localparam F = 5;
   
    reg[2:0] state, next;
    
    
    always@(*) begin
        case(state)
            A: next = w ? B: A;
            B: next = w ? C : D;
            C: next = w ? E : D;
            D: next = w ? F : A;
            E: next = w ? E: D;   
            F: next = w ? C : D ;         
            
            default: next = A;
        endcase
        
    end
    
    always@(posedge clk) begin
        if(reset) begin
           state <= A; 
        end
        
        else begin
           state <= next ;          
        end      
    end
    
    assign z = (state == F) || (state == E);
    
    
endmodule
