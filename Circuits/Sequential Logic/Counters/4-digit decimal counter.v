module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

 
    assign ena[1] = (q[3:0] == 4'b1001) ? 1 : 0;
    assign ena[2] = (q[7:4] == 4'b1001 && q[3:0] == 4'b1001) ? 1 : 0;
    assign ena[3] = (q[7:4] == 4'b1001 && q[3:0] == 4'b1001 && q[11:8] == 4'b1001) ? 1 : 0;
    bcd_counter0 counter0  (.clk(clk), .reset(reset), .q(q[3:0]));
    bcd_counter  counter1  (.clk(clk), .reset(reset), .enable(ena[1]), .q(q[7:4]));
    bcd_counter  counter2  (.clk(clk), .reset(reset), .enable(ena[2]), .q(q[11:8]));
    bcd_counter  counter3  (.clk(clk), .reset(reset), .enable(ena[3]), .q(q[15:12]));
    
   
endmodule



module bcd_counter(input clk, input reset, input enable, output [3:0] q);
     
     
    always@(posedge clk) begin
        if (reset) begin
            q <= 0; 
        end
        
        else if (enable) begin
            if (q == 4'b1001) begin
                q <= 0;
            end
            else begin
            	q <= q + 1;
            end  
        end
         
    end


endmodule


   
module bcd_counter0(input clk, input reset, output [3:0] q);
     
     
    always@(posedge clk) begin
        if (reset) begin
            q <= 0; 
        end
        
        else if (q == 4'b1001) begin
           	q <= 0; 
        end
        
        else begin
           q <= q + 1; 
        end
    end
       
endmodule
