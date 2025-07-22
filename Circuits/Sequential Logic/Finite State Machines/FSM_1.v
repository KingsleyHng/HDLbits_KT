module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    
    reg[2:0] state, next;
    
    always@(*)begin
        case(state) 
            A:next = x ? B : A;
            B:next = x ? E : B;
            C:next = x ? B : C;
            D:next = x ? C : B;
            E:next = x ? E : D;
            default: next = A;            
        endcase        
    end
    
    always@(posedge clk) begin
        if(reset)begin
           state <= A; 
        end
        
        else begin
           state <= next; 
            
        end
        
        
    end

    
    assign z = (state == D) | (state ==E);
    
    
endmodule
