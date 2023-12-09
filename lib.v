
//module to store songs
module Lib(
    input wire clk, // Clock signal
    input wire [1:0] song_num, // on behalf of song
    output reg [223:0] song_packed, // out_put song
    output reg [223:0] time_continue // each note time
);


  //1155665 4433221 5544332 5544332
  parameter t=4'b0000,t1=4'b0001, t2=4'b0010, t3=4'b0011, t4=4'b0100,
   t5=4'b0101, t6=4'b0110, t7=4'b0111, t9=4'b1111;
   parameter time1=4'd5;
   parameter final_song=2'b10, begin_song=2'b00, mid_song=2'b01;


  always @(*) begin
    case(song_num)
      begin_song: begin
        song_packed={t,t2, t,t3,t, t3,t, t4,t, t4,t, t5,t, t5, 
        t,t2,t, t3, t,t3, t,t4, t,t4,t, t5, t,t5, 
        t,t1,t, t2,t, t2,t, t3,t, t3, t,t4,t, t4,
        t,t5,t, t6,t, t6, t,t5, t,t5,t, t1,t, t1};

        time_continue={time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1};
              end
      mid_song: begin
        song_packed={ t9,t9,t9,t9,t9,t9,
        t,t3,t,t2,t,t1,t,t3,t,t4,t,t4,t,
        t6,t,t7,t,t1,t,t3,t,t5,t,t5,t,t5,
        t,t1,t,t2,t,t5,t,t6,t,t5,t,t5,
        t,t7,t,t1,t,t5,t,t6,t,t5,t,t5//52
};
        time_continue={time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1};

      end
      final_song: begin
        song_packed={t9,
        t,t1,t,t5,t,t1,t,t1,t,t5,t,t1,
        t,t1,t3,t4,t5,t6,t5,
        t,t1,t3,t4,t5,t6,t5, //14
        t,t,t5,t,t4,t,t3,t,t5,t,t4,t,t3, //25
        t,t1,t,t3,t,t2,t,t1,
        t,t1,t,t3,t,t2,t,t1 //16
        };

        time_continue={time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1,
        time1,time1,time1,time1,time1,time1,time1};

      end
  endcase

  end








// song 1 little star:

// song2 happy birthday
//556517 556521 555317 6 443123


// song3 two tigers
//1231 1231 345 345 565431 565431 151 151

//t,t,t,t2, t,t3,t, t3,t, t4,t, t4,t, t5,t, t5, 
 //       t,t,t2,t, t3, t,t3, t,t4, t,t4,t, t5, t,t5, 
 //       t,t,t1,t, t2,t, t2,t, t3,t, t3, t,t4,t, t4,
  //      t,t,t5,t, t6,t, t6, t,t5, t,t5,t, t1,t, t


endmodule