`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2024 01:15:35 PM
// Design Name: 
// Module Name: floor
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


module floor(
    input logic [9:0] DrawX, DrawY,
    output logic is_floor
    );
    
    always_comb begin
        if((DrawX >= 0) && (DrawX < 640) && (DrawY >= 460) && (DrawY < 480)) begin
            is_floor = 1;
        end
        else begin
            is_floor = 0;
        end
    end
    
endmodule
