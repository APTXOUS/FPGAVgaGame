`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/03 01:11:02
// Design Name: 
// Module Name: ps2
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


module Keyfun
(
input CLK,
input PS2_CLK, PS2_DAT,
output oTrig,
output [7:0]oData,
output reg[2:0]FLAG // [2] isShift, [1] isCtrl, [0] isAlt
);

parameter SHIFT = 8'h12, CTRL = 8'h14, ALT = 8'h11, BREAK = 8'hF0;
parameter Func_R= 5'd5;

wire isH2L;
reg [7:0]D1;
  
reg [4:0]i = 0,NextStep;
reg isDone;
/*******************************/ // sub1
reg F2,F1; 

reg [5:0]count = 0;

assign isH2L = ( F2 == 1'b1 && F1 == 1'b0 );

always @ ( posedge CLK)
    { F2, F1 } <= { F1, PS2_CLK };

/*
always @(PS2_CLK)begin
//if(PS2_CLK)TEST = 8'b1111_0000;
    if(!PS2_CLK)count = count + 1;
    if(count == 3) TEST = 8'b1111_0000;
    if(count == 10) TEST = 8'b1100_0000;
    //if(count == 15) TEST = 8'b0000_1111;
//else TEST = 8'b1000_0001;
end*/
/*******************************/ // core     
always @ ( posedge CLK)
case( i ) 
    0: 
        begin i <= Func_R; NextStep <= i + 1'b1; end

    1: 
        if( D1 == SHIFT ) begin FLAG[2] <= 1'b1; D1 <= 8'd0; i <= 5'd0;end
        else if( D1 == CTRL ) begin FLAG[1] <= 1'b1; D1 <= 8'd0; i <= 5'd0; end
        else if( D1 == ALT ) begin FLAG[0] <= 1'b1; D1 <= 8'd0; i <= 5'd0; end
        else if( D1 == BREAK ) begin i <= Func_R; NextStep <= i + 5'd3; end
        else begin i <= i + 1'b1; end
        
    2:
        begin isDone <= 1'b1; i <= i + 1'b1; end

    3:
        begin isDone <= 1'b0; i <= 5'd0; end
  
    4: 
        if( D1 == SHIFT  ) begin FLAG[2] <= 1'b0; D1 <= 8'd0; i <= 5'd0;  end
        else if( D1 == CTRL ) begin FLAG[1] <= 1'b0; D1 <= 8'd0; i <= 5'd0; end
        else if( D1 == ALT ) begin FLAG[0] <= 1'b0; D1 <= 8'd0; i <= 5'd0;  end
        else begin D1 <= 8'd0; i <= 5'd0; end
    /****************/ // ??????¦Á????
    5:  
    begin
        if( isH2L )
        begin
            i <= i + 1'b1; 
        //    TEST = 8'b1111_0000;
        end 
       // else if( !isH2L )
        //    TEST = 8'b0000_1111;
        //else
        //    TEST = 8'b0000_1000;
            
    end
    
    6,7,8,9,10,11,12,13:  
    begin
        if( isH2L ) begin i <= i + 1'b1; D1[ i-6 ] <= PS2_DAT; end  
    end
                     
    14: 
        if( isH2L ) i <= i + 1'b1;
          
    15: 
        if( isH2L ) i <= NextStep;
      
endcase

assign oTrig = isDone;
assign oData = D1;
//assign TEST = oData;

endmodule