module sim();
    reg clk_tb;
    reg [6:0] keys_tb;
    wire speaker_tb;
    wire [6:0] Led_tb;
    wire [1:0] select_tb;
    reg [2:0] mode_tb;
    wire [3:0] note_tb;


    // Instantiate the MiniPiano module
    MiniPiano uut(
        .clk(clk_tb),
        .led(Led_tb),
        .mode(mode_tb)
    );


    initial begin 
        mode_tb = 3'b010;
        clk_tb = 1'b0;
        forever #4 clk_tb = ~clk_tb;
#705032704 $finish;        
    end


endmodule
