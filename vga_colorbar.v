`timescale 1ns / 1ps



module vga_colorbar(
    input wire        sys_clk,
    input wire        sys_rst_n,
    input wire [6:0] status,
    input wire [3:0]  num,

    output wire       hsync,
    output wire       vsync,
    output wire  [11:0] vga_rgb
);
`include "par.v"


wire        vga_clk;
wire        locked;
wire        rst_n;

wire    [9:0]    pix_x;
wire    [9:0]    pix_y;
wire    [11:0]   pix_data;


assign  rst_n = (sys_rst_n && locked);



//use ip core to generate 25MHz clock
clk_wiz_0 clk_wiz_inst
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
    .status(status),
    .num(num),
    .pix_data(pix_data)
);
endmodule
