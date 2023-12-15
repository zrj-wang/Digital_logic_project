//input number ,show in seg
module Light_seg (
    input wire [3:0] num,       // 4-bit input representing the song number
    input wire clk,             // Clock signal
    input wire reset,           // Reset signal
    output reg [6:0] seg1,   // show number
    output reg [6:0] seg,   //show name   
    output reg [3:0] an
);
parameter s=8'b01001001,t=8'b00001111,a=8'b01110111,r=8'b01000110;
parameter b=8'b00011111,d=8'b00111101,y=8'b00111011;
parameter e=8'b01001111;


reg [7:0] char1, char2, char3, char4;
reg [1:0] display_select;// 2-bit output for the digit select


    // Define the segment patterns for numbers 0-9 for a common cathode seven-segment display
    always @(*) begin
        case(num)
            4'd0: seg1 = 8'b01111111; // 0         {dot,a,b,c,d,e,f,g}
            4'd1: begin
                seg1 = 8'b00110000; // 1
                char1 = s;
                char2 = t;
                char3 = a;
                char4 = r;
            end
            4'd2:
            begin
                 seg1 = 8'b01101101; // 2
                    char1 = b;
                    char2 = d;
                    char3 = a;
                    char4 = y;
            end
            4'd3: 
            begin
                seg1 = 8'b01111001; // 3
                char1 = y;
                char2 = e;
                char3 = a;
                char4 = r;
            end
            4'd4: seg1 = 8'b00110011; // 4
            4'd5: seg1 = 8'b01011011; // 5
            4'd6: seg1 = 8'b01011111; // 6
            4'd7: seg1 = 8'b01110000; // 7
            4'd8: seg1 = 8'b01111111; // 8
            4'd9: seg1 = 8'b01111011; // 9
            default: seg1 = 8'b00000000; // Off or invalid input
        endcase
    end

//star 
// 8'b01001001,8'b00001111,8'b01110111,8'b01000110

//bday
//8'b00011111,8'b00111101,8'b01110111,8'b00111011

//year
//8'b00111011,8'b01001111,8'b01110111,8'b01000110

always @(posedge clk or posedge reset) begin
    if (reset) begin
        display_select <= 0;
    end else begin
        display_select <= display_select + 1;
    end
end

// 控制数码管显示
always @(*) begin
    case(display_select)
        2'b00: begin
            seg <= char1;  // 显示第一个字母
            an <= 4'b0001; // 激活第一个数码管
        end
        2'b01: begin
            seg <= char2;  // 显示第二个字母
            an <= 4'b0010; // 激活第二个数码管
        end
        2'b10: begin
            seg <= char3;  // 显示第三个字母
            an <= 4'b0100; // 激活第三个数码管
        end
        2'b11: begin
            seg <= char4;  // 显示第四个字母
            an <= 4'b1000; // 激活第四个数码管
        end
    endcase
end




endmodule
