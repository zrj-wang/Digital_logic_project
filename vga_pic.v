`timescale 1ns / 1ps



module vga_pic(
    input wire         vga_clk     ,
    input wire         sys_rst_n   ,
    input wire  [9:0]  pix_x       ,
    input wire  [9:0]  pix_y       ,
    input wire  [6:0]  status      ,   
    output reg   [11:0]    pix_data,
    input wire  [3:0]  num
);
 `include "par.v"


reg[0:3071] little=little_star;
reg[0:4095] birthday=happy_birthday;
reg[0:4095] new_year=happy_new_year;
reg [0:4095] defa=no_choice;


integer relative_x, relative_y, index;
integer char_width;
integer max_width; 

always @(posedge vga_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        pix_data <= 12'h000; // BLACK
    end else if (pix_x < (H_VALID * 7 / 10)) begin
    // the first 7/10 of the screen is used to display the color bar
    //  1 white line
    if (pix_x < (H_VALID >> 3) + (H_VALID >> 4)) begin
        pix_data <= status[0] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 1 black line
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4)) begin
        pix_data <= 12'h000; // BLACK line between white lines
    end 
    // 2 white line
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 2) begin
        pix_data <= status[1] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 2 black line
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4) * 2) begin
        pix_data <= 12'h000; // BLACK line
    end 
    // 3  white line
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 3) begin
        pix_data <= status[2] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 3 black line
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4) * 3) begin
        pix_data <= 12'h000; // BLACK line
    end 
    // 4 white line
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 4) begin
        pix_data <= status[3] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 4 black line
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4) * 4) begin
        pix_data <= 12'h000; // BLACK line
    end 
    // 5 white line
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 5) begin
        pix_data <= status[4] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 5 black line
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4) * 5) begin
        pix_data <= 12'h000; // BLACK line
    end 
    // 6 white line
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 6) begin
        pix_data <= status[5] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 6 black line
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4) * 6) begin
        pix_data <= 12'h000; // BLACK line
    end 
    // 7 white line
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 7) begin
        pix_data <= status[6] ? 12'h000 : 12'hFFF; // WHITE
    end 
    else begin
        pix_data <= 12'hFFF; // WHITE (or other color as needed)
    end
end else begin
        // the right 3/10 of the screen is used to display the picture
        relative_x = pix_x - (H_VALID * 7 / 10);
        relative_y = pix_y;


        if (num == 4'd1) begin
            char_width = 32 * 3; // 3 words
        end else begin
            char_width = 32 * 4; // 
        end

        max_width = char_width; 

        if (relative_y < 32 && relative_x < max_width) begin
            // calculate the index of the pixel in the picture
            index = relative_y * max_width + relative_x;

            case (num)
                4'd1: begin
                    //  little_star
                    if (index < 3072 && little[index] == 1'b1) begin
                        pix_data <= BLACK;
                    end else begin
                        pix_data <= CYAN; 
                    end
                end
                4'd2: begin
                    //  happy_birthday
                    if (index < 4096 && birthday[index] == 1'b1) begin
                        pix_data <= BLACK;
                    end else begin
                        pix_data <= GREEN; 
                    end
                end
                4'd3: begin
                    //  happy_new_year
                    if (index < 4096 && new_year[index] == 1'b1) begin
                        pix_data <= BLACK;
                    end else begin
                        pix_data <= BLUE; 
                    end
                end
                default: begin
                    //  no_choice
                    if (index < 4096 && defa[index] == 1'b1) begin
                        pix_data <= BLACK;
                    end else begin
                        pix_data <= RED; 
                    end
                end
            endcase
        end else begin
            pix_data <= CYAN;  
        end
    end
end






endmodule
