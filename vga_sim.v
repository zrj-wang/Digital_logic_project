`timescale 1ns / 1ps

module vga_colorbar_tb();

// 测试输入
reg sys_clk;
reg sys_rst_n;

// 测试输出
wire hsync;
wire vsync;
wire [11:0] vga_rgb;

// 实例化 vga_colorbar 模块
vga_colorbar uut (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .hsync(hsync),
    .vsync(vsync),
    .vga_rgb(vga_rgb)
);

// 初始化系统时钟
initial begin
    sys_clk = 0;
    forever #10 sys_clk = ~sys_clk;  // 产生 50MHz 时钟
end

// 初始化测试
initial begin
    // 初始化复位信号
    sys_rst_n = 0;
    #100;                // 等待一段时间
    sys_rst_n = 1;       // 释放复位
    #100000;             // 模拟一段时间的运行
    $finish;             // 结束仿真
end

endmodule
