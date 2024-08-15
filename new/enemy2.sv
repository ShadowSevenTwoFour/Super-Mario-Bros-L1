`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2024 03:28:37 AM
// Design Name: 
// Module Name: enemy2
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

module enemy2(
    input logic [17:0] Ball_X_Pos, Ball_Y_Pos, background_offset,
    input logic frame_clk, Reset,
    output logic [17:0] enemy2_X_Pos_rel, enemy2_Y_Pos_rel, 
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
    
    
    parameter [17:0] enemy2_X_Center=1385*4;  // Center position on the X axis
    parameter [17:0] enemy2_Y_Center=408;  // Center position on the Y axis
    
    parameter [17:0] enemy2_X_Step=1;      // Step size on the X axis
    
    logic [17:0] enemy2_X_Pos, enemy2_Y_Pos;
    logic [17:0]  enemyX_left, enemyX_right, enemyY_top, enemyY_bottom, enemy2_X_vel, enemy2_X_vel_next, enemy2_X_Pos_next;
    
    assign enemy2_X_left = enemy2_X_Pos - 16;
    assign enemy2_X_right = enemy2_X_Pos + 16;
    assign enemy2_Y_top = enemy2_Y_Pos - 16;
    assign enemy2_Y_bottom = enemy2_Y_Pos + 16;
    
    
    always_comb begin
        enemy2_X_Pos_rel = enemy2_X_Pos - background_offset;
        enemy2_Y_Pos_rel = enemy2_Y_Pos;
        enemy2_X_vel_next = enemy2_X_vel;
        
        
        if(enemy2_X_left >= 1325*4 && enemy2_X_left <= 1327*4) begin
            enemy2_X_vel_next = ~(enemy2_X_vel) + 1;
        end
        if(enemy2_X_right >= 1437*4 && enemy2_X_right <= 1439*4) begin
            enemy2_X_vel_next = ~(enemy2_X_vel) + 1;
        end
        
         if ( (enemy2_X_Pos + 16) >= 1438*4 )  // Ball is at the right edge, BOUNCE!
        begin
            enemy2_X_vel_next = (~ (enemy2_X_Step) + 1'b1);  // set to -1 via 2's complement.
        end
        else if ( (enemy2_X_Pos - 16) <= 1326*4 )  // Ball is at the left edge, BOUNCE!
        begin
            enemy2_X_vel_next = enemy2_X_Step;
        end  
    end
    
    assign enemy2_X_Pos_next = enemy2_X_Pos + enemy2_X_vel;
    
    always_ff @ (posedge frame_clk or posedge Reset) begin
        if(Reset || state != 3'b001) begin
            enemy2_X_Pos <= enemy2_X_Center;
            enemy2_Y_Pos <= enemy2_Y_Center;
            enemy2_X_vel <= -1;
            collides <= 0;
        
        end else begin
            enemy2_X_vel <= enemy2_X_vel_next;
            enemy2_X_Pos <= enemy2_X_Pos_next;
            if(Ball_X_Pos >= enemy2_X_Pos_rel - 32 && Ball_X_Pos <= enemy2_X_Pos_rel + 32 && Ball_Y_Pos >= enemy2_Y_Pos_rel - 32 && Ball_Y_Pos <= enemy2_Y_Pos_rel + 32) begin
                 collides <= 1;
            end
        end
    
    end


    
    
endmodule
