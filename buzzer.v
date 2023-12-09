module Buzzer (
 input wire clk , // Clock signal
 input wire [3:0] note , // Note ( Input 1 outputs
 //signal for 'do ,' 2 for 're ,' 3 for 'mi ,' 4,
//and so on)
output wire speaker // Buzzer output signal
 );

 wire [31:0] notes [6:0];
 reg [31:0] counter ;
 reg pwm;
 // Frequencies of do , re , mi , fa , so , la , si
 // Obtain the ratio of how long the buzzer should be
//active in one second
 assign notes [0]=381680;
 assign notes [1]=340136;
 assign notes [2]=303030;
 assign notes [3]=285714;
 assign notes [4]=255102;
 assign notes [5]=227273;
 assign notes [6]=202429;
 initial
 begin
 pwm =0;
 end
 always @( posedge clk ) begin
 if ( counter < notes [ note ]|| note ==1'b0)
  begin
 counter <= counter + 1'b1;
 end else begin
    pwm =~ pwm;
 counter <= 0;
 end
 end

 assign speaker = pwm ; // Output a PWM signal to the
endmodule