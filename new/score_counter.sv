`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2024 11:29:33 PM
// Design Name: 
// Module Name: score_counter
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


module score_counter(
        input logic frame_clk, Reset,
        input logic [1:0] current_state,
        input logic [17:0] DrawX, DrawY,
        input logic [3:0] total_coins,
        output logic font_pixel  
    );
    


    logic [3:0] hundreds, tens, ones;
   
    logic [10:0] fontaddr;
    logic [10:0] zero_offset = 10'h30;
    logic [7:0] fontdata;
   
    font_rom font(
        .addr(fontaddr),
        .data(fontdata)
    );


   
   
    always_comb begin
        if(DrawX < 28 && DrawX >= 20 && DrawY >= 0 && DrawY < 16) begin
            //get values
            ones = total_coins %10;
            fontaddr = 16*(ones + zero_offset) + DrawY;
            font_pixel = fontdata[7-(DrawX-20)%8];      
        end else
            font_pixel = 0;
    end 
endmodule
