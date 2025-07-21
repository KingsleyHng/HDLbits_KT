module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    always@(posedge clk) begin
        if(reset) begin
           q <= 0; 
        end
        
        else if(q != 4'b1001) begin
            if (slowena) begin
          		 q <= q + 1; 
            end
        end   
        
        else if ( q == 4'b1001 & !slowena) begin
            q <= q;
        end
       
        else begin
           q <= 0; 
        end
        
    end
    
    
    
    
    
    
    
endmodule
