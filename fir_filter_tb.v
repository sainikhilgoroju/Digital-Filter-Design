`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2025 06:41:05
// Design Name: 
// Module Name: fir_filter_tb
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


`timescale 1ns/1ps

module fir_filter_tb;

    reg clk;
    reg reset;
    reg signed [15:0] x_in;
    wire signed [31:0] y_out;

    parameter CLK_PERIOD = 10;

    fir_filter uut (
        .clk(clk),
        .reset(reset),
        .x_in(x_in),
        .y_out(y_out)
    );

    integer i;
    reg signed [15:0] test_data [0:19];

    initial begin
        // Example input data
        test_data[0] = 1;  test_data[1] = 2;  test_data[2] = 3;  test_data[3] = 4;
        test_data[4] = 5;  test_data[5] = 6;  test_data[6] = 5;  test_data[7] = 4;
        test_data[8] = 3;  test_data[9] = 2;  test_data[10] = 1; test_data[11] = 0;
        test_data[12] = -1; test_data[13] = -2; test_data[14] = -3; test_data[15] = -4;
        test_data[16] = -5; test_data[17] = -6; test_data[18] = -5; test_data[19] = -4;
    end

    // Clock generation
    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    initial begin
        $display("Starting FIR Filter Testbench");
        reset = 1;
        x_in = 0;
        #(2*CLK_PERIOD);
        reset = 0;

        for (i = 0; i < 20; i = i + 1) begin
            x_in = test_data[i];
            #(CLK_PERIOD);
        end

        #(10*CLK_PERIOD);
        $finish;
    end

endmodule
