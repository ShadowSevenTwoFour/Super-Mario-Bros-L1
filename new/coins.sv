`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 07:12:19 PM
// Design Name: 
// Module Name: coins
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


module coins(
    input logic [17:0] Ball_X_Pos, Ball_Y_Pos, background_offset,
    input logic frame_clk, Reset,
    input logic [17:0] DrawX, DrawY,
    input logic [1:0] state,
    output logic [17:0] coin_pos_y_rel[8], coin_pos_x_rel[8], 
    output logic coin_collides[8],
    output logic [3:0] total_coins
    

    );
    
    

    
    logic [17:0] coin_pos_y[8], coin_pos_x[8];
    
    always_comb begin
        coin_pos_x[4] = 133*4;
        coin_pos_y[4] = 60*4;
        
        coin_pos_x[0] = 181*4;
        coin_pos_y[0] = 60*4;
        
        coin_pos_x[1] = 631*4;
        coin_pos_y[1] = 60*4;
        
        coin_pos_x[2] = 759*4;
        coin_pos_y[2] = 60*4;
        
        coin_pos_x[3] = 880*4;
        coin_pos_y[3] = 60*4;
        
        
        coin_pos_x[5] = 880*4;
        coin_pos_y[5] = 25*4;
        
        coin_pos_x[6] = 1118*4;
        coin_pos_y[6] = 96*4;
        
        coin_pos_x[7] = 1370*4;
        coin_pos_y[7] = 96*4;
        
        for(int i = 0; i < 8; i = i+1) begin
            coin_pos_x_rel[i] = coin_pos_x[i] - background_offset;
            coin_pos_y_rel[i] = coin_pos_y[i];
        end
        
    end
    
   always_ff @ (posedge frame_clk) begin:deactivate_coins
        if(Reset || state != 3'b001) begin
            for(int i = 0; i < 8; i++) begin
                coin_collides[i] <= 1;
            end
            total_coins <= 0;
        end else begin
             for(int i = 0; i < 8; i++) begin
                if(Ball_X_Pos >= coin_pos_x_rel[i] - 20 && Ball_X_Pos <= coin_pos_x_rel[i] + 20 && Ball_Y_Pos >= coin_pos_y_rel[i] - 20 && Ball_Y_Pos <= coin_pos_y_rel[i] + 20) begin
                    coin_collides[i] <= 0;
                end
                if(coin_collides[i] == 1 && Ball_X_Pos >= coin_pos_x_rel[i] - 20 && Ball_X_Pos <= coin_pos_x_rel[i] + 20 && Ball_Y_Pos >= coin_pos_y_rel[i] - 20 && Ball_Y_Pos <= coin_pos_y_rel[i] + 20) begin
                    total_coins <= total_coins + 1;
                end
            end
        end
    end
        
    
endmodule



