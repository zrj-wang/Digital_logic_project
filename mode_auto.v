`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/07 00:52:49
// Design Name: 
// Module Name: mode_auto
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


 
module mode_auto(
    input wire clk, // Clock signal
    input wire [1:0] song_select, // choose song
    input wire reset,
    output reg [3:0] note_to_play, // out_put to buzzer
    output reg [6:0] led_out,
    output reg [1:0] octave_auto ,
    output wire[3:0] num,
    input wire [1:0] speed_select,
    input wire play_state

);
`include "par.v"



reg [3:0] song_num=song_1; // on behalf of song
reg [1:0] num_speed=speed_mid; // on behalf of speed

wire [3:0] song[song_time-1:0];
wire [song_time*4-1:0] song_packed;

wire [song_time*4-1:0] continue;
wire [3:0] time_continue[song_time-1:0];
wire [1:0] octave[song_time-1:0];
wire[song_time*2-1:0] octave_packed;

reg [1:0] prev_song_select;
reg [1:0] prev_speed_select;


integer play_position = 0;
integer note_counter = 0;
integer time_mul = 0;



//choose song logic
always @(posedge clk) begin
  begin
        // check for song_select[0] and song_select[1] rising edges
        if (song_select[0] == 1'b1 && prev_song_select[0] == 1'b0) begin
            if (song_num == song_6) begin
                song_num <= song_1;
            end else begin
                song_num <= song_num + 1;
            end

        end
        
        else if (song_select[1] == 1'b1 && prev_song_select[1] == 1'b0) begin
            if (song_num == song_1) begin
                song_num <= song_6;
            end else begin
                song_num <= song_num - 1;
            end

        end
        prev_song_select <= song_select; 
    end
end



// if song_num =(1,3) ,use song from lib, else from mode_free
// Instantiate the Lib, find the song

Lib lib_inst(
    .clk(clk),
    .song_packed(song_packed),
    .song_num(song_num),
    .time_continue(continue),
    .octave_packed(octave_packed),
    .num(num)

);



//unpack song
genvar i;
generate
    for (i = 0; i < song_time; i = i + 1) begin : unpack_loop
        assign song[i] = song_packed[(4*i)+3 : 4*i];
    end
endgenerate


//unpack time
generate
    for (i = 0; i < song_time; i = i + 1) begin : unpack
        assign time_continue[i] = continue[(4*i)+3 : 4*i];
    end
endgenerate

//unpack octave
generate
    for (i = 0; i < song_time; i = i + 1) begin : unpack1
        assign octave[i] = octave_packed[(2*i)+1 : 2*i];
    end
endgenerate



//play song


//play song logic
always @(posedge clk, negedge reset) 
begin
    if (!reset) begin
        play_position <= 0;
        note_counter <= 0;
        time_mul <= time_continue[play_position];
        num_speed<=speed_mid;
        led_out<=led8;
        octave_auto<=octave[play_position];
        note_to_play<=song[play_position];
    end else begin

    if(play_state==1'b1)begin//on behalf of start or pause
    begin
 //time_mul is the time of each note
        case(num_speed)
            speed_low: time_mul <= time_continue[play_position]<<1;
            speed_high: time_mul <= time_continue[play_position]>>1;
            speed_mid: time_mul <= time_continue[play_position];
        endcase
    if (note_counter < second* time_mul ) begin
        // continue playing the current note
        note_counter <= note_counter + 1;
    end else begin
        // move to the next note
        note_counter <= 0;
        play_position <= play_position + 1;
        if (play_position >= song_time-1) //
            play_position <= 0; // begin from the start
    end
//light up led logic
     case (song[play_position])
        music1: led_out <= led1;
        music2: led_out <= led2;
        music3: led_out <= led3;
        music4: led_out <= led4;
        music5: led_out <= led5;
        music6: led_out <= led6;
        music7: led_out <= led7;
        music9:
        begin
          play_position <= 0;
        end // begin from the start
        default: led_out <= led8; // 
    endcase


    note_to_play <= song[play_position];
    octave_auto <= octave[play_position];
    end
    end else begin
                // check for song_select[0] and song_select[1] rising edges
        if (speed_select[0] == 1'b1 && prev_speed_select[0] == 1'b0) begin
            if (num_speed == speed_high) begin
                num_speed <= speed_low;
            end else begin
                num_speed <= num_speed + 1;
            end

        end
        
        else if (speed_select[1] == 1'b1 && prev_speed_select[1] == 1'b0) begin
            if (num_speed == speed_low) begin
                num_speed <= speed_high;
            end else begin
                num_speed <= num_speed - 1;
            end

        end
        prev_speed_select <= speed_select; 
    end


    end
end
// only when not playing song can we change speed


endmodule
