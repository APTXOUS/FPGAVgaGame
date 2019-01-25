`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/03 17:44:12
// Design Name: 
// Module Name: VGA_CONTROL
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

module Divider(
input I_CLK,
input Rst,
output reg O_CLK
    );
    integer i = 0;
    parameter divide_n = 4;
    initial begin
        O_CLK = 0;
    end
    always@(posedge I_CLK)begin
        if(Rst == 0)begin
            if(i == divide_n-1)begin
                i = 0;
                O_CLK=~O_CLK;
            end
            else begin
                i = i+1;
            end
        end
        else begin
            i = 0;
            O_CLK = 0;
        end
    end
endmodule

module vga(
output reg [3:0] VGA_R,
output reg[3:0] VGA_G,
output reg [3:0] VGA_B,
output VGA_HS,
output VGA_VS,
input CLK,
input [3:0] RED,
input [3:0] GREEN,
input [3:0] BLUE,
output [10:0] xx,
output [10:0] yy
    );
    
    parameter H_pos = 16;//前沿脉冲
    parameter H_neg = 48;//后延脉冲
    parameter H_vri = 640;//有效麦种
    parameter H_syn = 96;//同步脉冲
    
    parameter V_pos = 10;//前沿脉冲
    parameter V_neg = 33;//后延脉冲
    parameter V_vri = 480;//有效麦种
    parameter V_syn = 2;//同步脉冲
    
    
    reg [10:0] x;
    reg [10:0] y;
       initial begin
           x = 0;
           y = 0;
       end
       
       
      assign xx=x;
      assign yy=y;
      wire _CLK;
      Divider #(2)(
      .I_CLK(CLK),
      .Rst(rst),
      .O_CLK(_CLK)
      );
       
       always@(posedge _CLK)begin
           if(x == H_pos + H_neg + H_vri + H_syn)begin
               x = 0;
               if(y == V_pos + V_neg + V_vri + V_syn)begin
                   y = 0;
               end
               else begin
                   y = y + 1;
               end
           end
           else begin
               x = x + 1;
           end
       end
     always @(x or y)begin
              if(x>H_syn+H_neg&&x<H_syn+H_neg+H_vri)
              begin
              VGA_R=RED;
              VGA_G=GREEN;
              VGA_B=BLUE;
              end
              else
              begin
              VGA_R=0;
              VGA_G=0;
              VGA_B=0;
              end
          end
       assign VGA_HS = (x <= H_syn)?1'b1:1'b0;
       assign VGA_VS = (y <= V_syn)?1'b1:1'b0;
endmodule
