module mode_free(
 input wire clk,
 input wire reset,
   input wire write_on,
    input wire storeRecord,
    input wire [6:0] keys,
   input wire [1:0] octave,
   input wire [3:0]selectSong,
   output reg [6:0] led_out1,
   output reg [6:0] led_out2,
   output reg[3:0] note_to_play1,
   output reg [1:0]octave_out1,
    output reg[3:0] note_to_play2,
   output reg [1:0]octave_out2
    );
reg write=0;
reg prev_signal_state; // reg to store pre state

always @(posedge clk) begin
    prev_signal_state <= write_on; // assign the value
end

always @(posedge clk) begin
    if (prev_signal_state && !write_on) begin
        write <= 1'b1; // test negedge
    end else begin
        write <= 1'b0; // else write equals 
    end
end


    reg playState1=0;
   reg [1:0]write_current_song = 2'b00; // Used to select the currently written song
   reg[1:0] play_current_song = 2'b00; // Used to select the currently written song
//Use RAM to store song information: ram1 represents note information ram2 represents led information and ram3 represents octave information
   reg [Note_WIDTH-1:0] ram1[2:0] [255];
    reg [6:0] ram2[2:0] [255:0];//store led information
   reg [Octave_WIDTH-1:0] ram3 [2:0][255:0];
   reg [ADDR_WIDTH-1:0] addr_write=0;
     
     //create a slow clock
    reg [31:0] counter = 0;  
    reg slow_clk = 0;    
    always @(posedge clk) begin
        if (counter == 5000000-1) begin
            slow_clk <= ~slow_clk;
            counter <= 0;
        end
        else begin
         counter <= counter + 1;
        end
    end

  //select the song to play   
always@(*)begin
case(selectSong)
4'b0100:begin play_current_song=2'b00;playState1=1;end
4'b0101:begin play_current_song=2'b01;playState1=1;end
4'b0110:begin play_current_song=2'b10;playState1=1;end
default:playState1=0;
endcase
end


   
//Use a clock to determine whether the current song is stored
     reg [31:0] counter1 = 0;  
     reg store_clk = 0;
   
     always @(posedge clk) begin
         if (counter1 == DIVIDE_VALUE1-1) begin
             store_clk <= ~store_clk;
             counter1 <= 0;
         end
         else begin
          counter1 <= counter1 + 1;
         end
     end
     
     reg delete=0;
//If the key is pressed for more than two seconds, the recording is stored. If the key is pressed for less than two seconds, the recording is not stored
reg [3:0] press_timer; //4-bit timer for timing when the key is pressed
always @(posedge store_clk) begin
    if (storeRecord) begin
        // If the button is pressed, increment the timer
        if (press_timer < 4'b1110) begin
            press_timer <= press_timer + 1;
        end
    end 
    else begin
        // Reset the timer if the button is not pressed
        press_timer <= 4'b0000;
    end

    // Check if the timer is longer than two seconds, if so, set delete to 1, otherwise set to 0
    if (press_timer >= 4'b1010) begin
        delete <= 1;
    end 
    else begin
        delete <= 0;
    end
end

//Change the switch value to node
reg [3:0]note;
always@(posedge slow_clk)begin
//写入RAM
if(write_on)begin
    case(keys)
    7'b0000001:begin   ram1[write_current_song][addr_write]<=t1;ram2[write_current_song][addr_write]<=led1; ram3[write_current_song][addr_write]<=octave;  end
    7'b0000010:begin   ram1[write_current_song][addr_write]<=t2;ram2[write_current_song][addr_write]<=led2; ram3[write_current_song][addr_write]<=octave;   end
    7'b0000100:begin   ram1[write_current_song][addr_write]<=t3;ram2[write_current_song][addr_write]<=led3; ram3[write_current_song][addr_write]<=octave;  end
    7'b0001000:begin   ram1[write_current_song][addr_write]<=t4;ram2[write_current_song][addr_write]<=led4; ram3[write_current_song][addr_write]<=octave;  end
    7'b0010000:begin   ram1[write_current_song][addr_write]<=t5;ram2[write_current_song][addr_write]<=led5; ram3[write_current_song][addr_write]<=octave;  end
    7'b0100000:begin   ram1[write_current_song][addr_write]<=t6;ram2[write_current_song][addr_write]<=led6; ram3[write_current_song][addr_write]<=octave;   end
    7'b1000000:begin   ram1[write_current_song][addr_write]<=t7;ram2[write_current_song][addr_write]<=led7; ram3[write_current_song][addr_write]<=octave;   end
   default begin
    ram1[write_current_song][addr_write]<=t;
     ram2[write_current_song][addr_write]<=led8;
    ram3[write_current_song][addr_write]<=octave;
   addr_write<=addr_write+1;
    end
endcase
if(delete==0) begin
addr_write<=addr_write+1;
end
else begin 
addr_write<=0; 
end 
end
end


   //Close the record button and prepare to write the next song
     always@(negedge write)begin
     write_current_song <= (write_current_song + 1) % 3; // Write to the next song
     end


//direct output
always@(posedge clk)begin
  case(keys)
  7'b0000001:begin note<=t1; led_out1<=led1; end
  7'b0000010:begin note<=t2; led_out1<=led2; end
  7'b0000100:begin note<=t3; led_out1<=led3; end
  7'b0001000:begin note<=t4; led_out1<=led4; end
  7'b0010000:begin note<=t5; led_out1<=led5; end
  7'b0100000:begin note<=t6; led_out1<=led6; end
  7'b1000000:begin note<=t7; led_out1<=led7; end
 default begin
  note=t;
  led_out1<=led8;
  end
endcase
if(delete==1) led_out1<=led_for_delete;//Determine whether to play the recording
 note_to_play1<=note;
octave_out1<=octave;
end


reg [ADDR_WIDTH-1:0] addr_read;

//Determine whether to play the recording
always@(posedge slow_clk)begin
if(!reset) begin 
addr_read<=0;
end 
else 
begin  
if(playState1) begin
     addr_read<=(addr_read+1) % 200;
    note_to_play2<=ram1[play_current_song][addr_read];
     led_out2<=ram2[play_current_song][addr_read];
    octave_out2<=ram3[play_current_song][addr_read];
end
else begin 
 note_to_play2<=4'b0000;
  octave_out2<=2'b00;
 
end
end 
end
endmodule

// module mode_free(
//  input wire clk,
//  input wire reset,
//    input wire write_on,
//     input wire storeRecord,
//     input wire [6:0] keys,
//     input wire [1:0]song_select,
//    input wire [1:0] octave,
//    input wire [3:0]selectSong,
//    output reg [6:0] led_out,
//    output reg[3:0] note_to_play1,
//    output reg [1:0]octave_out1,
//     output reg[3:0] note_to_play2,
//    output reg [1:0]octave_out2
//     );
    
   

    
//     reg playState1=0;
//    reg [1:0]write_current_song = 0; 
//    reg[1:0] play_current_song = 0; 
//    reg [1:0] data_out_octave;

//    reg [Note_WIDTH-1:0] ram1[1:0] [RAM_DEPTH-1:0];
//    reg [Octave_WIDTH-1:0] ram3 [1:0][RAM_DEPTH-1:0];
//    reg [ADDR_WIDTH-1:0] addr_write=0;
     

  
//     reg [31:0] counter = 0;  
//     reg slow_clk = 0;    
//     always @(posedge clk) begin
//         if (counter == DIVIDE_VALUE-1) begin
//             slow_clk <= ~slow_clk;
//             counter <= 0;
//         end
//         else begin
//          counter <= counter + 1;
//         end
//     end
     

// always@(*)begin
// case(selectSong)
// 4'b0100:begin play_current_song=0;playState1=1;end
// 4'b0101:begin play_current_song=1;playState1=1;end
// 4'b0110:begin play_current_song=2;playState1=1;end
// default:playState1=0;
// endcase
// end


//      always@(negedge write_on)begin
//      write_current_song <= (write_current_song + 1) % 3; 
//      end
   

//      reg [31:0] counter1 = 0;  /
//      reg store_clk = 0;
//      parameter DIVIDE_VALUE1=1000000;//��������ʱ�ӵ�Ƶ��Ϊclk��һ�����֮һ��Ҳ����1��һ��������
//      always @(posedge clk) begin
//          if (counter1 == DIVIDE_VALUE1-1) begin
//              store_clk <= ~store_clk;
//              counter1 <= 0;
//          end
//          else begin
//           counter1 <= counter1 + 1;
//          end
//      end
     
//      reg delete=0;
// //��������������룬�洢¼��,���û�����룬���洢��¼��
// reg [3:0] press_timer; // 4λ��ʱ�������ڼ�ʱ�������µ�ʱ��
// always @(posedge store_clk) begin
//     if (storeRecord) begin
//         // �����ť���£�������ʱ��
//         if (press_timer < 4'b1110) begin
//             press_timer <= press_timer + 1;
//         end
//     end 
//     else begin
//         // �����ťδ���£����ü�ʱ��
//         press_timer <= 4'b0000;
//     end

//     // ����ʱ���Ƿ񳬹����룬����ǣ������� delete Ϊ1����������Ϊ0
//     if (press_timer >= 4'b1010) begin
//         delete <= 1;
//         addr_write<=0;
//     end 
//     else begin
//         delete <= 0;
//     end
// end

// //������ֵ��Ϊnode
// reg [3:0]note;
// always@(posedge slow_clk)begin
// //д��RAM
// if(write_on)begin
//     case(keys)
//     7'b0000001:begin note<=4'b0001; led_out<=led1; ram1[write_current_song][addr_write]<=note; ram3[write_current_song][addr_write]<=octave; addr_write<=addr_write+1; end
//     7'b0000010:begin note<=4'b0010; led_out<=led2; ram1[write_current_song][addr_write]<=note; ram3[write_current_song][addr_write]<=octave;  addr_write<=addr_write+1; end
//     7'b0000100:begin note<=4'b0011; led_out<=led3; ram1[write_current_song][addr_write]<=note; ram3[write_current_song][addr_write]<=octave; addr_write<=addr_write+1; end
//     7'b0001000:begin note<=4'b0100; led_out<=led4; ram1[write_current_song][addr_write]<=note; ram3[write_current_song][addr_write]<=octave;  addr_write<=addr_write+1;end
//     7'b0010000:begin note<=4'b0101; led_out<=led5; ram1[write_current_song][addr_write]<=note; ram3[write_current_song][addr_write]<=octave;  addr_write<=addr_write+1; end
//     7'b0100000:begin note<=4'b0110; led_out<=led6; ram1[write_current_song][addr_write]<=note; ram3[write_current_song][addr_write]<=octave;  addr_write<=addr_write+1; end
//     7'b1000000:begin note<=4'b0111; led_out<=led7; ram1[write_current_song][addr_write]<=note; ram3[write_current_song][addr_write]<=octave;  addr_write<=addr_write+1; end
//    default begin
//     note<=4'b0000;
//     led_out<=led8;
//     ram1[write_current_song][addr_write]<=note;
//     ram3[write_current_song][addr_write]<=octave;
//    addr_write<=addr_write+1;
//     end
// endcase
// end

// else begin
//   case(keys)
//     7'b0000001:begin note<=4'b0001; led_out<=led1; end
//     7'b0000010:begin note<=4'b0010; led_out<=led2; end
//     7'b0000100:begin note<=4'b0011; led_out<=led3; end
//     7'b0001000:begin note<=4'b0100; led_out<=led4; end
//     7'b0010000:begin note<=4'b0101; led_out<=led5; end
//     7'b0100000:begin note<=4'b0110; led_out<=led6; end
//     7'b1000000:begin note<=4'b0111; led_out<=led7; end
//    default begin
//     note=4'b0000;
//     led_out<=led8;
//     end
// endcase
// if(delete==1)
// led_out<=led_for_delete;//����ָʾ������ǰ�洢
// end

// end



// //ֱ�����
// always@(posedge clk)begin
//  note_to_play1<=note;
// octave_out1<=octave;
// end


// reg [ADDR_WIDTH-1:0] addr_read;

// //����¼��
// always@(posedge slow_clk)begin
// if(!reset) begin 
// addr_read<=0;
// end 
// else 
// begin  
// if(playState1) begin
//      addr_read<=addr_read+1;
//     note_to_play2<=ram1[play_current_song][addr_read];
//     octave_out2<=ram3[play_current_song][addr_read];
// end
// else begin 
//  note_to_play2<=4'b0000;
//   octave_out2<=2'b00;
// end
// end 
// end
// endmodule