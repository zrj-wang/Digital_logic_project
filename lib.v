
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





//twinkle twinkle little star
  always @(*) begin
    case(song_num)
      song_1: begin
        song_packed={t2, t,t3,t, t3,t, t4,t, t4,t, t5,t, t5, 
        t,t2,t, t3, t,t3, t,t4, t,t4,t, t5, t,t5, 
        t,t1,t, t2,t, t2,t, t3,t, t3, t,t4,t, t4,
        t,t5,t, t6,t, t6, t,t5, t,t5,t, t1,t, t1,t};

        time_continue={
        ti5,ti3,ti5,ti3,ti5,ti3,
        ti5,ti3,ti5,ti3,ti5,ti3,ti5,
        ti3,ti5,ti3,ti5,ti3,ti5,ti3,
        ti5,ti3,ti5,ti3,ti5,ti3,ti5,
        ti3,ti5,ti3,ti5,ti3,ti5,ti3,
        ti5,ti3,ti5,ti3,ti5,ti3,ti5,
        ti3,ti5,ti3,ti5,ti3,ti5,ti3,
        ti5,ti3,ti5,ti3,ti5,ti3,ti5,ti3};

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
        song_packed={ t9,t9,t9,t9,t9,
        t,t3,t,t2,t,t1,t,t3,t,t4,t,t4,t,
        t6,t,t7,t,t1,t,t3,t,t5,t,t5,t,t5,
        t,t1,t,t2,t,t5,t,t6,t,t5,t,t5,
        t,t7,t,t1,t,t5,t,t6,t,t5,t,t5,t
};//52  //556517 556521 5553176 443123
        time_continue={
        ti1,ti1,ti1,ti1,ti1,
        ti1,ti6,ti3,ti6,ti3,ti6,ti3,ti6,ti3,ti4,ti2,ti4,
        ti3,ti6,
        ti2,ti6,ti3,ti6,ti3,ti6,ti3,ti6,ti3,ti4,ti2,ti4,ti3,
        ti9,ti3,ti6,ti3,ti6,ti3,ti6,ti3,ti4,ti2,ti4,ti3,
        ti9,ti3,ti6,ti3,ti6,ti3,ti6,ti3,ti4,ti2,ti4,ti1};

                octave_packed={
 ma, ma, ma, ma, ma, 
ma, ma, ma, ma, ma, ma,ma, ma, ma, ma, ma, ma, 
 ma, ma, ma, lo, ma, ma,ma, ma, ma, ma, ma, lo, ma, lo, 
  ma, ma, ma, ma,ma, lo, ma, lo, ma, lo, ma, lo, 
   ma, lo, ma, ma, ma, lo, ma, lo, ma, lo, ma, lo,ma

        };

        num=4'd2;

      end



//happy new year
      song_3: begin
        song_packed={
        t2,t,t7,
        t,t5,t,t2,t,t3,t,t1,
        t,t1,t,t3,t,t2,t,t3,
        t,t4,t,t4,t,t3,t,t2,
        t,t2,t,t3,t,t4,
        t,t5,t,t5,t,t3,t,t1,
        t,t1,t,t3,t,t3,t,t3,
        t,t5,t,t1,t,t1,t 
        };

        time_continue={        
        ti5,ti5,ti3,ti4,ti4,ti4,
        ti6,ti3,ti6,ti3,ti4,ti4,ti4,   
        ti3,ti6,ti3,ti6,ti3,ti4,ti4,
        ti4,
        ti3,ti6,ti3,ti6,ti3,ti4,
        ti4,ti4,
        ti3,ti9,ti4,ti4,
        ti3,ti6,ti3,ti6,ti3,ti4,ti4,ti4,
        ti3,ti6,ti3,ti6,ti3,ti4,ti4,ti4,
        ti3,ti6,ti3,ti6,ti3,ti4,ti9};

                        octave_packed={
 ma, ma, lo, 
ma, lo, ma, ma, ma, ma, ma, ma, 
ma, ma, ma, ma, ma, ma,ma, ma, 
 ma, ma, ma, ma, ma, ma, ma, ma,
ma, ma, ma, ma, ma, ma, 
ma, ma, ma, ma, ma, ma, ma, ma,
 ma, ma, ma, ma, ma, ma, ma, ma,
 ma, lo, ma, ma, ma, ma,ma

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