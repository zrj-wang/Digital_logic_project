module debounce (
    input wire clk,                
    input wire reset,              
    input wire start,               
    input wire [1:0] speed_select,
    input wire [1:0] song_select,    
    output reg debounced_start,      
    output reg [1:0] debounced_song_select,  
    output reg [1:0] debounced_speed_select,
    output reg debounced_reset
);
`include "par.v"


reg [19:0] counter_start = 0;
reg [19:0] counter_song_select_0 = 0;
reg [19:0] counter_song_select_1 = 0;
reg [19:0] counter_speed_select_0 = 0;
reg [19:0] counter_speed_select_1 = 0;
reg [19:0] counter_reset = 0;

always @(posedge clk ) begin

        if (reset == debounced_reset) begin
            counter_reset <= 0;
        end else if (counter_reset == DEBOUNCE_DELAY) begin
            debounced_reset <= reset;
        end else begin
            counter_reset <= counter_reset + 1;
        end 


        if (start == debounced_start) begin
            counter_start <= 0;
        end else if (counter_start == DEBOUNCE_DELAY) begin
            debounced_start <= start;
        end else begin
            counter_start <= counter_start + 1;
        end
        
        if (song_select[0] == debounced_song_select[0]) begin
            counter_song_select_0 <= 0;
        end else if (counter_song_select_0 == DEBOUNCE_DELAY) begin
            debounced_song_select[0] <= song_select[0];
        end else begin
            counter_song_select_0 <= counter_song_select_0 + 1;
        end

       
        if (song_select[1] == debounced_song_select[1]) begin
            counter_song_select_1 <= 0;
        end else if (counter_song_select_1 == DEBOUNCE_DELAY) begin
            debounced_song_select[1] <= song_select[1];
        end else begin
            counter_song_select_1 <= counter_song_select_1 + 1;
        end

   
        if (speed_select[0] == debounced_speed_select[0]) begin
            counter_speed_select_0 <= 0;
        end else if (counter_speed_select_0 == DEBOUNCE_DELAY) begin
            debounced_speed_select[0] <= speed_select[0];
        end else begin
            counter_speed_select_0 <= counter_speed_select_0 + 1;
        end

    
        if (speed_select[1] == debounced_speed_select[1]) begin
            counter_speed_select_1 <= 0;
        end else if (counter_speed_select_1 == DEBOUNCE_DELAY) begin
            debounced_speed_select[1] <= speed_select[1];
        end else begin
            counter_speed_select_1 <= counter_speed_select_1 + 1;
        end
    end


endmodule
