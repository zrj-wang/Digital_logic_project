  parameter Half_second = 500000;
module mode_auto(
    input wire clk, // Clock signal
    input wire [1:0] song_select, // choose song
    output reg [3:0] note_to_play // out_put to buzzer
);
wire [3:0] song[0:27];
wire [111:0] song_packed;


Lib lib_inst(
    .clk(clk),
    .song_select(song_select),
    .song_packed(song_packed)
);

//unpack song
genvar i;
generate
    for (i = 0; i < 28; i = i + 1) begin : unpack_loop
        assign song[i] = song_packed[(4*i)+3 : 4*i];
    end
endgenerate



//play song
integer play_position = 0;

integer note_counter = 0;

localparam halfSecond=Half_second;


always @(posedge clk) begin
    if (note_counter < halfSecond ) begin
        // continue playing the current note
        note_counter <= note_counter + 1;
    end else begin
        // move to the next note
        note_counter <= 0;
        play_position = play_position + 1;
        if (play_position >= 27) //
            play_position <= 0; // begin from the start
    end

    note_to_play <= song[play_position];
end


endmodule