
module para();
    // Parameter declarations
    parameter mode_free=3'b100, mode_auto=3'b010, mode_learn=3'b001;
    parameter t0=4'b0001, t1=4'b0001, t2=4'b0101, t3=4'b0101, t4=4'b0110, t5=4'b0110, t6=4'b0101, t7=4'b0100, t8=4'b0100, t9=4'b0011, t10=4'b0011, t11=4'b0010, t12=4'b0010, t13=4'b0001, t14=4'b0101, t15=4'b0101, t16=4'b0100, t17=4'b0100, t18=4'b0011, t19=4'b0011, t20=4'b0010, t21=4'b0101, t22=4'b0101, t23=4'b0100, t24=4'b0100, t25=4'b0011, t26=4'b0011, t27=4'b0010;
    parameter note_duration = 500000;
    parameter HALF_SECOND_COUNT = 50_000_000;
endmodule
