`timescale 1ns / 1ps // Define the simulation time units and resolution

module MiniPiano_tb;

    reg clk_tb;
    reg [6:0] keys_tb;
    wire speaker_tb;
    reg [1:0] song_select_tb; // Select song, next or previous
    wire [6:0] Led_tb;
    wire [1:0] select_tb;
    wire [2:0] mode_tb;

    // Clock period definition
    parameter CLK_PERIOD = 10; // 100MHz clock period is 10ns

    // Instantiate the MiniPiano module
    MiniPiano uut(
        .clk(clk_tb),
        .keys(keys_tb),
        .speaker(speaker_tb),
        .song_select(song_select_tb),
        .Led(Led_tb),
    
    );

    // Clock generation
    always #(CLK_PERIOD/2) clk_tb = ~clk_tb;

    // Initial block for simulation
    initial begin
        
        // Initialize inputs
        clk_tb = 0;
        mode_tb = 3'b010;

        $finish;
    end

endmodule
