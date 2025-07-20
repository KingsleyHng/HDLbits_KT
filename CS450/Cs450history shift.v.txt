module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    
    reg[31:0] shift;
    
    always@(posedge clk or posedge areset) begin
        if(areset) begin
            shift <= 0;
        end
        else begin
            
            if(train_mispredicted) begin
                shift <= {train_history[30:0], train_taken};
            end
            else if(predict_valid) begin
                shift <= {shift[30:0], predict_taken};
            end   
        end 
    end
    
 assign  predict_history = shift;
    
    
endmodule
