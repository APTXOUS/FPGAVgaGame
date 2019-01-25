`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/03 01:33:02
// Design Name: 
// Module Name: main
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


module main(
output [3:0] VGA_R,
output [3:0] VGA_G,
output [3:0] VGA_B,
output VGA_HS,
output VGA_VS,
input CLK,
input rst,
input PS2_CLK, 
input PS2_DAT,
output [6:0] SEG,
output[7:0] AN,
output DP 
    );
    wire oTrig;
    wire [7:0] oData;
    wire [2:0] FLAG;
    
    reg [4:0] action1;
    
    
    Keyfun gg
    (
    CLK,
    PS2_CLK, 
    PS2_DAT,
    oTrig,
    oData,
    FLAG // [2] isShift, [1] isCtrl, [0] isAlt
    );
    
    always@(oData)
    begin
        case(oData)
        8'h1d:begin 
        action1=5'b00001;
        end
        8'h1d:
        begin
        action1=5'b01000;
        end
        8'h1b:
        begin
        action1=5'b00100;
        end
        8'h23:
        begin
        action1=5'b00010;
        end
        8'h29:
        begin
        action1=5'b10000;
        end
        default:
        begin
        action1=5'b00000;
        end
        endcase
    end
    
    wire [31:0]count;
    reg [31:0] score;
        
    always@(count)
        score=count;   
        
    game_main player1(
    VGA_R,
    VGA_G,
    VGA_B,
    VGA_HS,
    VGA_VS,
    CLK,
    {action1[3:0]},
    action1[4],
    rst,
    count
    );

   seg7decimal sss(
	score,
    CLK,
    SEG,
    AN,
    DP 
	 );
	  
    
endmodule
