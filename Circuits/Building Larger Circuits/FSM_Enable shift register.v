module top_module (
    input clk,
    input reset,      // Synchronous reset
    output reg shift_ena);
    
    reg[1:0] cnt;
    
    always@(posedge clk) begin
        if(reset)begin
			cnt <= 0;
            shift_ena <= 1; 
        end
        else begin
           cnt <= cnt + 1; 
            if(cnt >= 2'd3) begin
           		shift_ena <= 0; 
       		end
                  
        end
    end
    
    /*always@(posedge clk) begin
        if(reset) begin
           shift_ena <= 1; 
        end
        
        else if(cnt >= 2'd3) begin
           shift_ena <= 0; 
        end
        
    end*/
    
    

endmodule
