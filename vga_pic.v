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
// `include "par.v"


parameter H_VALID = 10'd640,
          V_VALID = 10'd480;


parameter   RED     = 12'hF80,
            ORANGE  = 12'hFC0,
            YELLOW  = 12'hFFE,
            GREEN   = 12'h07E,
            CYAN    = 12'h07F,
            BLUE    = 12'h01F,//红色？？？
            PURPPLE = 12'hF81,
            BLACK   = 12'h000,
            WHITE   = 12'hFFF,
            GRAY    = 12'hD69;

reg[0:3071] little=little_star;
reg[0:4095] birthday=happy_birthday;
reg[0:4095] new_year=happy_new_year;
reg [0:4095] defa=no_choice;

reg [7:0] char_matrix [0:89]; // 90行数据

integer relative_x, relative_y, index;
integer char_width;
integer max_width; // 四个字符的总宽度

always @(posedge vga_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        pix_data <= 12'h000; // BLACK
    end else if (pix_x < (H_VALID * 7 / 10)) begin
    // 第1条白线
    if (pix_x < (H_VALID >> 3) + (H_VALID >> 4)) begin
        pix_data <= status[0] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 第1条黑线
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4)) begin
        pix_data <= 12'h000; // BLACK line between white lines
    end 
    // 第2条白线
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 2) begin
        pix_data <= status[1] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 第2条黑线
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4) * 2) begin
        pix_data <= 12'h000; // BLACK line
    end 
    // 第3条白线
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 3) begin
        pix_data <= status[2] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 第3条黑线
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4) * 3) begin
        pix_data <= 12'h000; // BLACK line
    end 
    // 第4条白线
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 4) begin
        pix_data <= status[3] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 第4条黑线
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4) * 4) begin
        pix_data <= 12'h000; // BLACK line
    end 
    // 第5条白线
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 5) begin
        pix_data <= status[4] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 第5条黑线
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4) * 5) begin
        pix_data <= 12'h000; // BLACK line
    end 
    // 第6条白线
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 6) begin
        pix_data <= status[5] ? 12'h000 : 12'hFFF; // WHITE
    end 
    // 第6条黑线
    else if (pix_x == (H_VALID >> 3) + (H_VALID >> 4) * 6) begin
        pix_data <= 12'h000; // BLACK line
    end 
    // 第7条白线
    else if (pix_x < (H_VALID >> 3) + (H_VALID >> 4) * 7) begin
        pix_data <= status[6] ? 12'h000 : 12'hFFF; // WHITE
    end 
    else begin
        pix_data <= 12'hFFF; // WHITE (or other color as needed)
    end
end else begin
        // 在右侧区域显示图案的逻辑
        relative_x = pix_x - (H_VALID * 7 / 10);
        relative_y = pix_y;

        // 设定每个字符的宽度
        if (num == 4'd1) begin
            char_width = 32 * 3; // 小星星有3个字符
        end else begin
            char_width = 32 * 4; // 其他图案有4个字符
        end

        max_width = char_width; // 根据字符数设置最大宽度

        if (relative_y < 32 && relative_x < max_width) begin
            // 根据字符宽度计算索引
            index = relative_y * max_width + relative_x;

            case (num)
                4'd1: begin
                    // 显示 little_star
                    if (index < 3072 && little[index] == 1'b1) begin
                        pix_data <= BLACK;
                    end else begin
                        pix_data <= CYAN; // 背景色
                    end
                end
                4'd2: begin
                    // 显示 happy_birthday
                    if (index < 4096 && birthday[index] == 1'b1) begin
                        pix_data <= BLACK;
                    end else begin
                        pix_data <= GREEN; // 背景色
                    end
                end
                4'd3: begin
                    // 显示 happy_new_year
                    if (index < 4096 && new_year[index] == 1'b1) begin
                        pix_data <= BLACK;
                    end else begin
                        pix_data <= BLUE; // 背景色
                    end
                end
                default: begin
                    // 显示 no_choice
                    if (index < 4096 && defa[index] == 1'b1) begin
                        pix_data <= BLACK;
                    end else begin
                        pix_data <= RED; // 背景色
                    end
                end
            endcase
        end else begin
            pix_data <= CYAN; // 其他部分的默认颜色
        end
    end
end







// else begin
//         // 在右侧区域显示汉字的逻辑
        
//         relative_x = pix_x - (H_VALID * 7 / 10);
//         relative_y = pix_y;
        
//         // 确保只在汉字的高度内进行处理，且relative_x在合理范围内
//         if (relative_y < 32 && relative_x < 96) begin
//             // 计算汉字点阵的索引
//             index = relative_y * 96 + relative_x; // 每行96像素宽
            
//             // 确保索引在位图数据范围内
//             if (index < 3072 && little[index] == 1'b1) begin
//                 pix_data <= 12'h000; // BLACK for bitmap
//             end else begin
//                 pix_data <= 12'h07F; //  background
//             end
//         end else begin
//             pix_data <= 12'h01F; // BLUE for the rest of the right side
//         end
//     end

//demo piano

// always @(posedge vga_clk or negedge sys_rst_n) begin
//     if (sys_rst_n == 1'b0) begin
//         pix_data <= BLACK;
//     end
//     else if (pix_x < ((H_VALID / 10) * 7)) begin
//         if (pix_x % 64 == 63)  // 每64个像素的最后一个设置为黑色
//             pix_data <= BLACK;
//         else
//             pix_data <= WHITE;
//     end
//     else if (pix_x >= ((H_VALID / 10) * 7)) begin
//         pix_data <= BLUE;
//     end
//     else begin
//         pix_data <= BLACK;
//     end
// end



endmodule
