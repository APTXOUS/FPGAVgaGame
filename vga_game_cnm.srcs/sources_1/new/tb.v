`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/01 16:49:33
// Design Name: 
// Module Name: tb
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


module tb(
    );
    wire [3:0] VGA_R;
    wire [3:0] VGA_G;
    wire [3:0] VGA_B;
    wire VGA_HS;
    wire VGA_VS;
    reg CLK;
    reg [3:0]action1;
    reg [3:0]action2;
    reg rst;
    game_main TEST(VGA_R,VGA_G,VGA_B,VGA_HS,VGA_VS,CLK);//,action1,action2,rst);
    initial
    CLK=1;
    
    always #0.001 CLK<=~CLK;
endmodule