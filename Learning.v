module mode_learn(
    input wire clk, // Clock signal
    input wire [1:0] song_select, // choose song
    input wire [6:0] switches, // 7个开关输入
    output reg [3:0] note_to_play, // out_put to buzzer
    output reg [6:0] led_out
);

//parameter second = 70000000, song_time=61,music0=4'b0000,
// music1=4'b0001, music2=4'b0010,music3=4'b0011,music4=4'b0100,music5=4'b0101,music6=4'b0110,music7=4'b0111,
// led1=7'b0000001,led2=7'b0000010,led3=7'b0000100,led4=7'b0001000,led5=7'b0010000,
// led6=7'b0100000,led7=7'b1000000,led8=7'b0000000;
//// only seven now,but not enough


// wire [3:0] song[song_time-1:0];
//wire [song_time*4-1:0] song_packed;


//Lib lib_inst(
//    .clk(clk),
//    .song_select(song_select),
//    .song_packed(song_packed)
//);


////unpack song
//genvar i;
//generate
//    for (i = 0; i < song_time; i = i + 1) begin : unpack_loop
//        assign song[i] = song_packed[(4*i)+3 : 4*i];
//    end
//endgenerate

////play song
//integer play_position = 0;
//reg note_played; // 标记是否已对当前音符作出反应

//initial begin
//    note_played = 1'b1; // 初始设置为1，以便从第一个音符开始
//end

//always @(posedge clk) begin
//    // 检查是否需要移动到下一个音符
//    if (note_played && (play_position < song_time-1)) begin
//        play_position <= play_position + 1;
//        note_played <= 1'b0; // 重置标志
//    end else if (note_played) begin
//        play_position <= 0; // 从头开始
//        note_played <= 1'b0; // 重置标志
//    end

//    // 设置LED输出和音符
//    case (song[play_position])
//        music1: led_out <= led1;
//        music2: led_out <= led2;
//        music3: led_out <= led3;
//        music4: led_out <= led4;
//        music5: led_out <= led5;
//        music6: led_out <= led6;
//        music7: led_out <= led7;
//        default: led_out <= led8; // 如果没有匹配的音符
//    endcase
//    note_to_play <= song[play_position];

//    // 检查是否打开了与当前音符相应的开关
//    if (switches[note_to_play-1] && note_to_play != 0) begin
//        note_played <= 1'b1; // 当用户打开开关时，设置标志
//    end
//end

endmodule
