
module Buzzer (
 input wire clk , // Clock signal
 input wire [3:0] note , // Note ( Input 1 outputs a signal for 'do , ' 2 for 're , ' 3 for 'mi , ' 4 ,and so on)
 output wire speaker , // Buzzer output signal
 input wire[1:0] octave//choose octave :01 lower octave; 10 higher ocative; elese maintain previous octave
 ) ;
 
 reg muti;
always@(*)begin
case (octave)
2'b01:muti=2;
2'b10:muti=0.5;
default:muti=1;
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
 always @ (posedge clk) begin
 //add muti to control the frequency of buzzing so that the octave is changed
 if ( counter < notes [ note ]*muti|| note ==1'b0 ) begin
 counter <= counter + 1'b1 ;
 end 
 else begin
 pwm =~ pwm ;
 counter <= 0;
 end
 end
 assign speaker = pwm ; // Output a PWM signal to the buzzer
 endmodule
