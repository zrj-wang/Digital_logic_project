·include "parar.v"
module Lib(
    input wire clk, // Clock signal
    input wire [1:0] song_select, // 
    output reg [3:0] current_note // out_put to buzzer
);


wire [3:0] twinkle_twinkle[0:27];
    assign  twinkle_twinkle[0]=t0;
    assign  twinkle_twinkle[1]=t1;
    assign  twinkle_twinkle[2]=t2;
    assign  twinkle_twinkle[3]=t3;
    assign  twinkle_twinkle[4]=t4;
    assign  twinkle_twinkle[5]=t5;
    assign  twinkle_twinkle[6]=t6;
    assign  twinkle_twinkle[7]=t7;
    assign  twinkle_twinkle[8]=t8;
    assign  twinkle_twinkle[9]=t9;
    assign  twinkle_twinkle[10]=t10;
    assign  twinkle_twinkle[11]=t11;
    assign  twinkle_twinkle[12]=t12;
    assign  twinkle_twinkle[13]=t13;
    assign  twinkle_twinkle[14]=t14;
    assign  twinkle_twinkle[15]=t15;
    assign  twinkle_twinkle[16]=t16;
    assign  twinkle_twinkle[17]=t17;
    assign  twinkle_twinkle[18]=t18;
    assign  twinkle_twinkle[19]=t19;
    assign  twinkle_twinkle[20]=t20;
    assign  twinkle_twinkle[21]=t21;
    assign  twinkle_twinkle[22]=t22;
    assign  twinkle_twinkle[23]=t23;
    assign  twinkle_twinkle[24]=t24;
    assign  twinkle_twinkle[25]=t25;
    assign  twinkle_twinkle[26]=t26;
    assign  twinkle_twinkle[27]=t27;




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