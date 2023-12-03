`include "parameter.v"
module Lib(
    input wire [1:0] song_select, // 选择曲目的输入
    output reg [3:0] note,        // 输出音符
    output reg end_of_song        // 曲目结束的信号
);

    // 示例曲目数据
    reg [3:0] song1[0:15]; // 假设每首曲目有16个音符
    reg [3:0] song2[0:15];
    
    // 初始化曲目数据
    initial begin
        song1[0] = 4'd1; // 曲目1的音符数据
        // ... 填充剩余的音符
        song2[0] = 4'd3; // 曲目2的音符数据
        // ... 填充剩余的音符
        end_of_song = 0;
    end

    // 根据选择的曲目输出音符
    always @(song_select) begin
        case(song_select)
            2'b00: note <= song1[/* 当前音符索引 */];
            2'b01: note <= song2[/* 当前音符索引 */];
            // 可以根据需要添加更多的曲目
            default: note <= 4'd0; // 无效选择
        endcase
    end
endmodule
