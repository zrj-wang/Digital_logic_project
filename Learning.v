`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/09 16:24:31
// Design Name: 
// Module Name: mode_learn
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


module mode_learn(
    input wire clk, // Clock signal
    input wire [1:0] song_select, // choose song
    input wire [6:0] switches, // 7个开关输入
    input wire reset, // Reset signal
    input wire [1:0]octave_learn, //choose the proper octave
    output reg [3:0] note_to_play, // output to buzzer
    output reg [6:0] led_out,
    output wire[3:0] num,
    output reg [1:0] octave_out // Output the octave value
);

parameter second = 10000000, song_time=56,music0=4'b0000,
 music1=4'b0001, music2=4'b0010,music3=4'b0011,music4=4'b0100,music5=4'b0101,
 music6=4'b0110,music7=4'b0111,music9=4'b1111,
 led1=7'b0000001,led2=7'b0000010,led3=7'b0000100,led4=7'b0001000,led5=7'b0010000,
 led6=7'b0100000,led7=7'b1000000,led8=7'b0000000;
parameter begin_song=2'b00, mid_song=2'b01,final_song=2'b10;
// only seven now, but not enough

wire [3:0] song[song_time-1:0];
wire [song_time*4-1:0] song_packed;
reg [1:0] song_num=2'b00; // on behalf of song
wire [1:0] octave[song_time-1:0];
wire[song_time*2-1:0] octave_packed;
reg [1:0] prev_song_select;
integer play_position = 0;
integer note_counter = 0;
integer time_mul = 0;
reg [1:0] current_octave; // Current note's octave

//choose song logic
always @(posedge clk) begin
    if (!reset) begin
        // reset to the first song
        prev_song_select <= 2'b00; // 
        play_position <= 0;
        note_counter <= 0;
        song_num <= begin_song;
    end else begin
        // check for song_select[0] and song_select[1] rising edges
        if (song_select[0] == 1'b1 && prev_song_select[0] == 1'b0) begin
            if (song_num == final_song) begin
                song_num <= begin_song;
            end else begin
                song_num <= song_num + 1;
            end
            play_position <= 0;
            note_counter <= 0;
        end
        
        else if (song_select[1] == 1'b1 && prev_song_select[1] == 1'b0) begin
            if (song_num == begin_song) begin
                song_num <= final_song;
            end else begin
                song_num <= song_num - 1;
            end
            play_position <= 0;
            note_counter <= 0;
        end
        prev_song_select <= song_select; 
    end
end

// Instantiate the Lib, find the song
Lib lib_inst(
    .clk(clk),
    .song_packed(song_packed),
    .song_num(song_num),
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

//unpack octave
generate
    for (i = 0; i < song_time; i = i + 1) begin : unpack1
        assign octave[i] = octave_packed[(2*i)+1 : 2*i];
    end
endgenerate


// Play song

always @(posedge clk) begin
        if (reset) begin
            // Reset to the beginning of the song
            play_position <= 0;
            note_to_play <= music0;
            led_out <= 0;
            octave_out <= 2'b00; // Default octave
        end else begin
            // Load the current note and octave
            note_to_play <= song[play_position];
            current_octave <= octave_packed[play_position*2 +: 2];
            octave_out <= current_octave;

            // Light up the corresponding LED for the current note
            led_out <= (note_to_play != music0) ? (1 << (note_to_play - 1)) : 0;

            // Check if the correct switch is pressed for the note
            if (switches[note_to_play - 1] && (octave_learn == current_octave)) begin
                // Move to the next note if the correct switch is pressed
                play_position <= (play_position < song_time - 1) ? play_position + 1 : 0;
                // Optionally reset note_to_play and led_out if you want them to turn off between notes
                note_to_play <= music0;
                led_out <= 0;
            end
        end
    end

endmodule
