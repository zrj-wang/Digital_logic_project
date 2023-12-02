// Controller module for managing the keys and notes
module Controller(
    input wire [7:0] keys,
    output reg [3:0] note_out,
    output reg [7:0] led_out 
);

    always @(*) begin
        case(keys)
            8'b00000010:begin 
            note_out <= 4'd1; // Key 1 pressed, play note 'do'
            led_out <=8'b00000010;
            end
            8'b00000100: begin
            note_out <= 4'd2; // Key 2 pressed, play note 're'
            led_out <=8'b00000100;
            end
            8'b00001000: begin
            note_out <= 4'd3; // Key 3 pressed, play note 'mi'
            led_out <=8'b00001000;
            end
            8'b00010000:begin
            note_out <= 4'd4; // Key 4 pressed, play note 'fa'
            led_out <=8'b00010000;
            end
            8'b00100000: begin
            note_out <= 4'd5; // Key 5 pressed, play note 'so'
            led_out <=8'b00100000;
            end
            8'b01000000:begin
                 note_out <= 4'd6; // Key 6 pressed, play note 'la'
                 led_out <=8'b01000000;
            end
            8'b10000000:begin
                 note_out <= 4'd7; // Key 7 pressed, play note 'si'
                 led_out <=8'b10000000;
            end
            default: note_out <= 4'd0; // No key pressed
        endcase
    end

endmodule
