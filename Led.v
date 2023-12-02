module Led(
    input wire [7:0] leds, // 输入信号，每一位控制一个LED
    output wire [7:0] led_output // LED输出信号
);

    // 直接将输入信号映射到输出
    assign led_output = leds;

endmodule
