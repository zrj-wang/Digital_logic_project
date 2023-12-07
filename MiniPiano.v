
module MiniPiano(
    input wire clk,
    input wire [6:0] keys,
    output wire speaker,
    input wire [1:0] song_select, //select song, next or previous
    input wire [2:0] mode,
    output [6:0] Led
);

    wire [3:0] note;
    
    // Instantiate the Controller
    Controller controller_inst(
        .clk(clk),
        .keys(keys),
        .note_out(note),
        .mode(mode),
        .led_out(leds)
    );
    

    // Instantiate the Buzzer
    Buzzer buzzer_inst(
        .clk(clk),
        .note(note),
        .speaker(speaker)
    );

    // Instantiate the Led module
    Led led_inst(
        .leds(leds)
        // Connect other necessary ports
    );

    // Other modules can be instantiated and connected similarly

endmodule