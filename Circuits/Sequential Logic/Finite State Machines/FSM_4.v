module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter D = 3;
    
    reg[2:0] state, next;
    
    always@(*) begin
        case(state)
            A: if(r[1]) next = B;
            else if (~r[1] & r[2]) next = C;
            else if (~r[1] & ~r[2] & r[3]) next = D;
            else if (~r[1] & ~r[2] & ~r[3]) next = A;
            
            B: if(r[1]) next = B;
            else if (~r[1]) next = A;
          
            C: if(r[2]) next = C;
            else if (~r[2]) next = A;
      
            D: if(r[3]) next = D;
            else if (~r[3]) next = A;            
            
            default: next = B;
        endcase      
    end
    
    
    always@(posedge clk) begin
        if(!resetn) begin
           state <= A; 
        end     
        else begin
           state <= next; 
        end
        
    end
    
    
    assign g[1] = (state == B);
    assign g[2] = (state == C);   
    assign g[3] = (state == D);   

endmodule
