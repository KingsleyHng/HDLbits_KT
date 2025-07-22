module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter D = 3;
    parameter E = 4;
    parameter F = 5;
    
 
    
    reg[3:1] next_state;
    
    always@(*) begin
        case(y[3:1])
            A:next_state = w ? A : B;
            B:next_state = w ? D : C;
            C:next_state = w ? D : E;           
            D:next_state = w ? A : F;          
            E:next_state = w ? D : E;
            F:next_state = w ? D : C;                            
        endcase       
    end
                
    assign Y2 = (next_state[2] == 1);
    
    
    

endmodule
