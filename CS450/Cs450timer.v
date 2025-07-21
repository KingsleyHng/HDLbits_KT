module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output  tc
);
    
    reg[9:0] cnt;
  
    
    assign tc = (cnt == 10'd0);
    
    always@(posedge clk) begin
        if(load)begin
           cnt <= data; 
        end
        
        else if (~load && cnt > 0) begin
            cnt <= cnt - 1;
            
        end
    
    end
    


endmodule
