
//module to store songs
module Lib(
    input wire clk, // Clock signal
    input wire [3:0] song_num, // on behalf of song
    output reg [223:0] song_packed, // out_put song
    output reg [223:0] time_continue, // each note time
    output reg [111:0] octave_packed, // out_put ocative
    output reg [3:0]num
);


  //1155665 4433221 5544332 5544332
  parameter t=4'b0000,t1=4'b0001, t2=4'b0010, t3=4'b0011, t4=4'b0100,
  t5=4'b0101, t6=4'b0110, t7=4'b0111, t9=4'b1111;
  parameter ti1=4'd1,ti2=4'd2,ti3=4'd3,ti4=4'd4,ti5=4'd5,ti6=4'd6,ti7=4'd7,ti8=4'd8,ti9=4'd9;

parameter song_1=4'd1, song_2=4'd2,song_3=4'd3,song_4=4'd4,song_5=4'd5,song_6=4'd6; 
  parameter lo=2'b01, hi=2'b10, ma=2'b00;


//twinkle twinkle little star
  always @(*) begin
    case(song_num)
      song_1: begin
        song_packed={t,t2, t,t3,t, t3,t, t4,t, t4,t, t5,t, t5, 
        t,t2,t, t3, t,t3, t,t4, t,t4,t, t5, t,t5, 
        t,t1,t, t2,t, t2,t, t3,t, t3, t,t4,t, t4,
        t,t5,t, t6,t, t6, t,t5, t,t5,t, t1,t, t1};

        time_continue={
        ti3,ti5,ti3,ti5,ti3,ti5,ti3,
        ti5,ti3,ti5,ti3,ti5,ti3,ti5,
        ti3,ti5,ti3,ti5,ti3,ti5,ti3,
        ti5,ti3,ti5,ti3,ti5,ti3,ti5,
        ti3,ti5,ti3,ti5,ti3,ti5,ti3,
        ti5,ti3,ti5,ti3,ti5,ti3,ti5,
        ti3,ti5,ti3,ti5,ti3,ti5,ti3,
        ti5,ti3,ti5,ti3,ti5,ti3,ti5};

        octave_packed={
          ma, ma, ma, ma, ma, ma, ma, ma,
           ma, ma, ma, ma, ma, ma, ma, ma,
            ma, ma, ma, ma, ma, ma, ma, ma,
             ma, ma, ma, ma, ma, ma, ma, ma,
              ma, ma, ma, ma, ma, ma, ma, ma,
               ma, ma, ma, ma, ma, ma, ma, ma,
                ma, ma, ma, ma, ma, ma, ma, ma
        };

        num=4'd1;

              end


//happy_birthday

      song_2: begin
        song_packed={ t9,t9,t9,t9,t9,t9,
        t,t3,t,t2,t,t1,t,t3,t,t4,t,t4,t,
        t6,t,t7,t,t1,t,t3,t,t5,t,t5,t,t5,
        t,t1,t,t2,t,t5,t,t6,t,t5,t,t5,
        t,t7,t,t1,t,t5,t,t6,t,t5,t,t5//52  //556517 556521 5553176 443123
};
        time_continue={
        ti1,ti1,ti1,ti1,ti1,ti1,
        ti1,ti6,ti3,ti6,ti3,ti6,ti3,ti6,ti3,ti4,ti2,ti4,
        ti3,ti6,
        ti2,ti6,ti3,ti6,ti3,ti6,ti3,ti6,ti3,ti4,ti2,ti4,ti3,
        ti9,ti3,ti6,ti3,ti6,ti3,ti6,ti3,ti4,ti2,ti4,ti3,
        ti9,ti3,ti6,ti3,ti6,ti3,ti6,ti3,ti4,ti2,ti4};

                octave_packed={
ma, ma, ma, ma, ma, ma, 
ma, ma, ma, ma, ma, ma,ma, ma, ma, ma, ma, ma, 
 ma, ma, ma, lo, ma, ma,ma, ma, ma, ma, ma, lo, ma, lo, 
  ma, ma, ma, ma,ma, lo, ma, lo, ma, lo, ma, lo, 
   ma, lo, ma, ma, ma, lo, ma, lo, ma, lo, ma, lo

        };

        num=4'd2;

      end



//happy new year
      song_3: begin
        song_packed={
        t1,t2,t,t7,
        t,t5,t,t2,t,t3,t,t1,
        t,t1,t,t3,t,t2,t,t3,
        t,t4,t,t4,t,t3,t,t2,
        t,t2,t,t3,t,t4,
        t,t5,t,t5,t,t3,t,t1,
        t,t1,t,t3,t,t3,t,t3,
        t,t5,t,t1,t,t1 //
        };

        time_continue={        
        ti9,ti5,ti5,ti3,ti4,ti4,ti4,
        ti6,ti3,ti6,ti3,ti4,ti4,ti4,   
        ti3,ti6,ti3,ti6,ti3,ti4,ti4,
        ti4,
        ti3,ti6,ti3,ti6,ti3,ti4,
        ti4,ti4,
        ti3,ti9,ti4,ti4,
        ti3,ti6,ti3,ti6,ti3,ti4,ti4,ti4,
        ti3,ti6,ti3,ti6,ti3,ti4,ti4,ti4,
        ti3,ti6,ti3,ti6,ti3,ti4};

                        octave_packed={
ma, ma, ma, lo, 
ma, lo, ma, ma, ma, ma, ma, ma, 
ma, ma, ma, ma, ma, ma,ma, ma, 
 ma, ma, ma, ma, ma, ma, ma, ma,
ma, ma, ma, ma, ma, ma, 
ma, ma, ma, ma, ma, ma, ma, ma,
 ma, ma, ma, ma, ma, ma, ma, ma,
 ma, lo, ma, ma, ma, ma

        };
        num=4'd3;

      end
      
      song_4: begin
        num=4'd4;
      end

      song_5: begin
        num=4'd5;
      end

      song_6: begin
        num=4'd6;
      end
      
  endcase

  end
//115 3331 1355 432 2344 3231  1325 721





endmodule