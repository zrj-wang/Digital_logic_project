// Controller module for managing the keys and notes
·include "parar.v"

module Controller(
    input wire clk,
    input wire [6:0] keys,
    input wire [2:0] mode,//  mode 100 free ; 010 auto; 001 learn
    output reg [3:0] note_out,
    output reg [6:0] led_out 
);
    wire [3:0] note_auto;

    mode_auto auto_inst(
        .clk(clk),
        .song_select(mode),
        .note_to_play(note_auto)
    );


    always @(posedge clk) begin
        case(mode)
            mode_free: begin
                
            end
            mode_auto: begin
                note_out <= note_auto;
            end
            mode_learn: begin
                
            end
            default: begin
    
            end
        endcase
    end
endmodule





    always @(*) begin
        case(keys)
            7'b0000001:begin 
            note_out <= 4'd1; // Key 1 pressed, play note 'do'
            led_out <=7'b0000001;
            end
            7'b0000010: begin
            note_out <= 4'd2; // Key 2 pressed, play note 're'
            led_out <=7'b0000010;
            end
            7'b0000100: begin
            note_out <= 4'd3; // Key 3 pressed, play note 'mi'
            led_out <=7'b0000100;
            end
            7'b0001000:begin
            note_out <= 4'd4; // Key 4 pressed, play note 'fa'
            led_out <=7'b0001000;
            end
            7'b0010000: begin
            note_out <= 4'd5; // Key 5 pressed, play note 'so'
            led_out <=7'b0010000;
            end
            7'b0100000:begin
                 note_out <= 4'd6; // Key 6 pressed, play note 'la'
                 led_out <=7'b0100000;
            end
            7'b1000000:begin
                 note_out <= 4'd7; // Key 7 pressed, play note 'si'
                 led_out <=7'b1000000;
            end
            default: note_out <= 4'd0; // No key pressed
        endcase
    end

endmodule
