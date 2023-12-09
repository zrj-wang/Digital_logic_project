module Controller(
    input wire clk,
    input wire [6:0] keys,
    input wire [2:0] mode,//  mode 100 free ; 010 auto; 001 learn
    output reg [3:0] note_out,
    output reg [6:0] led_out 
);
 parameter mode_free=3'b100, mode_auto=3'b010, mode_learn=3'b001;

    wire [3:0] note_auto;
    wire [6:0] led_auto;

    mode_auto auto_inst(
        .clk(clk),
        .note_to_play(note_auto),
        .led_out(led_auto)
    );


    always @(posedge clk) begin
        case(mode)
            mode_free: begin
                
            end
            mode_auto: begin
                note_out <= note_auto;
                led_out <= led_auto;
            end
            mode_learn: begin
                
            end
            default: begin
    
            end
        endcase
    end
endmodule