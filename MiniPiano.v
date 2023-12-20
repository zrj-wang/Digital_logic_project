`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/07 00:50:13
// Design Name: 
// Module Name: MiniPiano
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



module MiniPiano(
    input wire clk,
    input wire [6:0] keys,// 7 keys for piano
    input wire reset,
    output wire speaker,
    input wire start,
    input wire write_on,
    input wire [2:0] song_select, //select song, next or previous
    input wire [2:0] mode,    //  mode 100 free ; 010 auto; 001 learn
    input wire [1:0]octave, //choose the proper octave
    output wire [6:0] led, //control the led
    output wire [7:0] light_seg, //control one of the right 4 seg
    output wire [7:0] light_seg_left, //control the left 4 seg
    output wire seg_out,  //control the right seg
    output wire [3:0] an, //control the left seg

    input wire[1:0] speed_select, //select the speed of the song
    output wire[1:0] num_speed, //show the speed of the song

    output wire test 

    );
    assign test = 1'b0;


    wire [3:0] note;
    wire[1:0] octave_auto;
    wire [3:0] num;
    
    // Instantiate the Controller
    Controller controller_inst(
        .clk(clk),
        .keys(keys),
        .write_on(write_on),
        .note_out(note),
        .reset(reset),
        .mode(mode),
        .song_select(song_select),
        .led_out(led),
        .num(num),
        .octave(octave),
        .octave_out(octave_auto),
        .speed_select(speed_select),
        .num_speed(num_speed)

    );
    

    // Instantiate the Buzzer
    Buzzer buzzer_inst(
        .clk(clk),
        .note(note),
        .speaker(speaker),
        .octave(octave),
        .octave_auto(octave_auto),
        .mode(mode)
    );

    // Instantiate the Led module
    Led led_inst(
        .leds(led)
        // Connect other necessary ports
    );

    Light_seg light_seg_inst(
        .num(num),
        .seg1(light_seg),
        .seg(light_seg_left),
        .an(an),
        .clk(clk),
        .reset(reset),
        .mode(mode),
        .seg_out(seg_out)
    );

    // Other modules can be instantiated and connected similarly

endmodule
