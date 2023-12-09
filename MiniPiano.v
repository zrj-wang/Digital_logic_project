
module MiniPiano(
    input wire clk,
    input wire [6:0] keys,// 7 keys for piano
    input wire reset,
    output wire speaker,
    input wire [1:0] song_select, //select song, next or previous
    input wire [2:0] mode,    //  mode 100 free ; 010 auto; 001 learn
    input wire [1:0]octave, //choose the proper octave
    output [6:0] led
);

    wire [3:0] note;
    
    // Instantiate the Controller
    Controller controller_inst(
        .clk(clk),
        .keys(keys),
        .note_out(note),
.reset(reset),
        .mode(mode),
.song_select(song_select),
        .led_out(led)
    );
    

    // Instantiate the Buzzer
    Buzzer buzzer_inst(
        .clk(clk),
        .note(note),
        .speaker(speaker),
        .octave(octave)
    );

    // Instantiate the Led module
    Led led_inst(
        .leds(led)
        // Connect other necessary ports
    );

    // Other modules can be instantiated and connected similarly

endmodule
