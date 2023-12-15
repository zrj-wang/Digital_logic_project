
module MiniPiano(
    input wire clk,
    input wire [6:0] keys,// 7 keys for piano
    input wire reset,
    output wire speaker,
    input wire [1:0] song_select, //select song, next or previous
    input wire [2:0] mode,    //  mode 100 free ; 010 auto; 001 learn
    input wire [1:0]octave, //choose the proper octave
    output wire [6:0] led,
    output wire [7:0] light_seg,
    output wire [7:0] light_seg_left,
    output wire seg_out 
    );

    wire [3:0] note;
    wire[1:0] octave_auto;
    wire [3:0] num;
    
    // Instantiate the Controller
    Controller controller_inst(
        .clk(clk),
        .keys(keys),
        .note_out(note),
        .reset(reset),
        .mode(mode),
        .song_select(song_select),
        .led_out(led),
        .num(num)
    );
    

    // Instantiate the Buzzer
    Buzzer buzzer_inst(
        .clk(clk),
        .note(note),
        .speaker(speaker),
        .octave(octave),
        .octave_auto(octave_auto),
        .mode(mode)
    );

    // Instantiate the Led module
    Led led_inst(
        .leds(led)
        // Connect other necessary ports
    );

    Light_seg light_seg_inst(
        .num(num),
        .seg1(light_seg),
        .seg(light_seg_left),
        .an(seg_out),
        .clk(clk),
        .reset(reset)
    );

    // Other modules can be instantiated and connected similarly

endmodule
