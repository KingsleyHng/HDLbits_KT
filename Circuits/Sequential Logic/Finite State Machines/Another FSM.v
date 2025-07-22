module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    
    
    parameter A = 0;
    parameter F_ASSERTED = 1;
    parameter F_ASSERTED_ONE_CLK = 10;
    parameter First_1 = 2;
    parameter Second_0 = 3;
    parameter Third_1 = 4;
    parameter G_ASSERTED = 5;
    parameter FOREVER_G_ONE = 6;
    parameter ONECLK_AFTER_G = 7;
    parameter DETECT_ONE_AFTER_ONECLK = 8;
    parameter TWOCLK_AFTER_G = 9;
    
    reg[3:0] state, next_state;
    
    always@(*) begin
        case(state)
        	A: next_state = F_ASSERTED;
   F_ASSERTED: next_state = F_ASSERTED_ONE_CLK;
   F_ASSERTED_ONE_CLK : next_state = x ? First_1 : F_ASSERTED_ONE_CLK;
    First_1  : next_state = x ? First_1 : Second_0;
    Second_0 : next_state = x ? G_ASSERTED :   F_ASSERTED_ONE_CLK;
    //Third_1  : next_state = G_ASSERTED;
G_ASSERTED   : next_state = y ? FOREVER_G_ONE : ONECLK_AFTER_G;
FOREVER_G_ONE : next_state = FOREVER_G_ONE;
ONECLK_AFTER_G : next_state = y ? DETECT_ONE_AFTER_ONECLK : TWOCLK_AFTER_G;
DETECT_ONE_AFTER_ONECLK : next_state = DETECT_ONE_AFTER_ONECLK;
TWOCLK_AFTER_G : next_state = TWOCLK_AFTER_G;            
        endcase
    end
    
    always@(posedge clk) begin
        if(!resetn) begin
           state <= A ;
        end
        else begin
           state <= next_state ;
        end               
    end
    
    assign f = (state == F_ASSERTED);
    assign g = (state == FOREVER_G_ONE) || (state == G_ASSERTED) || (state == DETECT_ONE_AFTER_ONECLK) ||(state == ONECLK_AFTER_G );
    
    

endmodule
