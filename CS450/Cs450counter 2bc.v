module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset to weakly not-taken (2'b01)
            state <= 2'b01;
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    // Increment (saturate at 3)
                    if (state < 2'b11)
                        state <= state + 1'b1;
                end else begin
                    // Decrement (saturate at 0)
                    if (state > 2'b00)
                        state <= state - 1'b1;
                end
            end
            // If train_valid = 0, state remains unchanged
        end
    end
    

endmodule
