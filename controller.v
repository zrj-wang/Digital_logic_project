// Controller module for managing the keys and notes
module Controller(
    input wire [6:0] keys,
    output reg [3:0] note_out,
    output reg [6:0] led_out 
);

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
