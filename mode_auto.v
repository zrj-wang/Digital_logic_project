module mode_auto(
    input wire clk, // Clock signal
    input wire [1:0] song_select, // choose song
    output wire [3:0] note_to_play // out_put to buzzer
);

wire [3:0] twinkle_twinkle[0:27];


Lib song_lib(
    .clk(clk),
    .song_select(song_select),
    .current_note(note_to_play),
    .twinkle_twinkle(twinkle_twinkle)
);//get song from lib




//play song
integer play_position = 0;

integer note_duration = 500000; // 0.5s
integer note_counter = 0;

always @(posedge clk) begin
    if (note_counter < note_duration) begin
        // continue playing the current note
        note_counter = note_counter + 1;
    end else begin
        // move to the next note
        note_counter = 0;
        play_position = play_position + 1;
        if (play_position >= 27) //
            play_position = 0; // begin from the start
    end

    current_note <= twinkle_twinkle[play_position];
end


endmodule