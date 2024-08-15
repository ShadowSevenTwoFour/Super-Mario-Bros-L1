`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 04:16:58 PM
// Design Name: 
// Module Name: enemy
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module enemy1(
    input logic [17:0] Ball_X_Pos, Ball_Y_Pos, background_offset,
    input logic frame_clk, Reset,
    output logic [17:0] enemy1_X_Pos_rel, enemy1_Y_Pos_rel, 
    output logic collides, is_right,
    input logic [1:0] state
    );
    
    //bound logic
    logic [17:0] X_global, Y_global, X_left, X_right, Y_top, Y_bottom;
    assign X_global = Ball_X_Pos + background_offset;
    assign Y_global = Ball_Y_Pos;
    
    assign X_left = X_global - 16;
    assign X_right = X_global + 16;
    assign Y_top = Y_global - 15;
    assign Y_bottom = Y_global + 16;
    
    
    parameter [17:0] enemy1_X_Center=424*4;  // Center position on the X axis
    parameter [17:0] enemy1_Y_Center=408;  // Center position on the Y axis
    
    parameter [17:0] enemy1_X_Step=1;      // Step size on the X axis
    
    logic [17:0] enemy1_X_Pos, enemy1_Y_Pos;
    logic [17:0]  enemyX_left, enemyX_right, enemyY_top, enemyY_bottom, enemy1_X_vel, enemy1_X_vel_next, enemy1_X_Pos_next;
    
    assign enemy1_X_left = enemy1_X_Pos - 16;
    assign enemy1_X_right = enemy1_X_Pos + 16;
    assign enemy1_Y_top = enemy1_Y_Pos - 16;
    assign enemy1_Y_bottom = enemy1_Y_Pos + 16;
    
    
    always_comb begin
        enemy1_X_Pos_rel = enemy1_X_Pos - background_offset;
        enemy1_Y_Pos_rel = enemy1_Y_Pos;
        enemy1_X_vel_next = enemy1_X_vel;
        
        
        if(enemy1_X_left >= 383*4 && enemy1_X_left <= 385*4) begin
            enemy1_X_vel_next = ~(enemy1_X_vel) + 1;
        end
        if(enemy1_X_right >= 458*4 && enemy1_X_right <= 460*4) begin
            enemy1_X_vel_next = ~(enemy1_X_vel) + 1;
        end
        
         if ( (enemy1_X_Pos + 16) >= 459*4 )  // Ball is at the right edge, BOUNCE!
        begin
            enemy1_X_vel_next = (~ (enemy1_X_Step) + 1'b1);  // set to -1 via 2's complement.
        end
        else if ( (enemy1_X_Pos - 16) <= 384*4 )  // Ball is at the left edge, BOUNCE!
        begin
            enemy1_X_vel_next = enemy1_X_Step;
        end  
    end
    
    assign enemy1_X_Pos_next = enemy1_X_Pos + enemy1_X_vel;
    
    always_ff @ (posedge frame_clk or posedge Reset) begin
        if(Reset || state != 3'b001) begin
            enemy1_X_Pos <= enemy1_X_Center;
            enemy1_Y_Pos <= enemy1_Y_Center;
            enemy1_X_vel <= -1;
            collides <= 0;
        
        end else begin
            enemy1_X_vel <= enemy1_X_vel_next;
            enemy1_X_Pos <= enemy1_X_Pos_next;
            if(Ball_X_Pos >= enemy1_X_Pos_rel - 32 && Ball_X_Pos <= enemy1_X_Pos_rel + 32 && Ball_Y_Pos >= enemy1_Y_Pos_rel - 32 && Ball_Y_Pos <= enemy1_Y_Pos_rel + 32) begin
                 collides <= 1;
            end
        end
    
    end


    
    
endmodule

