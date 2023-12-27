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
    output reg [1:0] octave_out, //octave from auto mode or learn mode
    input wire [1:0] speed_select,
    input wire start
    );
 parameter mode_free=3'b100, mode_auto=3'b010, mode_learn=3'b001;



    

 
    wire [3:0] num_auto;
    wire [3:0] note_auto;
    wire [6:0] led_auto;
    wire [1:0]octave_auto;
    
reg play_state = 1'b0;//control begin
    mode_auto auto_inst(
    .clk(clk),
    .reset(reset),
    .song_select(song_select),
    .note_to_play(note_auto),
    .led_out(led_auto),
    .octave_auto(octave_auto),
    .num(num_auto),
    .speed_select(speed_select),
    .play_state(play_state)
    );


    always @(posedge clk) begin
        if (!reset) begin
            play_state <= 0;
        end else if (start) begin
            play_state <= ~play_state;
        end
    end

 
  wire[3:0]note_free1;
    wire[1:0]octave_free1;
    wire[3:0]note_free2;
    wire[1:0]octave_free2;
    wire [3:0]selectSong_free=num;
    wire playState_free = play_state;
    reg [6:0] led_out_free;
    
    mode_free free_inst(
    .clk(clk),
    .write_on(write_on),
    .storeRecord(start),
    .keys(keys),
    .song_select(song_select),
    .octave(octave),
    .playState(playState_free),
    .selectSong(selectSong_free),
    .led_out(led_out_free),
    .note_to_play1(note_free1),
    .octave_out1(octave_free1),
    .note_to_play1(note_free2),
    .octave_out1(octave_free2)
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
     case(num_auto)
             4'b0100,4'b0101,4'b0110:
             begin note_out <= note_free2;
                     led_out <= led_out_free;
                     num <=num_auto;
                     octave_out <= octave_free2;
                     end
    endcase
        case(mode)
            mode_free: begin
               note_out<=note_free;
                octave_out<=octave_free;
            end
            mode_auto: begin
                num <=num_auto;
                

                note_out <= note_auto;
                led_out <= led_auto;
                
                octave_out <= octave_auto;
            end
            mode_learn: begin
                note_out <= note_learn;
                led_out <= led_learn;
                num <= num_learn;
                octave_out <= octave_learn;
                        end

            default: begin
                note_out <= 4'b0000;
                led_out <= 7'b0000000;
                num <= 4'b0000;
                octave_out <= 2'b00;
            end
        endcase
    end
endmodule


