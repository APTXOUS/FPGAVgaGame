`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/03 17:35:13
// Design Name: 
// Module Name: pic_control
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


module pic_control(
input [10:0] XX,
input [10:0] YY,
input [8:0] data_in,
output reg [3:0] BLUE,
output reg [3:0] GREEN,
output reg [3:0] RED,
input CLK
    );
    parameter sea=8'd0;
    parameter island=8'd1;
    parameter boatup=8'd2;
    parameter boatdown=8'd3;
    parameter boatleft=8'd4;
    parameter boatright=8'd5;
    parameter boomright=8'd6;
    parameter boomleft=8'd7;
    parameter boomup=8'd8; 
    parameter boomdown=8'd9;
    wire [23:0] data [10:0];
    reg [8:0] raddr;
    reg reab;
    
    always @(XX or YY)//control the colors
    begin
    if ((XX>144) && (YY>35) && (XX<784) && (YY<515))
        begin
        reab = 1;
    raddr = (YY - 35) % 20 * 20 + (XX - 144) % 20;
    BLUE = data[data_in][7:4];
    GREEN = data[data_in][15:12];
    RED = data[data_in][23:20];
    end
    end
    
    
    
    blk_mem_gen_0 sea_pic(
        .clka(CLK),    // input wire clka
        .ena(0),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(raddr),  // input wire [8 : 0] addra
        .dina(data[0]),    // input wire [23 : 0] dina
        .clkb(CLK),    // input wire clkb
        .enb(1),      // input wire enb
        .addrb(raddr),  // input wire [8 : 0] addrb
        .doutb(data[sea])  // output wire [23 : 0] doutb
    );
    
    rock_pic rock(
        .clka(CLK),    // input wire clka
        .ena(0),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(raddr),  // input wire [8 : 0] addra
        .dina(data[0]),    // input wire [23 : 0] dina
        .clkb(CLK),    // input wire clkb
        .enb(1),      // input wire enb
        .addrb(raddr),  // input wire [8 : 0] addrb
        .doutb(data[island])  // output wire [23 : 0] doutb
    );
    
    boat_right boat_r(
        .clka(CLK),    // input wire clka
        .ena(0),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(raddr),  // input wire [8 : 0] addra
        .dina(data[0]),    // input wire [23 : 0] dina
        .clkb(CLK),    // input wire clkb
        .enb(1),      // input wire enb
        .addrb(raddr),  // input wire [8 : 0] addrb
        .doutb(data[boatright])  // output wire [23 : 0] doutb
    );
    
    boat_up boat_u(
        .clka(CLK),    // input wire clka
        .ena(0),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(raddr),  // input wire [8 : 0] addra
        .dina(data[0]),    // input wire [23 : 0] dina
        .clkb(CLK),    // input wire clkb
        .enb(1),      // input wire enb
        .addrb(raddr),  // input wire [8 : 0] addrb
        .doutb(data[boatup])  // output wire [23 : 0] doutb
    );
    boat_down boat_d(
        .clka(CLK),    // input wire clka
        .ena(0),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(raddr),  // input wire [8 : 0] addra
        .dina(data[0]),    // input wire [23 : 0] dina
        .clkb(CLK),    // input wire clkb
        .enb(1),      // input wire enb
        .addrb(raddr),  // input wire [8 : 0] addrb
        .doutb(data[boatdown])  // output wire [23 : 0] doutb
    );
    boat_left boat_l(
        .clka(CLK),    // input wire clka
        .ena(0),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(raddr),  // input wire [8 : 0] addra
        .dina(data[0]),    // input wire [23 : 0] dina
        .clkb(CLK),    // input wire clkb
        .enb(1),      // input wire enb
        .addrb(raddr),  // input wire [8 : 0] addrb
        .doutb(data[boatleft])  // output wire [23 : 0] doutb
    );
    boom_down boom_d(
        .clka(CLK),    // input wire clka
        .ena(0),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(raddr),  // input wire [8 : 0] addra
        .dina(data[0]),    // input wire [23 : 0] dina
        .clkb(CLK),    // input wire clkb
        .enb(1),      // input wire enb
        .addrb(raddr),  // input wire [8 : 0] addrb
        .doutb(data[boomdown])  // output wire [23 : 0] doutb
    );
    
    boom_up boom_u(
        .clka(CLK),    // input wire clka
        .ena(0),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(raddr),  // input wire [8 : 0] addra
        .dina(data[0]),    // input wire [23 : 0] dina
        .clkb(CLK),    // input wire clkb
        .enb(1),      // input wire enb
        .addrb(raddr),  // input wire [8 : 0] addrb
        .doutb(data[boomup])  // output wire [23 : 0] doutb
    );
    
    boom_left boom_l(
        .clka(CLK),    // input wire clka
        .ena(0),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(raddr),  // input wire [8 : 0] addra
        .dina(data[0]),    // input wire [23 : 0] dina
        .clkb(CLK),    // input wire clkb
        .enb(1),      // input wire enb
        .addrb(raddr),  // input wire [8 : 0] addrb
        .doutb(data[boomleft])  // output wire [23 : 0] doutb
    );
    boom_right boom_r(
        .clka(CLK),    // input wire clka
        .ena(0),      // input wire ena
        .wea(0),      // input wire [0 : 0] wea
        .addra(raddr),  // input wire [8 : 0] addra
        .dina(data[0]),    // input wire [23 : 0] dina
        .clkb(CLK),    // input wire clkb
        .enb(1),      // input wire enb
        .addrb(raddr),  // input wire [8 : 0] addrb
        .doutb(data[boomright])  // output wire [23 : 0] doutb
    );
endmodule
