`timescale 1ns / 1ps
//
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 20:23:04
// Design Name: 
// Module Name: vga_colorbar
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


module vga_colorbar(
    input wire        sys_clk,
    input wire        sys_rst_n,

    output wire       hsync,
    output wire       vsync,
    output wire  [11:0] vga_rgb
);


wire        vga_clk;
wire        locked;
wire        rst_n;

wire    [9:0]    pix_x;
wire    [9:0]    pix_y;
wire    [11:0]   pix_data;


assign  rst_n = (sys_rst_n && locked);



clk_gen clk_gen_inst
(
  // Clock out ports  
  .clk_out1(vga_clk),
  // Status and control signals               
  .reset(~sys_rst_n), 
  .locked(locked),
 // Clock in ports
  .clk_in1(sys_clk)
);

vga_ctrl vga_ctrl_inst
(
    .vga_clk  (vga_clk) ,
    .sys_rst_n(rst_n) ,
    .pix_data (pix_data) ,

    .pix_x    (pix_x  ),
    .pix_y    (pix_y  ),
    .hsync    (hsync  ),
    .vsync    (vsync  ),
    .vga_rgb  (vga_rgb)
);

vga_pic vga_pic_inst
(
    .vga_clk(vga_clk),
    .sys_rst_n(rst_n),
    .pix_x(pix_x),
    .pix_y(pix_y),

    .pix_data(pix_data)
);
endmodule
