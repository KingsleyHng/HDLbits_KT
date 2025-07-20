module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 


    parameter LEFT = 0;
    parameter RIGHT = 1;
    parameter FALL_previous_left = 2;
    parameter FALL_previous_right = 3;
    reg [2:0]state, next_state;
    reg stored_reg;

    always @(*) begin
        case(state)
            LEFT: if(bump_left && ~bump_right && ground ) begin
               next_state = RIGHT; 
            end
            else if(bump_right && ~bump_left  && ground) begin
               next_state =  LEFT;
            end
            else if(bump_right && bump_left  && ground) begin
                next_state = RIGHT;
            end
            
            else if(~ground) begin
               next_state = FALL_previous_left;
            end
            else begin
                next_state = LEFT;
            end
            
            RIGHT: if(bump_left && ~bump_right && ground ) begin
               next_state = RIGHT; 
            end
            else if(bump_right && ~bump_left && ground) begin
               next_state =  LEFT;
            end
            else if(bump_right && bump_left && ground) begin
                next_state = LEFT;
            end
            else if(~ground) begin
               next_state = FALL_previous_right; 
            end
            else begin
                next_state = RIGHT;
            end       
            
            FALL_previous_left:
            if(ground) begin
                next_state = LEFT;
            end
            else begin
                next_state = FALL_previous_left;
            end
          FALL_previous_right:
            if(ground) begin
                next_state = RIGHT;
            end
            else begin
                next_state = FALL_previous_right;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset) begin
           state <= LEFT; 
  
        end
        else begin
           state <= next_state; 
        end
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_previous_left || state == FALL_previous_right);

endmodule


