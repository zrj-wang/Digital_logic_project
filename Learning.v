module mode_learn(
    input wire clk, // Clock signal
    input wire [1:0] song_select, // choose song
    input wire [6:0] switches, // 7����������
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
//reg note_played; // ����Ƿ��ѶԵ�ǰ����������Ӧ

//initial begin
//    note_played = 1'b1; // ��ʼ����Ϊ1���Ա�ӵ�һ��������ʼ
//end

//always @(posedge clk) begin
//    // ����Ƿ���Ҫ�ƶ�����һ������
//    if (note_played && (play_position < song_time-1)) begin
//        play_position <= play_position + 1;
//        note_played <= 1'b0; // ���ñ�־
//    end else if (note_played) begin
//        play_position <= 0; // ��ͷ��ʼ
//        note_played <= 1'b0; // ���ñ�־
//    end

//    // ����LED���������
//    case (song[play_position])
//        music1: led_out <= led1;
//        music2: led_out <= led2;
//        music3: led_out <= led3;
//        music4: led_out <= led4;
//        music5: led_out <= led5;
//        music6: led_out <= led6;
//        music7: led_out <= led7;
//        default: led_out <= led8; // ���û��ƥ�������
//    endcase
//    note_to_play <= song[play_position];

//    // ����Ƿ�����뵱ǰ������Ӧ�Ŀ���
//    if (switches[note_to_play-1] && note_to_play != 0) begin
//        note_played <= 1'b1; // ���û��򿪿���ʱ�����ñ�־
//    end
//end

endmodule
