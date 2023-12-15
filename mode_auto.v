module mode_auto(
    input wire clk, // Clock signal
    input wire [1:0] song_select, // choose song
    input wire reset,
    output reg [3:0] note_to_play, // out_put to buzzer
    output reg [6:0] led_out,
    output reg [1:0] octave_auto ,
    output reg[3:0] num

);
 parameter second = 10000000, song_time=56,music0=4'b0000,
 music1=4'b0001, music2=4'b0010,music3=4'b0011,music4=4'b0100,music5=4'b0101,
 music6=4'b0110,music7=4'b0111,music9=4'b1111,
 led1=7'b0000001,led2=7'b0000010,led3=7'b0000100,led4=7'b0001000,led5=7'b0010000,
 led6=7'b0100000,led7=7'b1000000,led8=7'b0000000;
parameter begin_song=2'b00, mid_song=2'b01,final_song=2'b10; 


wire [3:0] song[song_time-1:0];
wire [song_time*4-1:0] song_packed;

reg [1:0] song_num=2'b00; // on behalf of song

wire [3:0] time_continue[song_time-1:0];

wire [1:0] octave[song_time-1:0];
wire[song_time*2-1:0] octave_packed;



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
    .time_continue(time_continue),
    .ocative_packed(octave_packed),
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
        assign time_continue[i] = time_continue[(4*i)+3 : 4*i];
    end
endgenerate

//unpack octave
generate
    for (i = 0; i < song_time; i = i + 1) begin : unpack1
        assign octave[i] = octave_packed[(2*i)+1 : 2*i];
    end
endgenerate



//play song
integer play_position = 0;
integer note_counter = 0;
integer time_mul = 0;

//play song logic
always @(posedge clk, negedge reset) 
begin
    if (!reset) begin
        play_position <= 0;
        note_counter <= 0;
        time_mul <= time_continue[play_position];
    end 
    else
    begin
      time_mul <= time_continue[play_position]; //time_mul is the time of each note
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
end


endmodule