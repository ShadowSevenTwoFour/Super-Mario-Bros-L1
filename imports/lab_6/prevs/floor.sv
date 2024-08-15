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
    input logic [17:0] Ball_X_Pos, Ball_Y_Pos, background_offset,
    output logic [9:0] curYMax,
    output logic game_over, // 0 is alive, 1 is dead, 2 is a win
    output logic y_collision,
    input logic Reset, frame_clk
    );
    
    //bound logic
    logic [17:0] X_global, Y_global, X_left, X_right, Y_top, Y_bottom;
    assign X_global = Ball_X_Pos + background_offset;
    assign Y_global = Ball_Y_Pos;
    
    assign X_left = X_global - 16;
    assign X_right = X_global + 16;
    assign Y_top = Y_global - 15;
    assign Y_bottom = Y_global + 16;
    
    // fun stuff
    logic [9:0] base = 408;


   
//     always_ff @ (posedge frame_clk) begin:Floor_refresh
//        curYMax = 460;
//        y_collision = 0;
//        if(curYMax == 460) game_over <= 2'b01;

//        if((X_right >= 0 && X_left <= 554*4)) begin //first floor chunk
//            if((X_right >= 128*4 && X_left <= 136*4)) begin // && (Y_bottom <= 72*4)) begin //first question mark
//                if((Y_bottom <= 72*4 - 16)) begin
//                    curYMax = 72*4-16; 
//                end
//                if(Y_top < 80*4 + 48 && Y_top > 80*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base;
//            end else if((X_right >= 160*4 && X_left <= 200*4)) begin // second question mark lower 
//                if(Y_bottom <= 72*4 - 16) begin
//                    if((X_right >= 176*4 && X_left <= 184*4) && (Y_bottom <= 40*4 -16)) begin //second question mark upper 
//                        curYMax = 40*4-16; 
//                    end else begin
//                        curYMax = 72*4-16; 
//                    end
//                end
//                if(Y_top < 80*4 + 48 && Y_top > 80*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else if(Y_top < 48*4 + 48 && Y_top > 48*4) begin
//                    y_collision = 1;
//                    curYMax = 72*4-16; 
//                end else curYMax = base;

                 
//            end else if((X_right >= 225*4 && X_left <= 240*4) && (Y_bottom <= 88*4)) begin // first pipe
//                curYMax = 88*4-16; 
//            end else if((X_right >= 305*4 && X_left <= 321*4) && (Y_bottom <= 80*4)) begin // second pipe
//                curYMax = 80*4-16; 
//            end else if((X_right >= 369*4 && X_left <= 385*4) && (Y_bottom <= 73*4)) begin // third pipe
//                curYMax = 73*4-16; 
//            end else if((X_right >= 458*4 && X_left <= 473*4) && (Y_bottom <= 72*4)) begin // fourth pipe
//                curYMax = 72*4-16; 
//            end 
//            else begin
//                curYMax = base;
//            end
//        end
//        //////////////////////////////////////////////////////////////////////////////////////////////////
//        else if((X_right >= 571*4 && X_left <= 691*4)) begin //second floor chunk
//            if((X_right >= 618*4 && X_left <= 636*4)) begin //first question mark
//                if((Y_bottom <= 72*4 - 16)) begin
//                    curYMax = 72*4-16; 
//                end
//                if(Y_top < 80*4 + 48 && Y_top > 80*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base;  
//            end else if((X_right >= 642*4 && X_left <= 692*4)) begin // long platform
//                if((Y_bottom <= 40*4 - 16)) begin
//                    curYMax = 40*4-16; 
//                end
//                if(Y_top < 48*4 + 48 && Y_top > 48*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base;
//            end else begin
//                curYMax = base;
//            end
//        end
//        else if((X_right >= 692*4 && X_left <= 715*4)) begin // platform that goes over ditch lmao
//            if((X_right >= 690*4 && X_left <= 707*4)) begin // long platform pt2 
//                if((Y_bottom <= 40*4 - 16)) begin
//                    curYMax = 40*4-16; 
//                end
//                if(Y_top < 48*4 + 48 && Y_top > 48*4) begin
//                    y_collision = 1;
//                    curYMax = 460;
//                end else curYMax = 460;
//            end else begin
//                curYMax = 460;
//            end
//        end
//        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        else if( (X_right >= 716*4 && X_left <= 1228*4)) begin //third floor chunk
//            if((X_right >= 731*4 && X_left <= 754*4)) begin //first question mark
//                if((Y_bottom <= 40*4 - 16)) begin
//                    curYMax = 40*4-16; 
//                end
//                if(Y_top < 48*4 + 48 && Y_top > 48*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base;  
//            end else if((X_right >= 755*4 && X_left <= 763*4)) begin // long platform
//                if(Y_bottom <= 72*4 - 16) begin
//                    if((X_right >= 755*4 && X_left <= 763*4) && (Y_bottom <= 40*4 - 16)) begin //second question mark upper 
//                        curYMax = 40*4-16; 
//                    end else begin
//                        curYMax = 72*4-16; 
//                    end
//                end
//                if(Y_top < 80*4 + 20 && Y_top > 80*4-10) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else if(Y_top < 48*4 + 48 && Y_top > 48*4) begin
//                    y_collision = 1;
//                    curYMax = 72*4-16; 
//                end else curYMax = base;
               
//            end else if((X_right >= 803*4 && X_left <= 819*4)) begin // mini platform
//                if((Y_bottom <= 72*4 - 16)) begin
//                    curYMax = 72*4-16; 
//                end
//                if(Y_top < 80*4 + 48 && Y_top > 80*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base; 
//            end else if((X_right >= 851*4 && X_left <= 859*4)) begin // first question
//                if((Y_bottom <= 72*4 - 16)) begin
//                    curYMax = 72*4-16; 
//                end
//                if(Y_top < 80*4 + 48 && Y_top > 80*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base; 
//            end else if((X_right >= 875*4 && X_left <= 883*4)) begin // second question
//                if(Y_bottom <= 72*4 - 16) begin
//                    if((X_right >= 875*4 && X_left <= 883*4) && (Y_bottom <= 40*4 - 16)) begin //second question mark upper 
//                        curYMax = 40*4-16; 
//                    end else begin
//                        curYMax = 72*4-16; 
//                    end
//                end
//                if(Y_top < 80*4 + 48 && Y_top > 80*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else if(Y_top < 48*4 + 48 && Y_top > 48*4) begin
//                    y_collision = 1;
//                    curYMax = 72*4-16; 
//                end else curYMax = base;
//            end else if((X_right >= 900*4 && X_left <= 908*4)) begin // third question
//                if((Y_bottom <= 72*4 - 16)) begin
//                    curYMax = 72*4-16; 
//                end
//                if(Y_top < 80*4 + 48 && Y_top > 80*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base; 
//            end else if((X_right >= 948*4 && X_left <= 955*4)) begin // rando block
//                if((Y_bottom <= 72*4 - 16)) begin
//                    curYMax = 72*4-16; 
//                end
//                if(Y_top < 80*4 + 48 && Y_top > 80*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base; 
//            end else if((X_right >= 972*4 && X_left <= 989*4)) begin // high bricks
//                if((Y_bottom <= 40*4 - 16)) begin
//                    curYMax = 40*4-16; 
//                end
//                if(Y_top < 48*4 + 48 && Y_top > 48*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base;
//            end else if((X_right >= 1028*4 && X_left <= 1036*4)) begin // yet another brick stack 1
//                if((Y_bottom <= 40*4 - 16)) begin
//                    curYMax = 40*4-16; 
//                end
//                if(Y_top < 48*4 + 48 && Y_top > 48*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base;
//            end else if((X_right >= 1037*4 && X_left <= 1052*4) && (Y_bottom <= 72*4)) begin // yet another brick stack 2
//                if(Y_bottom <= 72*4 - 16) begin
//                    if((X_right >= 1037*4 && X_left <= 1052*4) && (Y_bottom <= 40*4 - 16)) begin //second question mark upper 
//                        curYMax = 40*4-16; 
//                    end else begin
//                        curYMax = 72*4-16; 
//                    end
//                end
//                if(Y_top < 80*4 + 48 && Y_top > 80*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else if(Y_top < 48*4 + 48 && Y_top > 48*4) begin
//                    y_collision = 1;
//                    curYMax = 72*4-16; 
//                end else curYMax = base;
//            end else if((X_right >= 1053*4 && X_left <= 1060*4)) begin // yet another brick stack 3
//                if((Y_bottom <= 40*4 - 16)) begin
//                    curYMax = 40*4-16; 
//                end
//                if(Y_top < 48*4 + 48 && Y_top > 48*4) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base; 
//            end
            
//            //Staircase 1
//            else if((X_right >= 1077*4 && X_left < 1085*4) && (Y_bottom <= 96*4)) begin 
//                curYMax = 96*4-16; 
//            end else if((X_right >= 1085*4 && X_left < 1093*4) && (Y_bottom <= 89*4)) begin 
//                curYMax = 89*4-16; 
//            end else if((X_right >= 1093*4 && X_left < 1101*4) && (Y_bottom <= 80*4)) begin 
//                curYMax = 80*4-16; 
//            end else if((X_right >= 1101*4 && X_left < 1109*4) && (Y_bottom <= 72*4)) begin 
//                curYMax = 72*4-16; 
//            end
            
//            //Staircase 2
//            else if((X_right >= 1125*4 && X_left < 1133*4) && (Y_bottom <= 72*4)) begin 
//                curYMax = 72*4-16; 
//            end else if((X_right >= 1133*4 && X_left < 1141*4) && (Y_bottom <= 80*4)) begin 
//                curYMax = 80*4-16; 
//            end else if((X_right >= 1141*4 && X_left < 1149*4) && (Y_bottom <= 89*4)) begin 
//                curYMax = 89*4-16; 
//            end else if((X_right >= 1149*4 && X_left < 1157*4) && (Y_bottom <= 96*4)) begin 
//                curYMax = 96*4-16; 
//            end
            
//            //Staircase 3
//            else if((X_right >= 1189*4 && X_left < 1197*4) && (Y_bottom <= 96*4)) begin 
//                curYMax = 96*4-16; 
//            end else if((X_right >= 1197*4 && X_left < 1205*4) && (Y_bottom <= 89*4)) begin 
//                curYMax = 89*4-16; 
//            end else if((X_right >= 1205*4 && X_left < 1213*4) && (Y_bottom <= 80*4)) begin 
//                curYMax = 80*4-16; 
//            end else if((X_right >= 1213*4 && X_left < 1229*4) && (Y_bottom <= 72*4)) begin 
//                curYMax = 72*4-16; 
//            end
            
//            else begin
//                curYMax = base;
//            end
//        end
//        else if((X_right >= 1246*4 && X_left <= 1801*4)) begin //last floor chunk
        
//            //Staircase 1
//            if((X_right >= 1246*4 && X_left < 1254*4) && (Y_bottom <= 72*4)) begin 
//                curYMax = 72*4-16; 
//            end else if((X_right >= 1254*4 && X_left < 1262*4) && (Y_bottom <= 80*4)) begin 
//                curYMax = 80*4-16; 
//            end else if((X_right >= 1262*4 && X_left < 1270*4) && (Y_bottom <= 89*4)) begin 
//                curYMax = 89*4-16; 
//            end else if((X_right >= 1270*4 && X_left <= 1278*4) && (Y_bottom <= 96*4)) begin 
//                curYMax = 96*4-16; 
//            end 
            
//            else if((X_right >= 1310*4 && X_left <= 1325*4) && (Y_bottom <= 89*4)) begin //pipe after stairs
//                curYMax = 89*4-16;  
//            end else if((X_right >= 1350*4 && X_left <= 1381*4)) begin // long platform
//                if((Y_bottom <= 72*4 - 16)) begin
//                    curYMax = 72*4-16; 
//                end
//                if(Y_top < 80*4 + 20 && Y_top > 80*4-10) begin
//                    y_collision = 1;
//                    curYMax = base;
//                end else curYMax = base; 
//            end else if((X_right >= 1439*4 && X_left <= 1454*4) && (Y_bottom <= 89*4)) begin // pipe
//                curYMax = 89*4-16; 
//            end 
            
//            //Staircase 3
//            else if((X_right >= 1455*4 && X_left < 1462*4) && (Y_bottom <= 96*4)) begin 
//                curYMax = 96*4-16; 
//            end else if((X_right >= 1462*4 && X_left < 1470*4) && (Y_bottom <= 89*4)) begin 
//                curYMax = 89*4-16; 
//            end else if((X_right >= 1470*4 && X_left < 1478*4) && (Y_bottom <= 80*4)) begin 
//                curYMax = 80*4-16; 
//            end else if((X_right >= 1478*4 && X_left < 1488*4) && (Y_bottom <= 72*4)) begin 
//                curYMax = 72*4-16; 
//            end else if((X_right >= 1488*4 && X_left < 1496*4) && (Y_bottom <= 65*4)) begin 
//                curYMax = 65*4-16; 
//            end else if((X_right >= 1496*4 && X_left < 1502*4) && (Y_bottom <= 56*4)) begin 
//                curYMax = 57*4-16; 
//            end else if((X_right >= 1502*4 && X_left < 1510*4) && (Y_bottom <= 49*4)) begin 
//                curYMax = 49*4-16; 
//            end else if((X_right >= 1510*4 && X_left < 1527*4) && (Y_bottom <= 40*4)) begin 
//                curYMax = 40*4-16; 
//            end 
//            else begin
//                curYMax = base;
//            end
            
//            if(X_right >= 1595*4) begin
//                game_over <= 2'b10;
//            end
//        end

//    end


    always_comb begin
        game_over = 0;
     if(Y_bottom <= 420) game_over = 1;
    end
    
     always_ff @ (posedge frame_clk) begin:Floor_refresh
        curYMax = 460;
        y_collision = 0;
        

        if((X_right >= 0 && X_left <= 554*4)) begin //first floor chunk
            if((X_right >= 128*4 && X_left <= 136*4) && (Y_bottom <= 73*4)) begin //first question mark
                curYMax = 73*4-16;  
            end else if((X_right >= 160*4 && X_left <= 200*4) && (Y_bottom <= 73*4)) begin // second question mark lower 
                if((X_right >= 176*4 && X_left <= 184*4) && (Y_bottom <= 41*4)) begin //second question mark upper 
                    curYMax = 41*4-16; 
                end else begin
                    curYMax = 73*4-16; 
                end 
            end else if((X_right >= 225*4 && X_left <= 240*4) && (Y_bottom <= 88*4)) begin // first pipe
                curYMax = 88*4-16; 
            end else if((X_right >= 305*4 && X_left <= 321*4) && (Y_bottom <= 82*4)) begin // second pipe
                curYMax = 82*4-16; 
            end else if((X_right >= 369*4 && X_left <= 385*4) && (Y_bottom <= 73*4)) begin // third pipe
                curYMax = 73*4-16; 
            end else if((X_right >= 458*4 && X_left <= 473*4) && (Y_bottom <= 73*4)) begin // fourth pipe
                curYMax = 73*4-16; 
            end 
            else begin
                curYMax = base;
            end
        end
        else if((X_right >= 571*4 && X_left <= 691*4)) begin //second floor chunk
            if((X_right >= 618*4 && X_left < 642*4) && (Y_bottom <= 73*4)) begin //first question mark
                curYMax = 73*4-16;  
            end else if((X_right >= 642*4 && X_left <= 692*4) && (Y_bottom <= 41*4)) begin // long platform
                curYMax = 41*4-16; 
            end 
            else begin
                curYMax = base;
            end
        end
        else if((X_right >= 692*4 && X_left <= 715*4)) begin // platform that goes over ditch lmao
            if((X_right >= 690*4 && X_left <= 707*4) && (Y_bottom <= 41*4)) begin // long platform pt2
                curYMax = 41*4-16;  
            end else begin
                curYMax = 460;
            end
        end
        else if( (X_right >= 716*4 && X_left <= 1228*4)) begin //third floor chunk
            if((X_right >= 731*4 && X_left <= 754*4) && (Y_bottom <= 41*4)) begin //first question mark
                curYMax = 41*4-16;  
            end else if((X_right >= 755*4 && X_left <= 763*4) && (Y_bottom <= 73*4)) begin // long platform
                if((X_right >= 755*4 && X_left <= 763*4) && (Y_bottom <= 41*4)) begin //second question mark upper 
                    curYMax = 41*4-16; 
                end else begin
                    curYMax = 73*4-16; 
                end  
            end else if((X_right >= 803*4 && X_left <= 819*4) && (Y_bottom <= 73*4)) begin // mini platform
                curYMax = 73*4-16; 
            end else if((X_right >= 851*4 && X_left <= 859*4) && (Y_bottom <= 73*4)) begin // first question
                curYMax = 73*4-16; 
            end else if((X_right >= 875*4 && X_left <= 883*4) && (Y_bottom <= 73*4)) begin // second question
                if((X_right >= 875*4 && X_left <= 883*4) && (Y_bottom <= 41*4)) begin //second question mark upper 
                    curYMax = 41*4-16; 
                end else begin
                    curYMax = 73*4-16; 
                end  
            end else if((X_right >= 900*4 && X_left <= 908*4) && (Y_bottom <= 73*4)) begin // third question
                curYMax = 73*4-16; 
            end else if((X_right >= 948*4 && X_left <= 955*4) && (Y_bottom <= 73*4)) begin // rando block
                curYMax = 73*4-16; 
            end else if((X_right >= 972*4 && X_left <= 989*4) && (Y_bottom <= 41*4)) begin // high bricks
                curYMax = 41*4-16; 
            end else if((X_right >= 1028*4 && X_left <= 1036*4) && (Y_bottom <= 41*4)) begin // yet another brick stack 1
                curYMax = 41*4-16; 
            end else if((X_right >= 1037*4 && X_left <= 1052*4) && (Y_bottom <= 73*4)) begin // yet another brick stack 2
                if((X_right >= 1037*4 && X_left <= 1052*4) && (Y_bottom <= 41*4)) begin //stack part 2 
                    curYMax = 41*4-16; 
                end else begin
                    curYMax = 73*4-16; 
                end  
            end else if((X_right >= 1053*4 && X_left <= 1060*4) && (Y_bottom <= 41*4)) begin // yet another brick stack 3
                curYMax = 41*4-16; 
            end
            
            //Staircase 1
            else if((X_right >= 1101*4 && X_left <= 1108*4) && (Y_bottom <= 72*4)) begin 
                curYMax = 72*4-16; 
            end else if((X_right >= 1093*4 && X_left <= 1100*4) && (Y_bottom <= 81*4)) begin 
                curYMax = 81*4-16; 
            end  else if((X_right >= 1085*4 && X_left <= 1092*4) && (Y_bottom <= 88*4)) begin 
                curYMax = 88*4-16; 
            end  
            else if((X_right >= 1077*4 && X_left <= 1084*4) && (Y_bottom <= 97*4)) begin 
                curYMax = 97*4-16; 
            end
            
            //Staircase 2
            else if((X_right >= 1125*4 && X_left <= 1132*4) && (Y_bottom <= 72*4)) begin 
                curYMax = 72*4-16; 
            end else if((X_right >= 1133*4 && X_left <= 1140*4) && (Y_bottom <= 81*4)) begin 
                curYMax = 81*4-16; 
            end else if((X_right >= 1141*4 && X_left <= 1148*4) && (Y_bottom <= 88*4)) begin 
                curYMax = 88*4-16; 
            end else if((X_right >= 1149*4 && X_left <= 1156*4) && (Y_bottom <= 97*4)) begin 
                curYMax = 97*4-16; 
            end
            
            //Staircase 3
            else if((X_right >= 1213*4 && X_left <= 1228*4) && (Y_bottom <= 72*4)) begin 
                curYMax = 72*4-16; 
            end else if((X_right >= 1205*4 && X_left <= 1212*4) && (Y_bottom <= 81*4)) begin 
                curYMax = 81*4-16; 
            end  else if((X_right >= 1197*4 && X_left <= 1204*4) && (Y_bottom <= 88*4)) begin 
                curYMax = 88*4-16; 
            end
            else if((X_right >= 1189*4 && X_left <= 1196*4) && (Y_bottom <= 97*4)) begin 
                curYMax = 97*4-16; 
            end
            
            else begin
                curYMax = base;
            end
        end
        else if((X_right >= 1246*4 && X_left <= 1801*4)) begin //last floor chunk
        
            //Staircase 1
            if((X_right >= 1246*4 && X_left <= 1253*4) && (Y_bottom <= 72*4)) begin 
                curYMax = 72*4-16; 
            end else if((X_right >= 1254*4 && X_left <= 1262*4) && (Y_bottom <= 81*4)) begin 
                curYMax = 81*4-16; 
            end else if((X_right >= 1263*4 && X_left <= 1269*4) && (Y_bottom <= 88*4)) begin 
                curYMax = 88*4-16; 
            end else if((X_right >= 1270*4 && X_left <= 1278*4) && (Y_bottom <= 97*4)) begin 
                curYMax = 97*4-16; 
            end 
            
            else if((X_right >= 1310*4 && X_left <= 1325*4) && (Y_bottom <= 89*4)) begin //pipe after stairs
                curYMax = 89*4-16;  
            end else if((X_right >= 1350*4 && X_left <= 1381*4) && (Y_bottom <= 73*4)) begin // long platform
                curYMax = 73*4-16; 
            end else if((X_right >= 1439*4 && X_left <= 1454*4) && (Y_bottom <= 89*4)) begin // long platform
                curYMax = 89*4-16; 
            end 
            
            //Staircase 3
             else if((X_right >= 1511*4 && X_left <= 1526*4) && (Y_bottom <= 41*4)) begin 
                curYMax = 41*4-16; 
            end  else if((X_right >= 1502*4 && X_left <= 1510*4) && (Y_bottom <= 49*4)) begin 
                curYMax = 49*4-16; 
            end  else if((X_right >= 1494*4 && X_left <= 1501*4) && (Y_bottom <= 57*4)) begin 
                curYMax = 57*4-16; 
            end  else if((X_right >= 1487*4 && X_left <= 1493*4) && (Y_bottom <= 65*4)) begin 
                curYMax = 65*4-16; 
            end else if((X_right >= 1478*4 && X_left <= 1486*4) && (Y_bottom <= 73*4)) begin 
                curYMax = 73*4-16; 
            end  else if((X_right >= 1470*4 && X_left <= 1477*4) && (Y_bottom <= 81*4)) begin 
                curYMax = 81*4-16; 
            end else if((X_right >= 1462*4 && X_left <= 1469*4) && (Y_bottom <= 89*4)) begin 
                curYMax = 89*4-16; 
            end
            else if((X_right >= 1455*4 && X_left <= 1461*4) && (Y_bottom <= 97*4)) begin 
                curYMax = 97*4-16; 
            end
            else if((X_right >= 1591*4 && X_left <= 1599*4) && (Y_bottom <= 97*4)) begin 
                curYMax = 97*4-16; 
            end
            else begin
                curYMax = base;
            end
        end

   end
    
   
    
endmodule
