//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  logic [17:0] BallX, BallY, DrawX, DrawY, Ball_size,
                        input logic pix_clk, frame_clk, is_right, vde, Reset,
                        input logic [17:0] background_offset,
                        input logic game_over, jumping, running,
                       output logic [3:0]  Red, Green, Blue,
                       input logic [7:0] keycode0,
                       
                       output logic [10:0] blockXdebug, blockYdebug,
                       output logic [2:0] fsm_state


                        );
    

   
   //screens fsm
    logic game_over_screen;
    logic game_active;  // Signal to control screen display in color_mapper
    logic [2:0] current_state;
    assign fsm_state = current_state;

    logic win;
    assign game_over = 0;
   screens_fsm screens_fsm(.frame_clk(frame_clk), .Reset(Reset),
    .keycode0(keycode0),
    .game_over_screen(game_over_screen),
    .game_active(game_active),  
    .win(win),
    .current_state(current_state));
   
   
   //timer
    logic [3:0] total_coins;
    score_counter score_counter(.frame_clk(frame_clk), .Reset(Reset), .current_state(current_state), .DrawX(DrawX), .DrawY(DrawY), .font_pixel(font_pixel), .total_coins(total_coins));

   //coins mario and goomba logic 
    logic ball_on;
    logic goomba1_on, goomba2_on;
	
	logic collides1, enemy1isright;
	logic [17:0] enemy1_X_Pos_rel, enemy1_Y_Pos_rel;
    enemy1 enemy1(.Ball_X_Pos(BallX), .Ball_Y_Pos(BallY), .background_offset(background_offset), .frame_clk(frame_clk), .Reset(Reset),
                    .enemy1_X_Pos_rel(enemy1_X_Pos_rel), .enemy1_Y_Pos_rel(enemy1_Y_Pos_rel), .collides(collides1), .is_right(enemy1isright) ,.state(current_state)); 
    
    
    logic collides2, enemy2isright;
	logic [17:0] enemy2_X_Pos_rel, enemy2_Y_Pos_rel;                
    enemy2 enemy2(.Ball_X_Pos(BallX), .Ball_Y_Pos(BallY), .background_offset(background_offset), .frame_clk(frame_clk), .Reset(Reset),
                    .enemy2_X_Pos_rel(enemy2_X_Pos_rel), .enemy2_Y_Pos_rel(enemy2_Y_Pos_rel), .collides(collides2), .is_right(enemy2isright) ,.state(current_state)); 
    
    //coins
    logic [17:0] coin_pos_y_rel[8], coin_pos_x_rel[8];
    logic coin_collides[8];
    logic coin_on[8];
    logic coin_display;

    
    coins coins( .Ball_X_Pos(BallX), .Ball_Y_Pos(BallY), .background_offset(background_offset), .frame_clk(frame_clk), .Reset(Reset), 
    .coin_pos_y_rel(coin_pos_y_rel), .coin_pos_x_rel(coin_pos_x_rel) , .coin_collides(coin_collides) ,.state(current_state), .total_coins(total_coins));
    
    logic [3:0] mario_red, mario_green, mario_blue;
    logic [3:0] mario_s_red, mario_s_green, mario_s_blue;
    logic [3:0] mario_r_red, mario_r_green, mario_r_blue;
    logic [3:0] mario_j_red, mario_j_green, mario_j_blue;
    
    logic [3:0] background_red, background_green, background_blue;
    logic [3:0] gs_red, gs_green, gs_blue;
    logic [3:0] go_red, go_green, go_blue;
    logic [3:0] gw_red, gw_green, gw_blue;
    logic [3:0] goomba1_red, goomba1_green, goomba1_blue;
    logic [3:0] goomba2_red, goomba2_green, goomba2_blue;
    
    always_comb begin
        if(jumping) begin
            mario_red = mario_j_red;
            mario_green = mario_j_green;
            mario_blue = mario_j_blue;
        end else if(running) begin
            mario_red = mario_r_red;
            mario_green = mario_r_green;
            mario_blue = mario_r_blue;
        end else begin
            mario_red = mario_s_red;
            mario_green = mario_s_green;
            mario_blue = mario_s_blue;
        end
    end
    
    logic lives;

    assign game_over_screen = ~lives;
    always_ff @(posedge frame_clk or posedge Reset) begin
        if(Reset || fsm_state != 3'b001) begin
            lives <= 1;
        end else begin
            if(collides1 == 1 || BallY >= 430 || collides2) begin
                lives <= 0;
            end
        end
    end
    always_comb
    begin:Ball_on_proc
         if ((DrawX >= BallX - 14) && (DrawX <= BallX + 15) && (DrawY >= BallY - 15) && (DrawY <= BallY + 15))
            ball_on = 1'b1;
         else 
            ball_on = 1'b0;
         
         if((DrawX >= enemy1_X_Pos_rel - 16) && (DrawX <= enemy1_X_Pos_rel + 16) && (DrawY >= enemy1_Y_Pos_rel - 16) && (DrawY <= enemy1_Y_Pos_rel + 16)) begin
            goomba1_on = 1'b1;
         end else begin
            goomba1_on = 1'b0;
         end
         
         if((DrawX >= enemy2_X_Pos_rel - 16) && (DrawX <= enemy2_X_Pos_rel + 16) && (DrawY >= enemy2_Y_Pos_rel - 16) && (DrawY <= enemy2_Y_Pos_rel + 16)) begin
            goomba2_on = 1'b1;
         end else begin
            goomba2_on = 1'b0;
         end

         for(int i = 0; i < 8; i++) begin
                if(coin_collides[i]) begin
                    if ((DrawX - coin_pos_x_rel[i])*(DrawX - coin_pos_x_rel[i]) + (DrawY - coin_pos_y_rel[i])*(DrawY - coin_pos_y_rel[i]) <= 10*10) begin
                        coin_on[i] = 1;
                    end else begin
                        coin_on[i] = 0;
                    end
                end
            end    

            if ((DrawX - 8)*(DrawX - 8) + (DrawY - 8)*(DrawY - 8) <= 6*6) begin
                coin_display = 1;
            end else begin
                coin_display = 0;

        end
     end 
       

    always_comb begin
        win = 0;
        if (BallX + background_offset >= 1641*4) begin
            win = 1;
        end
    end
    always_ff @ (posedge pix_clk) begin
        case(current_state)
            3'b000: begin // start
                Red <= gs_red;
                Green <= gs_green;
                Blue <= gs_blue;
            end
            3'b001: begin
                if (ball_on && {mario_red,mario_green,mario_blue} != 12'hf0f) begin
                    Red <= mario_red;
                    Green <= mario_green;
                    Blue <= mario_blue;
                end
                 else if (goomba1_on && {goomba1_red,goomba1_green,goomba1_blue} != 12'hf0f) begin
                    Red <= goomba1_red;
                    Green <= goomba1_green;
                    Blue <= goomba1_blue;
                end
                else if (goomba2_on && {goomba2_red,goomba2_green,goomba2_blue} != 12'hf0f) begin
                    Red <= goomba2_red;
                    Green <= goomba2_green;
                    Blue <= goomba2_blue;
                end
                else if(coin_display) begin
                    Red <= 4'hf;
                    Green <= 4'hf;
                    Blue <= 4'h0;
                end
                else if(coin_on[0]) begin
                    Red <= 4'hf;
                    Green <= 4'hf;
                    Blue <= 4'h0;
                end else if(coin_on[1]) begin
                    Red <= 4'hf;
                    Green <= 4'hf;
                    Blue <= 4'h0;
                end else if(coin_on[2]) begin
                    Red <= 4'hf;
                    Green <= 4'hf;
                    Blue <= 4'h0;
                end else if(coin_on[3]) begin
                    Red <= 4'hf;
                    Green <= 4'hf;
                    Blue <= 4'h0;   
                end else if(coin_on[4]) begin
                    Red <= 4'hf;
                    Green <= 4'hf;
                    Blue <= 4'h0;   
                end else if(coin_on[5]) begin
                    Red <= 4'hf;
                    Green <= 4'hf;
                    Blue <= 4'h0;   
                end else if(coin_on[6]) begin
                    Red <= 4'hf;
                    Green <= 4'hf;
                    Blue <= 4'h0;   
                end else if(coin_on[7]) begin
                    Red <= 4'hf;
                    Green <= 4'hf;
                    Blue <= 4'h0;   
                end 
                
                //counter 
                else if(font_pixel) begin
                    Red <= 4'h0;
                    Green <= 4'h0;
                    Blue <= 4'h0;
                end 
                
                else begin
                    Red <= background_red;
                    Green <= background_green;
                    Blue <= background_blue;
                end
            end
            3'b010: begin //WIN
                Red <= gw_red;
                Green <= gw_green;
                Blue <= gw_blue;
            end
            3'b011: begin //LOSE
                Red <= go_red;
                Green <= go_green;
                Blue <= go_blue;
            end
            
            3'b100: begin //WIN HALT
                Red <= gw_red;
                Green <= gw_green;
                Blue <= gw_blue;
            end
            3'b101: begin //LOSE HALT
                Red <= go_red;
                Green <= go_green;
                Blue <= go_blue;
            end
       endcase     

    end
   
 
mario8bitright_processed_example mario8bitright_processed_example (
	.vga_clk(pix_clk),
	.DrawX(DrawX-BallX-16), 
	.DrawY(DrawY-BallY-16),
	.blank(vde),
	.red(mario_s_red), 
	.green(mario_s_green),
	.blue(mario_s_blue),
	.is_right(is_right)
);

mario_jumping_example mario_jumping_example (
	.vga_clk(pix_clk),
	.DrawX(DrawX-BallX-16), 
	.DrawY(DrawY-BallY-16),
	.blank(vde),
	.red(mario_j_red), 
	.green(mario_j_green),
	.blue(mario_j_blue),
	.is_right(is_right)
); 

mario_running_example mario_running_example (
	.vga_clk(pix_clk),
	.DrawX(DrawX-BallX-16), 
	.DrawY(DrawY-BallY-16),
	.blank(vde),
	.red(mario_r_red), 
	.green(mario_r_green),
	.blue(mario_r_blue),
	.is_right(is_right)
);    
    
background_example background_example (
	.vga_clk(pix_clk),
	.DrawX(DrawX+background_offset),
	.DrawY(DrawY),
	.blank(vde),
	.red(background_red), 
	.green(background_green),
	.blue(background_blue)
);

mario_lose_example mario_lose_example (
	.vga_clk(pix_clk),
	.DrawX(DrawX),
	.DrawY(DrawY),
	.blank(vde),
	.red(go_red), 
	.green(go_green),
	.blue(go_blue)
);
    
    
mario_start_example mario_start_example (
	.vga_clk(pix_clk),
	.DrawX(DrawX),
	.DrawY(DrawY),
	.blank(vde),
	.red(gs_red), 
	.green(gs_green),
	.blue(gs_blue)
);

mario_win_example mario_win_example (
	.vga_clk(pix_clk),
	.DrawX(DrawX),
	.DrawY(DrawY),
	.blank(vde),
	.red(gw_red), 
	.green(gw_green),
	.blue(gw_blue)
);

goomba_example goomba1 (
	.vga_clk(pix_clk),
	.DrawX(DrawX - enemy1_X_Pos_rel - 16),
	.DrawY(DrawY - enemy1_Y_Pos_rel - 16),
	.blank(vde),
	.red(goomba1_red), 
	.green(goomba1_green),
	.blue(goomba1_blue)
);
    
goomba_example goomba2 (
	.vga_clk(pix_clk),
	.DrawX(DrawX - enemy2_X_Pos_rel - 16),
	.DrawY(DrawY - enemy2_Y_Pos_rel - 16),
	.blank(vde),
	.red(goomba2_red), 
	.green(goomba2_green),
	.blue(goomba2_blue)
);
    
    
endmodule
