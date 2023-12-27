module clk_gen(
    input wire clk_in1,      // 系统时钟输入
    input wire reset,        // 异步复位信号
    output wire clk_out1,    // 分频后的时钟输出
    output reg locked        // 锁定信号
);

// 参数定义
parameter CLK_IN_FREQ = 100000000; // 输入时钟频率 100MHz
parameter CLK_OUT_FREQ = 25000000; // 输出时钟频率 25MHz
localparam integer DIVIDE_FACTOR = CLK_IN_FREQ / CLK_OUT_FREQ / 2; // 计算分频因子

// 内部变量定义
reg [31:0] counter = 0;

// 时钟分频逻辑
always @(posedge clk_in1 or posedge reset) begin
    if (!reset) begin
        counter <= 0;
        locked <= 0;
    end else begin
        if (counter == DIVIDE_FACTOR - 1) begin
            counter <= 0;
            locked <= 1;
        end else begin
            counter <= counter + 1;
        end
    end
end

// 生成分频时钟
assign clk_out1 = (counter < DIVIDE_FACTOR / 2) ? 1'b1 : 1'b0;

endmodule
