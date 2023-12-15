//input number ,show in seg
module Light_seg (
    input wire [3:0] num,       // 4-bit input representing the song number
    input wire clk,             // Clock signal
    input wire reset,           // Reset signal
    input wire [2:0] mode,
   output reg [7:0] seg1,   // show number
    output reg [7:0] seg,   //show name   
    output reg [3:0] an
);
parameter s=8'b01001001,t=8'b00001111,a=8'b01110111,r=8'b01000110;
parameter b=8'b00011111,d=8'b00111101,y=8'b00111011;
parameter e=8'b01001111;


reg [7:0] char1, char2, char3, char4;
reg [1:0] display_select;// 2-bit output for the digit select
reg [7:0] seg2; // 7-bit output for the segment pattern

    // Define the segment patterns for numbers 0-9 for a common cathode seven-segment display
    always @(*) begin
        case(num)
            4'd0: seg2 = 8'b01111111; // 0         {dot,a,b,c,d,e,f,g}
            4'd1: begin
                seg2 = 8'b00110000; // 1
                char1 = s;
                char2 = t;
                char3 = a;
                char4 = r;
            end
            4'd2:
            begin
                 seg2 = 8'b01101101; // 2
                    char1 = b;
                    char2 = d;
                    char3 = a;
                    char4 = y;
            end
            4'd3: 
            begin
                seg2 = 8'b01111001; // 3
                char1 = y;
                char2 = e;
                char3 = a;
                char4 = r;
            end
            4'd4: seg2 = 8'b00110011; // 4
            4'd5: seg2 = 8'b01011011; // 5
            4'd6: seg2 = 8'b01011111; // 6
            4'd7: seg2 = 8'b01110000; // 7
            4'd8: seg2 = 8'b01111111; // 8
            4'd9: seg2 = 8'b01111011; // 9
            default: seg2 = 8'b00000000; // Off or invalid input
        endcase
    end





reg [19:0] refresh_counter = 0; // counter for refreshing the display
wire refresh_tick;


always @(posedge clk or posedge reset) begin
    if (reset) begin
        refresh_counter <= 0;
    end else begin
        if (refresh_counter >= 199999) begin
            refresh_counter <= 0;
        end else begin
            refresh_counter <= refresh_counter + 1;
        end
    end
end

assign refresh_tick = (refresh_counter == 0); // refresh_tick is high for one clock cycle every 1000000 clock cycles

//choose the seg
always @(posedge clk or posedge reset) begin
    if (reset) begin
        display_select <= 0;
    end else if (refresh_tick) begin
        display_select <= display_select + 1;
    end
end

// control the seg
always @(posedge clk )
 begin
        case(mode)
            3'b010: begin
                seg1 <= seg2;
                // Only update outputs when mode is 3'b010
                case(display_select)
                    2'b00: begin
                        seg <= char1;  
                        an <= 4'b0001; 
                    end
                    2'b01: begin
                        seg <= char2;  
                        an <= 4'b0010; 
                    end
                    2'b10: begin
                        seg <= char3;  
                        an <= 4'b0100; 
                    end
                    2'b11: begin
                        seg <= char4;  
                        an <= 4'b1000; 
                    end
                endcase
            end
            default: begin
                // Mode is not 3'b010, keep outputs low
                seg1 <= 8'b00000000;
                seg <= 8'b00000000;
                an <= 4'b0000;
            end
        endcase

end




endmodule



//star 
// 8'b01001001,8'b00001111,8'b01110111,8'b01000110

//bday
//8'b00011111,8'b00111101,8'b01110111,8'b00111011

//year
//8'b00111011,8'b01001111,8'b01110111,8'b01000110
