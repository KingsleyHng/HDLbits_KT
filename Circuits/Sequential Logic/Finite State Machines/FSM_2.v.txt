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
            A: next = w ? A : B;
            B: next = w ? D : C;
            C: next = w ? D : E;
            D: next = w ? A : F;
            E: next = w ? D : E;   
            F: next = w ? D : C;           
            
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
