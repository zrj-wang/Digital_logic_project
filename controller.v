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
    input wire start,
    output reg [3:0] score_out,
    input wire user,
    output reg [3:0] score_user
    );
`include "par.v"



wire[3:0]note_free1;
    wire[1:0]octave_free1;
    wire[3:0]note_free2;
    wire[1:0]octave_free2;
    wire [6:0] led_free1;
    wire [6:0] led_free2;
        



//use wire to connect mode, then choose which mode we will use
 
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
               .octave_learn(octave),
               .num(num_learn), 
               .reset(reset) 
           );
           
           
    // Initialize for competition mode
                       wire [3:0] num_competition;
                       wire [3:0] note_competition;
                       wire [6:0] led_competition;
                       wire [1:0]octave_competition;
                       wire [3:0] score;
                       wire [3:0] score_final;
                       wire [3:0] score_A;
                       wire [3:0] score_B;
                       
                       
                       
           mode_competition competition_inst(
                                      
                                      .user(user),
                                      .clk(clk),
                                      .switches(keys),
                                      .note_to_play(note_competition),
                                       .song_select(song_select),
                                      .led_out(led_competition),
                                       .octave_out(octave_competition),
                                      .octave_competition(octave), 
                                      .num(num_competition), 
                                      .speed_select(speed_select),
                                      .reset(reset), 
                                      .score(score),
                                      .play_state(play_state),
                                      .score_A(score_A),
                                      .score_B(score_B)
                                  );
                                  
                                  
    mode_free free_inst(
    .clk(clk),
    .reset(reset),
    .write_on(write_on),
    .storeRecord(start),
    .keys(keys),
    .octave(octave),
    .selectSong(num_auto),
    .led_out1(led_free1),
     .led_out2(led_free2),
    .note_to_play1(note_free1),
    .octave_out1(octave_free1),
    .note_to_play2(note_free2),
    .octave_out2(octave_free2)
    );

          

// choose the mode
    always @(posedge clk) begin
        case(mode)
            // mode_free: begin
            //            note_out<=note_free1;
            //             octave_out<=octave_free1;
            //             led_out<=led_free;
            //         end
             mode_free: begin
               note_out<=note_free1;
                octave_out<=octave_free1;
                led_out<=led_free1;  
            end
        mode_auto: begin
            case(num_auto)
              4'b0100,4'b0101,4'b0110:
                begin note_out <= note_free2;
                  led_out <= led_free2;  
                   num <=num_auto;
                  octave_out <= octave_free2;
                   end
                default begin             
                num <=num_auto;              
                note_out <= note_auto;
                led_out <= led_auto;
                octave_out <= octave_auto;
                end
                endcase
            end

            // mode_auto: begin
            //             case(num_auto)
            //              4'b0100,4'b0101,4'b0110:
            //            begin note_out <= note_free2;
            //                  led_out <= led_free;
            //                   num <=num_auto;
            //                  octave_out <= octave_free2;
            //                   end
            //         default begin             
            //                num <=num_auto;              
            //                note_out <= note_auto;
            //                led_out <= led_auto;
            //                octave_out <= octave_auto;
            //                end
            //                endcase
            //            end  
                       
                               
            mode_learn: begin
                note_out <= note_learn;
                led_out <= led_learn;
                num <= num_learn;
                octave_out <= octave_learn;
                        end
            mode_competition: begin
                note_out <= note_competition;
                led_out <= led_competition;
                num <= num_competition;
                octave_out <= octave_competition;
                score_out <= score;
                if(user) begin
                score_user <=score_A;
                end else begin
                score_user <=score_B;
                end
                        end
            default: begin
                note_out <= t;
                led_out <= led8;
                num <= t;
                octave_out <= ma;
            end
        endcase
    end
endmodule
