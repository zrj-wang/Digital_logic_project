`timescale 1ns / 1ps
//
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 19:53:47
// Design Name: 
// Module Name: vga_pic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//


module vga_pic(
    input wire         vga_clk     ,
    input wire         sys_rst_n   ,
    input wire  [9:0]  pix_x       ,
    input wire  [9:0]  pix_y       ,

    output reg   [11:0]    pix_data
);

parameter H_VALID = 10'd640,
          V_VALID = 10'D480;

parameter   RED     = 12'hF80,
            ORANGE  = 12'hFC0,
            YELLOW  = 12'hFFE,
            GREEN   = 12'h07E,
            CYAN    = 12'h07F,
            BLUE    = 12'h01F,
            PURPPLE = 12'hF81,
            BLACK   = 12'h000,
            WHITE   = 12'hFFF,
            GRAY    = 12'hD69;

always@ (posedge vga_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) begin
        pix_data <= BLACK;
    end
    else if (pix_x >= 0 && pix_x < (H_VALID / 10) * 1) begin
        pix_data <= RED;
    end
    else if (pix_x >= ((H_VALID / 10) * 1) && pix_x < ((H_VALID / 10) * 2) ) begin
        pix_data <= ORANGE;
    end
    else if (pix_x >= ((H_VALID / 10) * 2) && pix_x < ((H_VALID / 10) * 3) ) begin
        pix_data <= YELLOW;
    end
    else if (pix_x >= ((H_VALID / 10) * 3) && pix_x < ((H_VALID / 10) * 4) ) begin
        pix_data <= GREEN;
    end
    else if (pix_x >= ((H_VALID / 10) * 4) && pix_x < ((H_VALID / 10) * 5) ) begin
        pix_data <= CYAN;
    end
    else if (pix_x >= ((H_VALID / 10) * 5) && pix_x < ((H_VALID / 10) * 6) ) begin
        pix_data <= BLUE;
    end
    else if (pix_x >= ((H_VALID / 10) * 6) && pix_x < ((H_VALID / 10) * 7) ) begin
        pix_data <= PURPPLE;
    end
    else if (pix_x >= ((H_VALID / 10) * 7) && pix_x < ((H_VALID / 10) * 8) ) begin
        pix_data <= BLACK;
    end
    else if (pix_x >= ((H_VALID / 10) * 8) && pix_x < ((H_VALID / 10) * 9) ) begin
        pix_data <= WHITE;
    end
    else if (pix_x >= ((H_VALID / 10) * 9) && pix_x < (H_VALID)) begin
        pix_data <= WHITE;
    end
    else begin
        pix_data <= BLACK;
    end
end
endmodule
