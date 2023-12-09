
//module to store songs
module Lib(
    input wire clk, // Clock signal
    input wire [1:0] song_select, // choose song
    output wire [243:0] song_packed // out_put song
);

  parameter t=4'b0000, t0=4'b0001, t1=4'b0001, t2=4'b0101, t3=4'b0101, t4=4'b0110, t5=4'b0110, t6=4'b0101, 
  t7=4'b0100, t8=4'b0100, t9=4'b0011, t10=4'b0011, t11=4'b0010, t12=4'b0010, t13=4'b0001, t14=4'b0101,
  t15=4'b0101, t16=4'b0100, t17=4'b0100, t18=4'b0011, t19=4'b0011, t20=4'b0010, t21=4'b0101, t22=4'b0101, 
  t23=4'b0100, t24=4'b0100, t25=4'b0011, t26=4'b0011, t27=4'b0010; 
  //1155665 4433221 5544332 5544332


// song 1 twinkle_twinkle:


assign song_packed = {t,t,t,t27, t,t26,t, t25,t, t24,t, t23,t, t22,t, t21, 
t,t,t20,t, t19, t,t18, t,t17, t,t16,t, t15, t,t14, 
t,t,t13,t, t12,t, t11,t, t10,t, t9, t,t8,t, t7,
t,t,t6,t, t5,t, t4, t,t3, t,t2,t, t1,t, t0};



endmodule