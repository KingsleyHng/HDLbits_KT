module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    
    reg[1:0] state, next;
    
    always@(*) begin
        case(state)
            A: begin next = x ? B : A; z = 0; end 
            B: begin next = x ? B : C; z = 0; end            
            C: if(x) begin
               		next = B;
                	 z = 1;
            	end
            	else begin
                   next = A;
                    z = 0;
                end
        endcase
               
    end
    
    always@(posedge clk or negedge aresetn)begin
        if(!aresetn) begin
           state <= A;            
        end
        
        else begin
           state <= next; 
        end
        
    end
    
    
    
endmodule
