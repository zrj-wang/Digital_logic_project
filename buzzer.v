
module Buzzer (
 input wire clk , // Clock signal
 input wire [3:0] note , // Note ( Input 1 outputs a signal for 'do , ' 2 for 're , ' 3 for 'mi , ' 4 ,and so on)
 output wire speaker , // Buzzer output signal
 input wire[2:0] mode, // Reset signal
 input wire[1:0] octave,//choose octave :01 lower octave; 10 higher ocative; elese maintain previous octave
 input wire[1:0] octave_auto
 ) ;

 
integer muti;

always @(*) begin
    case (mode)
        3'b010: begin
            case (octave_auto)
                2'b01: muti = 2;   // 增加一倍频率
                2'b10: muti = 1;   // 减半频率（通过跳过一半的计数来实现）
                default: muti = 2; // 默认值
            endcase
        end

        3'b100: begin
            case (octave)
                2'b01: muti = 2;   // 增加一倍频率
                2'b10: muti = 1;   // 减半频率
                default: muti = 2; // 默认值
            endcase
        end

        default: muti = 2;
    endcase
end



 wire [31:0] notes [7:0];
 reg [31:0] counter ;
 reg pwm ;
 // Frequencies of do , re , mi , fa , so , la , si
 // Obtain the ratio of how long the buzzer should be active in one second
 assign notes [1]=381680;
 assign notes [2]=340136;
 assign notes [3]=303030;
 assign notes [4]=285714;
 assign notes [5]=255102;
 assign notes [6]=227273;
 assign notes [7]=202429;


 initial
 begin
 pwm =0;
 end


 always @(posedge clk) begin
    if (counter < notes[note] || note == 1'b0) begin
        if (muti == 1 || (muti == 2 && counter[0] == 1'b0)) begin
            // 只在 muti 为 1 或 muti 为 2 且计数器为偶数时递增计数器
            counter <= counter + 1;
        end
    end else begin
        pwm <= ~pwm;
        counter <= 0;
    end
end
 assign speaker = pwm ; // Output a PWM signal to the buzzer
 endmodule
