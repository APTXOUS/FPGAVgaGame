`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/03 18:36:22
// Design Name: 
// Module Name: main_control
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


module main_control(
output [3:0] VGA_R,
output [3:0] VGA_G,
output [3:0] VGA_B,
output VGA_HS,
output VGA_VS,
input CLK,
input rst,
input [4:0] action
    );
    
    reg [3:0] blue;
    reg [3:0] red;
    reg [3:0] green;
    
    reg [10:0] XX;
    reg [10:0] YY;    
    reg [4:0] data_in;
    
    wire [10:0] xx;
    wire [10:0] yy;
    
    wire [3:0] BLUE;
    wire [3:0] GREEN;
    wire [3:0] RED; 
    wire [4:0] data_out;
    wire [31:0] score;
    
    always @(BLUE)
        blue=BLUE;
    always @(GREEN)
        green=GREEN;
    always @(RED)
        red=RED;
         
    always @(xx)
        XX=xx;
    always @(yy)
        YY=yy;
   
   always@(data_out)
        data_in=data_out;
         
    pic_control pic(
    XX,
    YY,
    data_in,
    BLUE,
    GREEN,
    RED,
    CLK
        );
        
    MAP_CONTROL map(
    XX,
    YY,
    action[3:0],
    action[4],
    data_out,
    rst,
    score
        );
    vga vga_output(
        VGA_R,
        VGA_G,
        VGA_B,
        VGA_HS,
        VGA_VS,
        CLK,
        red,
        green,
        blue,
        xx,
        yy
            );
endmodule
