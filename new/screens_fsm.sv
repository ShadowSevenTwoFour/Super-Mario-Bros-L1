`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2024 01:12:37 AM
// Design Name: 
// Module Name: screens_fsm
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


module screens_fsm(
    input logic frame_clk,
    input logic Reset,
    input logic [7:0] keycode0, // Transition trigger from start screen to game
    input logic game_over_screen, win,
    output logic game_active,  // Signal to control screen display in color_mapper
    output logic [2:0] current_state 
);

    typedef enum logic [2:0] {
        START_SCREEN = 3'b000,
        GAME_SCREEN = 3'b001,
        WIN_SCREEN = 3'b010,
        LOSE_SCREEN = 3'b011,
        HALT2 = 3'b100,
        HALT1 = 3'b101
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge frame_clk) begin
        if (Reset)
            state <= START_SCREEN;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case(state)
            START_SCREEN: begin
                if (keycode0 == 8'h2c) // spacebar
                    next_state = GAME_SCREEN;
                else
                    next_state = START_SCREEN;
            end
            GAME_SCREEN: begin
                if (game_over_screen)  // Transition to end screen 
                    next_state = LOSE_SCREEN;
                else if (win)
                    next_state = WIN_SCREEN;
                else
                    next_state = GAME_SCREEN;
            end
            LOSE_SCREEN: begin
                if (keycode0 != 8'h2c)  // Transition back to start screen 
                    next_state = HALT1;
                else
                    next_state = LOSE_SCREEN;
            end
            WIN_SCREEN: begin
                if (keycode0 != 8'h2c)  // Transition back to start screen 
                    next_state = HALT2;
                else
                    next_state = WIN_SCREEN;
            end
            HALT1: begin
                if (keycode0 == 8'h2c)  // Transition back to start screen 
                    next_state = START_SCREEN;
                else
                    next_state = HALT1;
            end
            HALT2: begin
                if (keycode0 == 8'h2c)  // Transition back to start screen 
                    next_state = START_SCREEN;
                else
                    next_state = HALT2;
            end
        endcase
    end

    // Output logic
    assign game_active = (state == GAME_SCREEN); // 1 is game screen is active, 0 is start screen is active
    assign current_state = state; 

endmodule