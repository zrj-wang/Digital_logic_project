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
            // 复位时将播放位置重置为0
        play_position <= 0;
        // 将当前音符设置为 music0
        note_to_play <= music0;
        // 将LED输出重置为0
        led_out <= led8;
        // 将音符的高低八度设置为默认值 00
        octave_out <= 2'b00; // 默认高低八度
    end else begin
        // 在正常时钟上升沿处理以下逻辑
        // 加载当前音符和高低八度
        note_to_play <= song[play_position];
        current_octave <= octave[play_position];
        octave_out <= current_octave;

        // 为当前音符点亮相应的LED灯
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

        // 检查是否按下了正确的开关以播放音符
        if (switches[note_to_play - 1] && (octave_learn == current_octave) && (note_to_play != music0)) begin
            // 如果正确的开关被按下且音符不是 music0，移动到下一个音符
            play_position <= (play_position < song_time - 1) ? play_position + 1 : 0;
            // 可选择性地重置音符和LED输出以在音符之间关闭它们
            note_to_play <= music0;
            led_out <= 0;
            end else if ((note_to_play == music0) && (!switches[0]&&!switches[1]&&!switches[2]&&!switches[3]&&!switches[4]&&!switches[5]&&!switches[6])) begin
                // 对于 music0，检查是否所有开关都关闭以移动到下一个音符
            // 如果音符是 music0 且所有开关都关闭，移动到下一个音符
                play_position <= (play_position < song_time - 1) ? play_position + 1 : 0;
                // 为 music0 重置音符和LED输出
                note_to_play <= music0;
                led_out <= 0;
            end
        end
    end




endmodule
