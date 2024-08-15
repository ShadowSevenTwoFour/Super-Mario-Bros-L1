`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 12:58:01 PM
// Design Name: 
// Module Name: block_collisions
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


module block_collisions(
        input logic [17:0] Ball_X_Pos, Ball_Y_Pos, background_offset,
        output logic x_collision_left, x_collision_right
    );
     //bound logic
    logic [17:0] X_global, Y_global, X_left, X_right, Y_top, Y_bottom;
    assign X_global = Ball_X_Pos + background_offset;
    assign Y_global = Ball_Y_Pos;
    
    assign X_left = X_global - 16;
    assign X_right = X_global + 16;
    assign Y_top = Y_global - 16;
    assign Y_bottom = Y_global + 15;
    
    
    always_comb begin:horizontal_block_collisions
        x_collision_left = 0;
        x_collision_right = 0;
        if((X_right >= 0 && X_left <= 554*4)) begin //first floor chunk
            if((X_right >= 127*4 && X_right <= 129*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin //first question mark
                x_collision_right = 1;
            end else if((X_left >= 199*4 && X_left <= 201*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // second question mark lower 
                x_collision_left = 1; 
            end    
            else if((X_right >= 159*4 && X_right <= 161*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // second question mark lower 
                x_collision_right = 1; 
            end else if((X_left >= 199*4 && X_left <= 201*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // second question mark lower 
                x_collision_left = 1; 
            end 
            
            else if((X_right >= 175*4 && X_right <= 177*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin //second question mark upper 
                x_collision_right = 1;
            end else if((X_left >= 183*4 && X_left <= 185*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin //second question mark upper 
                x_collision_left = 1;
            end
            
            else if((X_right >= 224*4 && X_right <= 226*4) && (Y_bottom > 88*4 && Y_bottom < 480)) begin // first pipe
                x_collision_right = 1; 
            end 

            else if((X_left >= 239*4 && X_left <= 241*4) && (Y_bottom > 88*4 && Y_bottom < 480)) begin // first pipe
                x_collision_left = 1; 
            end 
            
            else if((X_right >= 304*4 && X_right <= 306*4) && (Y_bottom > 82*4 && Y_bottom < 480)) begin // second pipe
                x_collision_right = 1;  
            end else if((X_left >= 320*4 && X_left <= 322*4) && (Y_bottom > 82*4 && Y_bottom < 480)) begin // second pipe
                x_collision_left = 1;  
            end
            
            else if((X_right >= 368*4 && X_right <= 370*4) && (Y_bottom > 73*4 && Y_bottom < 480)) begin // third pipe
                x_collision_right = 1;  
            end else if((X_left >= 384*4 && X_left <= 386*4) && (Y_bottom > 73*4 && Y_bottom < 480)) begin // third pipe
                x_collision_left = 1;  
            end 
            
            else if((X_right >= 457*4 && X_right <= 459*4) && (Y_bottom > 73*4 && Y_bottom < 480)) begin // fourth pipe
                x_collision_right = 1;  
            end else if((X_left >= 472*4 && X_left <= 474*4) && (Y_bottom > 73*4 && Y_bottom < 480)) begin // fourth pipe
                x_collision_left = 1;  
            end
        end 
        
        else if((X_right >= 571*4 && X_left <= 691*4)) begin //second floor chunk
            if((X_right >= 617*4 && X_right <= 619*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin //first question mark
                x_collision_right = 1;
            end else if((X_left >= 641*4 && X_left <= 643*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin //first question mark
                x_collision_left = 1;
            end
            
            else if((X_right >= 641*4 && X_right <= 643*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin // long platform
                x_collision_right = 1;
            end 
        end
        else if((X_right >= 692*4 && X_left <= 715*4)) begin // platform that goes over ditch lmao
            if(( X_left >= 706*4 && X_left <= 708*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin // long platform pt2
                x_collision_left = 1;
            end else begin
            end
        end
        else if( (X_right >= 716*4 && X_left <= 1230*4)) begin //third floor chunk
            if((X_right >= 730*4 && X_right <= 732*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin //long platform pt1
                x_collision_right = 1;  
            end else if((X_left >= 762*4 && X_left <= 764*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin //long platform pt1
                x_collision_left = 1;  
            end 
            
            else if((X_right >= 755*4 && X_right <= 757*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // block under long platform
                 x_collision_right = 1; 
            end else if((X_left >= 762*4 && X_left <= 764*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // block under long platform
                 x_collision_left = 1; 
            end
            
            else if((X_right >= 802*4 && X_right <= 804*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // mini platform
                x_collision_right = 1; 
            end else if((X_left >= 818*4 && X_left <= 820*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // mini platform
                x_collision_left = 1; 
            end 
            
            else if((X_right >= 850*4 && X_right <= 852*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // first question
                x_collision_right = 1;
            end else if((X_left >= 858*4 && X_left <= 860*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // first question
                x_collision_left = 1;
            end 
            
            else if((X_right >= 874*4 && X_right <= 876*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // second question
                x_collision_right = 1;
            end else if((X_left >= 882*4 && X_left <= 884*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // second question
                x_collision_left = 1;
            end 
            
            else if((X_right >= 874*4 && X_right <= 876*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin //second question mark upper 
                x_collision_right = 1;
            end else if((X_left >= 882*4 && X_left <= 884*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin //second question mark upper 
                x_collision_left = 1;
            end 
            
            else if((X_right >= 899*4 && X_right <= 901*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // third question
                x_collision_right = 1;
            end else if((X_left >= 907*4 && X_left <= 909*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // third question
                x_collision_left = 1;
            end 
            
            else if((X_right >= 947*4 && X_right <= 949*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // rando block
                x_collision_right = 1;
            end else if((X_left >= 954*4 && X_left <= 956*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // rando block
                x_collision_left = 1;
            end 
            
            else if((X_right >= 971*4 && X_right <= 973*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin // high bricks
                x_collision_right = 1; 
            end else if((X_left >= 988*4 && X_left <= 990*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin // high bricks
                x_collision_left = 1; 
            end 
            
            else if((X_right >= 1027*4 && X_right <= 1029*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin // yet another brick stack high
                x_collision_right = 1;
            end else if((X_left >= 1059*4 && X_left <= 1061*4) && (Y_bottom > 41*4 && Y_bottom < 48*4)) begin // yet another brick stack high
                x_collision_left = 1;
            end
            
            else if((X_right >= 1036*4 && X_right <= 1038*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // yet another brick stack low
               x_collision_right = 1;
            end else if((X_left >= 1051*4 && X_left <= 1053*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // yet another brick stack low
               x_collision_left = 1;
            end
            
            //Staircase 1
            else if((X_left >= 1101*4 && X_left <= 1111*4) && (Y_bottom > 72*4 && Y_bottom < 480)) begin
                x_collision_left = 1;
            end
            else if((X_right >= 1101*4 && X_right <= 1109*4) && (Y_bottom > 72*4 && Y_bottom < 81*4)) begin 
                x_collision_right = 1;
            end else if((X_right >= 1093*4 && X_right <= 1109*4) && (Y_bottom > 81*4 && Y_bottom < 88*4)) begin 
                x_collision_right = 1; 
            end else if((X_right >= 1085*4 && X_right <= 1109*4) && (Y_bottom > 88*4 && Y_bottom < 97*4)) begin 
                x_collision_right = 1; 
            end 
            else if((X_right >= 1077*4 && X_right <= 1109*4) && (Y_bottom > 97*4 && Y_bottom < 480)) begin 
                x_collision_right = 1; 
            end 
            
            //Staircase 2
            else if((X_right >= 1125*4 && X_right <= 1133*4) && (Y_bottom > 72*4 && Y_bottom < 480)) begin
                x_collision_right = 1;
            end else if((X_left >= 1125*4 && X_left <= 1133*4) && (Y_bottom > 72*4 && Y_bottom < 81*4)) begin 
                x_collision_left = 1;
            end else if((X_left >= 1125*4 && X_left <= 1141*4) && (Y_bottom > 81*4 && Y_bottom < 88*4)) begin 
                x_collision_left = 1;
            end else if((X_left >= 1125*4 && X_left <= 1149*4) && (Y_bottom > 88*4 && Y_bottom < 97*4)) begin 
                x_collision_left = 1;
            end else if((X_left >= 1125*4 && X_left <= 1157*4) && (Y_bottom > 97*4 && Y_bottom < 480)) begin 
                x_collision_left = 1;
            end
            
            //Staircase 3
             else if((X_left >= 1213*4 && X_left <= 1231*4) && (Y_bottom > 72*4 && Y_bottom < 480)) begin
                x_collision_left = 1;
            end else if((X_right >= 1213*4 && X_right <= 1230*4) && (Y_bottom > 72*4 && Y_bottom < 81*4)) begin 
                x_collision_right = 1;
            end else if((X_right >= 1205*4 && X_right <= 1230*4) && (Y_bottom > 81*4 && Y_bottom < 88*4)) begin 
                x_collision_right = 1; 
            end else if((X_right >= 1197*4 && X_right <= 1230*4) && (Y_bottom > 88*4 && Y_bottom < 97*4)) begin 
                x_collision_right = 1; 
            end
            else if((X_right >= 1189*4 && X_right <= 1230*4) && (Y_bottom > 97*4 && Y_bottom < 480)) begin 
                x_collision_right = 1; 
            end 
            
        end
        else if((X_right >= 1245*4 && X_left <= 1801*4)) begin //last floor chunk
        
            //Staircase 1
            if((X_right >= 1245*4 && X_right <= 1254*4) && (Y_bottom > 72*4 && Y_bottom < 480)) begin
                x_collision_right = 1;
            end else if((X_left >= 1245*4 && X_left <= 1254*4) && (Y_bottom > 72*4 && Y_bottom < 81*4)) begin 
                x_collision_left = 1;
            end else if((X_left >= 1245*4 && X_left <= 1262*4) && (Y_bottom > 81*4 && Y_bottom < 88*4)) begin 
                x_collision_left = 1;
            end else if((X_left >= 1245*4 && X_left <= 1270*4) && (Y_bottom > 88*4 && Y_bottom < 97*4)) begin 
                x_collision_left = 1;
            end else if((X_left >= 1245*4 && X_left <= 1278*4) && (Y_bottom > 97*4 && Y_bottom < 480)) begin 
                x_collision_left = 1;
            end
            
            
            else if((X_right >= 1309*4 && X_right <= 1311*4) && (Y_bottom > 89*4 && Y_bottom < 480)) begin //pipe after stairs
                x_collision_right = 1;  
            end else if((X_left >= 1324*4 && X_left <= 1326*4) && (Y_bottom > 89*4 && Y_bottom < 480)) begin //pipe after stairs
                x_collision_left = 1;  
            end 
            
            else if((X_right >= 1349*4 && X_right <= 1351*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // long platform
                x_collision_right = 1; 
            end else if((X_left >= 1380*4 && X_left <= 1382*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin // long platform
                x_collision_left = 1; 
            end
            
            else if((X_right >= 1438*4 && X_right <= 1440*4) && (Y_bottom > 89*4 && Y_bottom < 480)) begin // pipe before final stairs
                x_collision_right = 1; 
            end else if((X_left >= 1453*4 && X_left <= 1455*4) && (Y_bottom > 89*4 && Y_bottom < 480)) begin // pipe before final stairs
                x_collision_left = 1; 
            end 
            
            //Staircase 2
             else if((X_left >= 1510*4 && X_left <= 1527*4) && (Y_bottom > 41*4 && Y_bottom < 480)) begin
                x_collision_left = 1;
            end  else if((X_right >= 1510*4 && X_right <= 1527*4) && (Y_bottom > 41*4 && Y_bottom < 49*4)) begin
                x_collision_right = 1;
            end  else if((X_right >= 1502*4 && X_right <= 1527*4) && (Y_bottom > 49*4 && Y_bottom < 57*4)) begin
                x_collision_right = 1;
            end  else if((X_right >= 1494*4 && X_right <= 1527*4) && (Y_bottom > 57*4 && Y_bottom < 65*4)) begin
                x_collision_right = 1;
            end else if((X_right >= 1486*4 && X_right <= 1527*4) && (Y_bottom > 65*4 && Y_bottom < 73*4)) begin
                x_collision_right = 1;
            end  else if((X_right >= 1478*4 && X_right <= 1527*4) && (Y_bottom > 73*4 && Y_bottom < 80*4)) begin 
                x_collision_right = 1;
            end  else if((X_right >= 1470*4 && X_right <= 1527*4) && (Y_bottom > 81*4 && Y_bottom < 89*4)) begin 
                x_collision_right = 1;
            end else if((X_right >= 1462*4 && X_right <= 1527*4) && (Y_bottom > 89*4 && Y_bottom < 97*4)) begin 
                x_collision_right = 1; 
            end
             else if((X_right >= 1454*4 && X_right <= 1527*4) && (Y_bottom > 97*4 && Y_bottom < 480)) begin
                x_collision_right = 1;
            end
            
            else if((X_right >= 1590*4 && X_right <= 1592*4) && (Y_bottom > 97*4 && Y_bottom < 480)) begin
                x_collision_right = 1;
            end 
            
            else if((X_left >= 1598*4 && X_left <= 1600*4) && (Y_bottom > 97*4 && Y_bottom < 480)) begin
                x_collision_left = 1;
            end
             
        end

    end
    
endmodule
    
    
    
    
    
    
    
    
