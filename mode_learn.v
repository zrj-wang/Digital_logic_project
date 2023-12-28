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
    input wire [1:0] song_select, // Input to choose song
    input wire [6:0] switches, // Input from 7 switches
    input wire reset, // Reset signal
    input wire [1:0] octave_learn, // Input to choose the proper octave
    output reg [3:0] note_to_play, // Output to buzzer
    output reg [6:0] led_out, // Output for LEDs
    output wire [3:0] num, // Output for displaying numbers
    output reg [1:0] octave_out // Output the octave value
);


// only seven now, but not enough
// Arrays to store song data
wire [3:0] song[song_time-1:0];
wire [song_time*4-1:0] song_packed; // Packed array for song data
reg [3:0] song_num = song_1; // Current song number
wire [song_time*4-1:0] continue; // Array for song continuation
wire [3:0] time_continue[song_time-1:0]; // Time for each note in the song
wire [1:0] octave[song_time-1:0]; // Array for octave data
wire [song_time*2-1:0] octave_packed; // Packed array for octave data
reg [1:0] prev_song_select; // Previous song select value
integer play_position = 0; // Position in the song
integer note_counter = 0; // Counter for note duration
integer time_mul = 0; // Multiplier for note duration
reg [1:0] current_octave; // Current octave value
parameter lo = 2'b01, hi = 2'b10, ma = 2'b00; // Octave parameters

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


// Play song
always @(posedge clk, negedge reset) begin
    if (!reset) begin
        // Reset the play position and counters on reset
        play_position <= 0;
        note_counter <= 0;
        time_mul <= time_continue[play_position];
    end else begin
    // LED pattern based on current note
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
            default: led_out <= led8; // No note
        endcase
        // Timing logic for each note
        time_mul <= time_continue[play_position]; //time_mul is the time of each note
        if(song[play_position]==music0) begin
        // If no switch is pressed, continue to the next note
            if(!switches[0] && !switches[1] && !switches[2] && !switches[3] && !switches[4] && !switches[5] && !switches[6] )begin
                if (note_counter < second* time_mul ) begin
                    // continue playing the current note
                    note_counter <= note_counter + 1;
                end else begin
                    // move to the next note
                     note_counter <= 0;
                     play_position <= play_position + 1;
                     if (play_position >= song_time-1) begin//
                        play_position <= 0; // begin from the start
                     end
                     
                end
            end
                note_to_play <= song[play_position];
                octave_out <= octave[play_position];
        end else
        if(switches[song[play_position]-1] && octave_learn==octave[play_position]) begin
        // Check if the correct switch is pressed for the current note
            if (note_counter < second* time_mul ) begin
                    // continue playing the current note
                    note_counter <= note_counter + 1;
            end else begin
                // move to the next note
                note_counter <= 0;
                play_position <= play_position + 1;
                if (play_position >= song_time-1)begin 
                    play_position <= 0; // begin from the start
                end
                
            end
            // Update output note and octave
                note_to_play <= song[play_position];
                octave_out <= octave[play_position];
        end
    end
end




endmodule
