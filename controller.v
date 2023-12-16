`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/07 00:51:48
// Design Name: 
// Module Name: Controller
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


 

module Controller(
    input wire clk,
    input wire write_on,
    input wire [6:0] keys,
    input wire [1:0]octave, //choose the proper octave
    input wire [2:0] mode,//  mode 100 free ; 010 auto; 001 learn //check constrain
    input wire reset,
    input wire [1:0] song_select,
    output reg[3:0] num,   //show the number of song
    output reg [3:0] note_out, //output the note
    output reg [6:0] led_out , 
    output reg [1:0] octave_out //octave from auto mode or learn mode
);
 parameter mode_free=3'b100, mode_auto=3'b010, mode_learn=3'b001;
    wire [3:0] num_auto;
    wire [3:0] note_auto;
    wire [6:0] led_auto;
    wire [1:0]octave_auto;

    mode_auto auto_inst(
    .clk(clk),
    .reset(reset),
    .song_select(song_select),
    .note_to_play(note_auto),
    .led_out(led_auto),
    .octave_auto(octave_auto),
    .num(num_auto)
    );



   // Initialize for learn mode
            wire [3:0] num_learn;
            wire [3:0] note_learn;
            wire [6:0] led_learn;
            wire [1:0]octave_learn;
           
           mode_learn learn_inst(
               .clk(clk),
               .switches(keys),
               .note_to_play(note_learn),
                .song_select(song_select),
               .led_out(led_learn),
                .octave_out(octave_learn),
               .octave_learn(octave), // Assuming octave_learn is the same as octave
               .num(num_learn), // Assuming mode_learn module provides num output
               .reset(reset) // Assuming mode_learn module has reset input
           );
           
          


    always @(posedge clk) begin
        case(mode)
            mode_free: begin
                
            end
            mode_auto: begin
                note_out <= note_auto;
                led_out <= led_auto;
                num <=num_auto;
                octave_out <= octave_auto;
            end
            mode_learn: begin
                note_out <= note_learn;
                led_out <= led_learn;
                num <= num_learn;
                octave_out <= octave_learn;
                        end

            default: begin
    
            end
        endcase
    end
endmodule


