`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2025 06:38:29
// Design Name: 
// Module Name: fir_filter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module fir_filter #(
    parameter N = 8 // Number of Taps
)(
    input wire clk,
    input wire reset,
    input wire signed [15:0] x_in,
    output reg signed [31:0] y_out
);

    // Coefficients (Symmetric example)
    reg signed [15:0] coeffs [0:N-1];
    initial begin
        coeffs[0] = 16'sd2;
        coeffs[1] = 16'sd3;
        coeffs[2] = 16'sd5;
        coeffs[3] = 16'sd7;
        coeffs[4] = 16'sd7;
        coeffs[5] = 16'sd5;
        coeffs[6] = 16'sd3;
        coeffs[7] = 16'sd2;
    end

    reg signed [15:0] shift_reg [0:N-1];

    integer i;

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < N; i = i + 1) begin
                shift_reg[i] <= 16'sd0;
            end
            y_out <= 32'sd0;
        end else begin
            // Shift register
            for (i = N-1; i > 0; i = i - 1) begin
                shift_reg[i] <= shift_reg[i-1];
            end
            shift_reg[0] <= x_in;

            // Multiply and accumulate
            y_out <= 32'sd0;
            for (i = 0; i < N; i = i + 1) begin
                y_out <= y_out + shift_reg[i] * coeffs[i];
            end
        end
    end
endmodule

