
//module to store songs
module Lib(
    input wire clk, // Clock signal
    input wire [1:0] song_select, // choose song
    output wire [111:0] song_packed // out_put song
);

  parameter t0=4'b0001, t1=4'b0001, t2=4'b0101, t3=4'b0101, t4=4'b0110, t5=4'b0110, t6=4'b0101, 
  t7=4'b0100, t8=4'b0100, t9=4'b0011, t10=4'b0011, t11=4'b0010, t12=4'b0010, t13=4'b0001, t14=4'b0101,
  t15=4'b0101, t16=4'b0100, t17=4'b0100, t18=4'b0011, t19=4'b0011, t20=4'b0010, t21=4'b0101, t22=4'b0101, 
  t23=4'b0100, t24=4'b0100, t25=4'b0011, t26=4'b0011, t27=4'b0010;
  


// song 1 twinkle_twinkle:


assign song_packed = {t27, t26, t25, t24, t23, t22, t21, t20, t19, t18, t17, 
t16, t15, t14, t13, t12, t11, t10, t9, t8, t7, t6, t5, t4, t3, t2, t1, t0};



endmodule