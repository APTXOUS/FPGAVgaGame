`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/03 17:55:36
// Design Name: 
// Module Name: MAP_CONTROL
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

module MAP_CONTROL(
input [10:0] XX,
input [10:0] YY,
input [3:0] action,
input button,
output reg [8:0] data_out,
input rst,
output [31:0] score
    );
    
    
    integer i;//记录这是第几个模块
    reg[31:0]count;
    assign score=count;
    initial
    count = 0;
    reg[8:0] map[767:0];//方格地图数组
    reg [10:0] boat_position;//boat1
    reg [10:0] currentboom;
    reg [10:0] currentpic_boom;
    integer ii;
    wire clk_action;
    
    reg [10:0] currentpic;//boat1
    
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
    
    initial
    begin
    boat_position = 500;
        for (ii = 0; ii <= 767; ii = ii + 1)
        begin
            if (ii % 32 == 0 || ii % 32 == 31 || ii <= 32 || ii >= 767 - 32)
                 map[ii] = island;
            else if (ii % 33 == 11)
                 map[ii] = boatright;
            else
                 map[ii] = sea;
        end
        map[500] = boatright;
    currentpic=boatright;  
    currentboom=0;    
    end
    
     Divid t(
     .I_CLK(CLK),
     .Rst(rst),
     .O_CLK(clk_action)
     );
     

       
   always@(XX or YY)// the ith map
   begin
        data_out=map[(YY-35)/20*32+(XX-144)/20];
   end
  /* 
   always@(posedge clk_action or posedge rst)
   begin
        if(rst!=1)
        begin
        if(currentboom!=0)
        begin
        map[currentboom]=sea;
        case(currentpic_boom)
        boomright:
            case(map[currentboom+1])
            island:
            begin
            currentboom=0;
            end
            boatright:
            begin
            count=count+1;
            map[currentboom+1]=sea;
            currentboom=0;
            end
            default:
            begin
             map[currentboom+1]=currentpic_boom;
            currentboom=currentboom+1;
            end
            endcase
        boomleft:
            case(map[currentboom-1])
            island:
            begin
            currentboom=0;
            end
            boatright:
            begin
            count=count+1;
            map[currentboom-1]=sea;
            currentboom=0;
            end
            default:
            begin
            map[currentboom-1]=currentpic_boom;
            currentboom=currentboom-1;
            end
            endcase
        boomup:
                case(map[currentboom-32])
                island:
                begin
                currentboom=0;
                end
                boatright:
                begin
                count=count+1;
                map[currentboom-32]=sea;
                currentboom=0;
                end
                default:
                begin
                map[currentboom-32]=currentpic_boom;
                currentboom=currentboom-32;
                end
                endcase
        boomdown:
                case(map[currentboom+32])
                island:
                begin
                currentboom=0;
                end
                boatright:
                begin
                count=count+1;
                map[currentboom+32]=sea;
                currentboom=0;
                end
                default:
                begin
                map[currentboom+32]=currentpic_boom;
                currentboom=currentboom+32;
                end
                endcase
        endcase
        end
        else
        begin
        if(button==1)
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
        end
        else
        begin
          boat_position = 500;
              for (ii = 0; ii <= 767; ii = ii + 1)
              begin
                  if (ii % 32 == 0 || ii % 32 == 31 || ii <= 32 || ii >= 767 - 32)
                       map[ii] = island;
                  else if (ii % 33 == 11)
                       map[ii] = boatright;
                  else
                       map[ii] = sea;
              end
              map[500] = boatright;
          currentpic=boatright;  
          currentboom=0;    
        end
   end
    
    */
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
endmodule
