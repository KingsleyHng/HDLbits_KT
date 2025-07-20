module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output fr2,
    output fr1,
    output dfr
); 

   localparam [2:0] A  = 3'd0,	//water level:below s1    
					 B0 = 3'd1,	//s1~s2, and previous level is higher
					 B1 = 3'd2,	//s1~s2, and previous level is lower
					 C0 = 3'd3,	//s2~s3, and previous level is higher
					 C1 = 3'd4,	//s2~s3, and previous level is lower
					 D  = 3'd5;	//above s3

	reg [2:0] state, next_state;

	always @(posedge clk) begin
		if(reset) state <= A;
		else state <= next_state;
	end
    
   	always @(*) begin
		case(state)
			A 	:	next_state = (s[1]) ? B1 : A;
			B0 	: 	next_state = (s[2]) ? C1 : ((s[1]) ? B0 : A);
			B1	:	next_state = (s[2]) ? C1 : ((s[1]) ? B1 : A);
			C0	:	next_state = (s[3]) ? D  : ((s[2]) ? C0 : B0);
			C1	:	next_state = (s[3]) ? D  : ((s[2]) ? C1 : B0);
			D 	:	next_state = (s[3]) ? D  : C0;
			default : next_state = 3'bxxx;
		endcase
	end
    
    always@(*) begin
        case(state)
            A: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;  
            end
         B0: begin
                fr3 = 0;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;  
            end            
          B1: begin
                fr3 = 0;
                fr2 = 1;
                fr1 = 1;
                dfr = 0;  
            end   
       C0: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 1;
                dfr = 1;  
            end         
        C1: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 1;
                dfr = 0;  
            end                       
        D: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
                dfr = 0;  
            end              
            
        endcase
        
        
        
    end

   

endmodule
