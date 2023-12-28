
module para();
    // Parameter declarations
    parameter mode_free=3'b100, mode_auto=3'b010, mode_learn=3'b001, mode_competition=3'b011;
    parameter t0=4'b0001, t1=4'b0001, t2=4'b0101, t3=4'b0101, t4=4'b0110, t5=4'b0110, t6=4'b0101, t7=4'b0100, t8=4'b0100, t9=4'b0011, t10=4'b0011, t11=4'b0010, t12=4'b0010, t13=4'b0001, t14=4'b0101, t15=4'b0101, t16=4'b0100, t17=4'b0100, t18=4'b0011, t19=4'b0011, t20=4'b0010, t21=4'b0101, t22=4'b0101, t23=4'b0100, t24=4'b0100, t25=4'b0011, t26=4'b0011, t27=4'b0010;
    parameter note_duration = 500000;
    parameter Half_second = 50_000_000;
    parameter second = 10000000, song_time=56,music0=4'b0000,
    music1=4'b0001, music2=4'b0010,music3=4'b0011,music4=4'b0100,music5=4'b0101,
    music6=4'b0110,music7=4'b0111,music9=4'b1111,
    led1=7'b0000001,led2=7'b0000010,led3=7'b0000100,led4=7'b0001000,led5=7'b0010000,
    led6=7'b0100000,led7=7'b1000000,led8=7'b0000000;

    parameter song_1=4'd1, song_2=4'd2,song_3=4'd3,song_4=4'd4,song_5=4'd5,song_6=4'd6; 
    parameter speed_mid=2'b01, speed_low=2'b00, speed_high=2'b10;
endmodule
