module Buzzer (
    input wire clk, // Clock signal
    input wire [3:0] note, // Note
    output wire speaker, // Buzzer output signal
    input wire [2:0] mode, // Mode signal
    input wire [1:0] octave, // Octave selection: 01 for lower, 10 for higher, else standard
    input wire [1:0] octave_auto
);

reg [31:0] frequency;
wire [31:0] base_frequencies [7:0];
reg [31:0] counter;
reg pwm;

// Base frequencies for notes
assign base_frequencies[1] = 381680; // Frequency for 'do'
assign base_frequencies[2] = 340136; // Frequency for 're'
assign base_frequencies[3] = 303030; // Frequency for 'mi'
assign base_frequencies[4] = 285714; // Frequency for 'fa'
assign base_frequencies[5] = 255102; // Frequency for 'so'
assign base_frequencies[6] = 227273; // Frequency for 'la'
assign base_frequencies[7] = 202429; // Frequency for 'si'

initial begin
    pwm = 0;
    counter = 0;
end

// Adjust frequency based on octave
always @(*) begin
    if (note > 0) begin
        case (mode)
            3'b010: // Auto mode
                case (octave_auto)
                    2'b01: frequency = base_frequencies[note] >> 1; // Lower octave
                    2'b10: frequency = base_frequencies[note] << 1; // Higher octave
                    default: frequency = base_frequencies[note];    // Standard octave
                endcase
            3'b100: // Manual mode
                case (octave)
                    2'b01: frequency = base_frequencies[note] >> 1; // Lower octave
                    2'b10: frequency = base_frequencies[note] << 1; // Higher octave
                    default: frequency = base_frequencies[note];    // Standard octave
                endcase
            default: frequency = base_frequencies[note];            // Standard octave
        endcase
    end else begin
        frequency = 0;
    end
end

// Control the buzzer output based on the adjusted frequency
always @(posedge clk) begin
    if (counter < frequency) begin
        counter <= counter + 1;
    end else begin
        pwm <= ~pwm;
        counter <= 0;
    end
end

assign speaker = pwm; // Output a PWM signal to the buzzer
endmodule
