module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    wire ena_min;
    reg ena_hr;
    
    bcd_counter59 second (.clk(clk), .reset(reset), .enable(ena), .q(ss));
    assign ena_min = (ss == {4'b0101, 4'b1001}) ? 1 : 0;
    
    bcd_counter59 minutes (.clk(clk), .reset(reset), .enable(ena_min), .q(mm));    
    assign ena_hr = (mm == {4'b0101, 4'b1001} && ss == {4'b0101, 4'b1001}) ? 1 : 0;
    
    bcd_counter12 hour (.clk(clk), .reset(reset), .enable(ena_hr), .q(hh));    
 
    reg rpm;
 
    always @ (posedge clk) begin
        if (reset) begin
           rpm <= 0; 
        end
        
        else if (/*ena == 1'b1 &&*/ ss == {4'd5, 4'd9} && mm == {4'd5, 4'd9} && hh == {4'd1, 4'd1}) begin
           rpm <= ~rpm; 
        end
        
        
    end
    
    assign pm = rpm;
    

endmodule


module bcd_counter12 (input clk, input reset, input enable, output reg[7:0]q);
    
    
    
    always@(posedge clk) begin
        if (reset) begin
            q[3:0] <= 2;
            q[7:4] <= 1;
       
            
            
        end
        else if (enable) begin
           
            if (q[7:4] == 1 && q[3:0] == 2 ) begin
              
                q[3:0] <= 1;
                q[7:4] <= 0;
            end
            
            else if (q[3:0] == 4'b1001 && q[7:4] == 4'b0000) begin
                q[7:4] <= q[7:4] + 1; 
                q[3:0] <= 0;
            end
            
         	else begin
                q[3:0] <= q[3:0] + 1;    
            end  
         end 
        
      
        
      end
    
endmodule


module bcd_counter59 (input clk, input reset, input enable, output reg[7:0]q);
    
    always@(posedge clk) begin
        if (reset) begin
            q[3:0] <= 0;
            q[7:4] <= 0;
        end
  		else if (enable) begin
            if (q[7:4] == 5 && q[3:0] == 9 ) begin
                
                q[3:0] <= 0;
                q[7:4] <= 0;
            end
            
            else if (q[3:0] == 4'b1001) begin
                q[7:4] <= q[7:4] + 1; 
                q[3:0] <= 0;
            end
            
         	else begin
                q[3:0] <= q[3:0] + 1;    
            end  
         end 
      end
    
endmodule
