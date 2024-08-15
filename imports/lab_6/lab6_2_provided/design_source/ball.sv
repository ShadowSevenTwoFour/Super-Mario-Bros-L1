//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf     03-01-2006                           --
//                                  03-12-2007                           --
//    Translated by Joe Meng        07-07-2013                           --
//    Modified by Zuofu Cheng       08-19-2023                           --
//    Modified by Satvik Yellanki   12-17-2023                           --
//    Fall 2024 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI Lab                                --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball 
( 
    input  logic        Reset, 
    input  logic        frame_clk,
    input logic         pix_clk,
    input  logic [31:0]  keycode,
    input logic [1:0] fsm_state,
    output logic [17:0]  Ball_X_Pos, Ball_Y_Pos, 
//    output logic [9:0]  BallY_Size, 
    output logic [1:0] health,
    output logic is_right,
    output logic game_over, game_win_out, jumping, running,
    output logic [17:0] background_offset
    
//    // goomba 1
//    output logic [17:0] enemy1_X_Pos_rel, enemy1_Y_Pos_rel 
);
    

	 
    parameter [17:0] Ball_X_Center=40;  // Center position on the X axis
    parameter [17:0] Ball_Y_Center=400;  // Center position on the Y axis
    parameter [17:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [17:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [17:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [17:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [17:0] Ball_X_Step=6;      // Step size on the X axis
    parameter [17:0] Ball_Y_Step=12;      // Step size on the Y axis



    
//    logic [9:0] BallX_Size = 10;
    
    //Position states
    logic [17:0] Ball_X_Pos_next;
    logic [17:0] Ball_Y_Pos_next;
    
    //Current states
    logic [17:0] Ball_X_velocity, Ball_Y_velocity;
    
    
    //Next states
    logic [17:0] Ball_X_velocity_next, Ball_Y_velocity_next;
    logic is_right_next;
    logic [1:0] health_next;
    logic is_walking_next;
    
    typedef enum logic {ON_GROUND, IN_AIR} state_t;
    state_t state, next_state;
    
    //Extra stuff
    logic [9:0] counter;
   
   //Frame logic to hold left side of the frame
   logic [17:0] background_offset_next;
   int X_Min = 0;
   int X_Max = 7200;
   int X_Width = 640;
   
   
   //floor
   logic [9:0] curYMax;
   logic x_collision_left, x_collision_right, y_collision;
   floor bottom(.frame_clk(frame_clk), .Reset(Reset), .Ball_X_Pos(Ball_X_Pos), .Ball_Y_Pos(Ball_Y_Pos), .curYMax(curYMax), .y_collision(y_collision), .background_offset(background_offset), .game_over(game_over));
   block_collisions blocks(.Ball_X_Pos(Ball_X_Pos), .Ball_Y_Pos(Ball_Y_Pos), .background_offset(background_offset), .x_collision_left(x_collision_left), .x_collision_right(x_collision_right)); 
   
   

    
    logic w,a,s,d;
    logic game_win;
    always_comb begin // Keycodes for movement
        w = 0;
        a = 0;
        s = 0;
        d = 0;
        game_win = 0;
        if(Ball_X_Pos+background_offset >= 1594*4) begin
            w = 0;
            a = 0;
            s = 0;
            d = 0;
            game_win = 1;
        end else begin
            case(keycode[7:0]) 
                8'h1A: begin
                    w = 1;
                end
                8'h04: begin
                    a = 1;
                end
                8'h16: begin
                    s = 1;
                end
                8'h07: begin
                    d = 1;
                end
            endcase
            case(keycode[15:8]) 
                8'h1A: begin
                    w = 1;
                end
                8'h04: begin
                    a = 1;
                end
                8'h16: begin
                    s = 1;
                end
                8'h07: begin
                    d = 1;
                end
            endcase
        end
//        case(keycode[23:16]) 
//            8'h1A: begin
//                w = 1;
//            end
//            8'h04: begin
//                a = 1;
//            end
//            8'h16: begin
//                s = 1;
//            end
//            8'h07: begin
//                d = 1;
//            end
//        endcase
//        case(keycode[31:24]) 
//            8'h1A: begin
//                w = 1;
//            end
//            8'h04: begin
//                a = 1;
//            end
//            8'h16: begin
//                s = 1;
//            end
//            8'h07: begin
//                d = 1;
//            end
//        endcase
    end
    
    always_comb begin
        if(state == IN_AIR) 
            jumping = 1;
        else
            jumping = 0;
        if(a || d) 
            running = 1;
        else
            running = 0;
    end
    
    logic move_left, move_right;
    always_comb begin
        Ball_X_Pos_next = Ball_X_Pos;
        background_offset_next = background_offset;
        move_left = 1;
        move_right = 1;
        if(game_win) begin
            if(Ball_Y_Pos >= 95*4 - 16) begin
                if(Ball_X_Pos+background_offset <= 1642*4) begin
                    background_offset_next = background_offset + 2;
                end
            end
        end else begin
            if(a) begin
                if(x_collision_left) begin
                    move_left = 0;
                end
                if (move_left == 1) begin
                    if(Ball_X_Pos >= X_Width/2 || (Ball_X_Pos < X_Width/2 && background_offset <= X_Min)) begin
                        Ball_X_Pos_next = Ball_X_Pos - Ball_X_Step;
                        if(Ball_X_Pos_next <= X_Min+16) begin
                            Ball_X_Pos_next = X_Min+16;
                        end
                    end else begin
                        background_offset_next = background_offset - Ball_X_Step;
                        if(background_offset_next <= 0) begin
                            background_offset_next = 0;
                        end
                    end         
                    is_right_next = 0;
                end
            end
            if(d) begin
                if(x_collision_right) begin
                    move_right = 0;
                end 
                if (move_right == 1) begin
                    if(Ball_X_Pos <= X_Width/2 || (Ball_X_Pos > X_Width/2 && background_offset >= X_Max - X_Width)) begin
                        Ball_X_Pos_next = Ball_X_Pos + Ball_X_Step;
                        if(Ball_X_Pos_next >= X_Width-16) begin
                            Ball_X_Pos_next = X_Width-16;
                        end
                    end else begin
                        background_offset_next = background_offset + Ball_X_Step;
                        if(background_offset_next >= X_Max - X_Width) begin
                            background_offset_next = X_Max - X_Width;
                        end
                    end   
                    is_right_next = 1;
                end
            end     
        end
    end
    
    
    always_comb begin
        Ball_Y_Pos_next = Ball_Y_Pos + Ball_Y_velocity;
    end
//    assign Ball_Y_Pos_next = Ball_Y_Pos + Ball_Y_velocity;
    logic [17:0] Ball_Y_Stage;
    assign Ball_Y_Stage = curYMax;
    

    always_ff @(posedge frame_clk) //make sure the frame clock is instantiated correctly
    begin: Move_Ball
        if (Reset || fsm_state != 3'b001)
        begin 
            state <= ON_GROUND;
			Ball_Y_Pos <= Ball_Y_Center;
			Ball_X_Pos <= Ball_X_Center;
			Ball_Y_velocity <= 10'd0; //Ball_Y_Step;
			is_right <= 1;
			health <= 2;
			background_offset <= 0;
	    end
        else 
        begin
            Ball_Y_Pos <= Ball_Y_Pos_next;
            Ball_X_Pos <= Ball_X_Pos_next;
            background_offset <= background_offset_next;
            is_right <= is_right_next;
            
            unique case(state)
                ON_GROUND: begin
                    if(Ball_Y_Pos_next < Ball_Y_Stage) begin
                        state <= IN_AIR;
                        Ball_Y_velocity <= 0;
                    end else begin
                        Ball_Y_Pos <= Ball_Y_Stage;
                    end
                    if(w) begin
                        state <= IN_AIR;
                        Ball_Y_velocity = -Ball_Y_Step;
                        counter = 0;
                    end else begin
                        Ball_Y_velocity = 0;
                    end
                end
                IN_AIR: begin
                    if(game_win) begin
                            Ball_Y_velocity = 2;
                            if(Ball_Y_Pos > Ball_Y_Stage || Ball_Y_Pos + Ball_Y_velocity > Ball_Y_Stage) begin
                                state <= ON_GROUND;
                                Ball_Y_Pos <= Ball_Y_Stage;
                            end
                    end else begin
                        if(counter != 8) begin
                            counter = counter + 1;
                        end else begin
                            Ball_Y_velocity = Ball_Y_velocity + 1;
                            if(Ball_Y_Pos > Ball_Y_Stage || Ball_Y_Pos + Ball_Y_velocity > Ball_Y_Stage) begin
                                state <= ON_GROUND;
                                Ball_Y_Pos <= Ball_Y_Stage;
                            end
                        end
                        if (Ball_Y_Pos <= 18) begin
                            Ball_Y_velocity = 6;
                        end
                    end
                end
            endcase
            
		end  
    end

     
    
      
endmodule





