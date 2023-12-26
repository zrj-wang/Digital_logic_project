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

parameter song_1=4'd1, song_2=4'd2,song_3=4'd3,song_4=4'd4,song_5=4'd5,song_6=4'd6; 
// only seven now, but not enough

wire [3:0] song[song_time-1:0];
wire [song_time*4-1:0] song_packed;
reg [3:0] song_num=song_1; // on behalf of song
wire [song_time*4-1:0] continue;
wire [3:0] time_continue[song_time-1:0];
wire [1:0] octave[song_time-1:0];
wire[song_time*2-1:0] octave_packed;
reg [1:0] prev_song_select;
integer play_position = 0;
integer note_counter = 0;
integer time_mul = 0;
reg [1:0] current_octave; // Current note's octave
parameter lo=2'b01, hi=2'b10, ma=2'b00;

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
        // 复位时将播放位置重置为0
        play_position <= 0;
        note_counter <= 0;
        time_mul <= time_continue[play_position];
    end else begin
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

        time_mul <= time_continue[play_position]; //time_mul is the time of each note
        if(song[play_position]==music0) begin
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
            if (note_counter < second* time_mul ) begin
                    // continue playing the current note
                    note_counter <= note_counter + 1;
            end else begin
                // move to the next note
                note_counter <= 0;
                play_position <= play_position + 1;
                if (play_position >= song_time-1)begin //
                    play_position <= 0; // begin from the start
                end
                
            end
                note_to_play <= song[play_position];
                octave_out <= octave[play_position];
        end
    end
end




endmodule
