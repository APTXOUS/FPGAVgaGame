`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/25 18:47:33
// Design Name: 
// Module Name: game_main
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

module Divid(
input I_CLK,
input Rst,
output reg O_CLK
    );
    integer i = 0;
    parameter divide_n = 2300000;
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

module game_main(
output reg [3:0] VGA_R,
output reg[3:0] VGA_G,
output reg [3:0] VGA_B,
output VGA_HS,
output VGA_VS,
input CLK,
input [3:0] action,
input button,
input rst
);
////////////////////////////////////////////////
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

       parameter H_pos = 16;//前沿脉冲
       parameter H_neg = 48;//后延脉冲
       parameter H_vri = 640;//有效麦种
       parameter H_syn = 96;//同步脉冲
       
       parameter V_pos = 10;//前沿脉冲
       parameter V_neg = 33;//后延脉冲
       parameter V_vri = 480;//有效麦种
       parameter V_syn = 2;//同步脉冲
////////////////////////////////////////////////
   integer i;//记录这是第几个模块
   reg [31:0]count;
   initial
   count=0;
   reg [4:0] map [767:0];//方格地图数组
   
   assign score=count;
  // reg rst = 0;
   //控制VGA输出的颜色 
   reg [3:0] RED;
   reg [3:0] GREEN;
   reg [3:0] BLUE;
   reg [10:0] x;
   reg [10:0] y;
   wire [10:0]XX;//x position
   wire [10:0]YY;//y position
   integer boat_position;//boat1
   assign XX=x;
   assign YY=y;
   integer ii;
   wire [23:0] data [10:0];
   reg [8:0] raddr;
   reg reab;
  initial
   begin
     boat_position=500;
   reab=0;
   for(ii=0;ii<=767;ii=ii+1)
    begin
        if(ii%32==0||ii%32==31||ii<=32||ii>=767-32)
            map[ii]=island;
        else if(ii%33==11)
            map[ii]=boatright;
        else
            map[ii]=sea;
    end
   map[500]=boatright;
   end
   
   wire clk_action;
   Divid t(
   .I_CLK(CLK),
   .Rst(rst),
   .O_CLK(clk_action)
   );
   reg [8:0] currentpic;//boat1
   initial
   currentpic=boatright;
   
   integer currentboom;
   integer currentpic_boom;
   initial
   currentboom=0;
   
   
   
   
   always@(posedge clk_action or posedge rst)
   begin
   if(rst!=1)
   begin
       if(button==1&&currentboom==0)
       begin
            case(currentpic)
            boatleft:
            begin
            currentboom=boat_position-1;
            map[currentboom]=boomleft;
            currentpic_boom=boomleft;
            end
            boatright:
            begin
            currentboom=boat_position+1;
            map[currentboom]=boomright;
            currentpic_boom=boomright;
            end
            boatup:
            begin
            currentboom=boat_position-32;
            map[currentboom]=boomup;
            currentpic_boom=boomup;
            end
            boatdown:
            begin
            currentboom=boat_position+32;
            map[currentboom]=boomdown;
            currentpic_boom=boomdown;
            end
            endcase
       end
       else if(currentboom!=0&&(button==1||button==0))
       begin
            map[currentboom]=sea;
            case(currentpic_boom)
            boomdown:
            currentboom=currentboom+32;
            boomup:
             currentboom=currentboom-32;
            boomleft:
             currentboom=currentboom-1;
            boomright:
             currentboom=currentboom+1;
             endcase;
             if(currentboom>=32&&currentboom<767-32&&currentboom%32!=31&&currentboom%32!=0)
                begin
                    if(map[currentboom]==boatright||map[currentboom]==boatleft||map[currentboom]==boatup||map[currentboom]==boatdown)
                    begin
                        count=count+1;
                        map[currentboom]=sea;
                        currentboom=0;
                    end
                    else
                     map[currentboom]=currentpic_boom;
                end
             else
                begin
                currentboom=0;
                end
       end    
       else
            currentboom=currentboom;
       map[boat_position]=sea;
        case(action)
        4'b0000:begin
        boat_position=boat_position;
        currentpic=currentpic;
        end
        4'b0001:
        begin
        if(map[boat_position-32]!=island)
             boat_position=boat_position-32;
        currentpic=boatup;
        end
        4'b0010:
        begin
        if(map[boat_position+1]!=island)
             boat_position=boat_position+1;
        currentpic=boatright;
        end
        4'b0100:
        begin
        if(map[boat_position+32]!=island)
             boat_position=boat_position+32;
        currentpic=boatdown;
        end
        4'b1000:
        begin
        if(map[boat_position-1]!=island)
             boat_position=boat_position-1;
        currentpic=boatleft;
        end
        default:
        begin
        boat_position=boat_position;
        currentpic=currentpic;
        end
        endcase
        map[boat_position]=currentpic;
        end
        else
        begin
        boat_position=500;
         reab=0;
         for(ii=0;ii<=767;ii=ii+1)
          begin
              if(ii%32==0||ii%32==31||ii<=32||ii>=767-32)
                  map[ii]=island;
              else if(ii%33==11)
                  map[ii]=boatright;
              else
                  map[ii]=sea;
          end
         map[500]=boatright;
        currentpic=boatright;
        currentboom=0;
        currentpic_boom=boomright;
        end
   end
   
   
   always@(XX or YY)// the ith map
   begin
        i=(YY-35)/20*32+(XX-144)/20;
   end
   
   always @(XX or YY)//control the colors
   begin
    if((XX>144)&&(YY>35)&&(XX<784)&&(YY<515))
        begin
        reab=1;
        raddr=(YY-35)%20*20+(XX-144)%20;
        BLUE=data[map[i]][7:4];
        GREEN=data[map[i]][15:12];
        RED=data[map[i]][23:20];
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
                                      
        initial begin
          x = 0;
          y = 0;
      end
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
