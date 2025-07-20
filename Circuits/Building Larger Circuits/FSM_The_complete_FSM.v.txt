module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    // State encoding
    localparam IDLE                = 3'd0;
    localparam DETECTED_FIRST_ONE  = 3'd1;
    localparam DETECTED_SECOND_ONE = 3'd2;
    localparam DETECTED_THIRD_ZERO = 3'd3;
    localparam SHIFT_ENA_WAIT      = 3'd4;
    localparam COUNTING_WAIT       = 3'd5;
    localparam DONE_COUNTING       = 3'd6;

    reg [2:0] state;
    reg [2:0] cnt;  // 3 bits for cnt 0-4

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            cnt <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            // Default outputs unless overridden


            case (state)
                IDLE: begin
                    done <= 0;
                    cnt <= 0;
                    if (data)
                        state <= DETECTED_FIRST_ONE;
                end

                DETECTED_FIRST_ONE: begin
                    if (data)
                        state <= DETECTED_SECOND_ONE;
                    else
                        state <= IDLE;
                end

                DETECTED_SECOND_ONE: begin
                    if (~data)
                        state <= DETECTED_THIRD_ZERO;
                end

                DETECTED_THIRD_ZERO: begin
                    if (data) begin
                        state <= SHIFT_ENA_WAIT;
                    	shift_ena <= 1;
                    end
                    else
                        state <= IDLE;
                end

                SHIFT_ENA_WAIT: begin
                    shift_ena <= 1;
                    cnt <= cnt + 1;
                    if (cnt == 3) begin  // 4 cycles: cnt=0,1,2,3
                        shift_ena <= 0;
                        cnt <= 0;
                        counting <= 1;
                        state <= COUNTING_WAIT;
                    end
                end

                COUNTING_WAIT: begin
                    counting <= 1;
                    if (done_counting) begin
                        counting <= 0;
                        done <= 1;
                        state <= DONE_COUNTING;
                    end
                end

                DONE_COUNTING: begin
                    done <= 1;
                    if (ack) begin
                        done <= 0;
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
