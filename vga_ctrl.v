`timescale 1ns / 1ps



module vga_ctrl(
    input wire             vga_clk   ,
    input wire             sys_rst_n ,
    input wire    [11:0]   pix_data  ,

    output wire    [9:0]   pix_x    ,
    output wire    [9:0]   pix_y    ,
    output wire            hsync    ,//Horizontal synchronization signal
    output wire            vsync    ,//Vertical synchronization signal
    output wire    [11:0]  vga_rgb
);
`include "par.v"


reg [9:0]   cnt_h     ; //count for horizontal
reg [9:0]   cnt_v     ; //count for vertical
wire        rgb_valid ;//valid signal
wire        pix_data_req;//pixel data request


//horizontal
always @(posedge vga_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) begin
        cnt_h <= 10'd0;
    end
    else if (cnt_h == (H_TOTAL - 1'b1)) begin
        cnt_h <= 10'd0;
    end
    else begin
        cnt_h <= cnt_h + 10'd1;
    end
end


//vertical
always @(posedge vga_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) begin
        cnt_v <= 10'd0;
    end
    else if ((cnt_h == (H_TOTAL - 1'b1)) && (cnt_v == (V_TOTAL - 1'b1))) begin
        cnt_v <= 10'd0;
    end
    else if (cnt_h == (H_TOTAL-1'b1)) begin
        cnt_v <= cnt_v + 10'd1;
    end
    else begin
        cnt_v <= cnt_v;
    end
end

//valid signal when horizontal and vertical are both valid
assign rgb_valid = ((cnt_h >= H_SYNC + H_BACK + H_LEFT)
                    && (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID)
                    && (cnt_v >= V_SYNC + V_BACK + V_TOP)
                    && (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID))
                    ?  1'b1 : 1'b0;


// we need to prepare the pixel data(next) data
assign pix_data_req = ((cnt_h >= H_SYNC + H_BACK + H_LEFT - 1'b1)
                    && (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID - 1'b1)
                    && (cnt_v >= V_SYNC + V_BACK + V_TOP)
                    && (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID))
                    ?  1'b1 : 1'b0;


assign pix_x = (pix_data_req == 1'b1) ? (cnt_h - (H_SYNC + H_BACK + H_LEFT) - 1'b1) : 10'd0;
assign pix_y = (pix_data_req == 1'b1) ? (cnt_v - (V_SYNC + V_BACK + V_TOP)) : 10'd0;
assign hsync = (cnt_h <= H_SYNC - 1'b1) ? 1'b1 : 1'b0;
assign vsync = (cnt_v <= V_SYNC - 1'b1) ? 1'b1 : 1'b0;
assign vga_rgb = (rgb_valid == 1'b1) ? pix_data : 12'h000;

// parameter
//           H_SYNC   = 10'd96, Synchronous pulse
//           H_BACK   = 10'd40, Back hidden area
//           H_LEFT   = 10'd8, Blank edges
//           H_VALID  = 10'd640,
//           H_RIGHT  = 10'd8,
//           H_FRONT  = 10'd8,
//           H_TOTAL  = 10'd800;

        //   V_SYNC   = 10'd2,
        //   V_BACK   = 10'd25,
        //   V_TOP    = 10'd8,
        //   V_VALID  = 10'd480,
        //   V_BOTTOM = 10'd8,
        //   V_FRONT  = 10'd2,
        //   V_TOTAL  = 10'd525;

endmodule
