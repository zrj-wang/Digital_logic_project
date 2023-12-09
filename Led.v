module Led(
    input wire [6:0] leds, // �����źţ�ÿһλ����һ��LED
    output wire [6:0] led_output // LED����ź�
);

    // ֱ�ӽ������ź�ӳ�䵽���
    assign led_output = leds;

endmodule
