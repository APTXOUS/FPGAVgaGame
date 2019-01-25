`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/02 17:44:30
// Design Name: 
// Module Name: number
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


module seg7(
    input               clk,
    input               rst,
    input         [15:0]      score,
    output  reg [7:0]   seg_out,
    output  reg [3:0]   wei_out

    );
       reg [15:0]score_own;
       reg eat;
        always@(posedge clk)  
        begin
        if(rst)
        begin
              score_own<=0;
              eat<=0;
              end
        else
        begin
              if(score>score_own)
              eat<=1;
              else
              eat<=0;
              end   
        end
    //-------------------------------------------//
        reg [3:0]   seg_data;
        reg [3:0]   num1, num2, num3, num4;
        //-------------------------------------------//
        //step 1
        always@(posedge clk)
        if(rst)
            num1 <= 4'd0;
        else
            if(eat == 1'b1)  begin
                if(num1 == 4'd9)
                    num1 <= 4'd0;
                else
                    num1 <= num1 + 1'b1;
            end
            else
                num1 <= num1;
        //---------------------------------
        //step 2
        always@(posedge clk)
        if(rst)
            num2 <= 4'd0;
        else
            if(num1 == 4'd9 && eat == 1'b1)  begin
                if(num2 == 4'd9)
                    num2 <= 4'd0;
                else
                    num2 <= num2 + 1'b1;
            end
            else
                num2 <= num2;
        //---------------------------------
        //step 3
        always@(posedge clk)
        if(rst)
            num3 <= 4'd0;
        else
            if(num2 == 4'd9 && num1 == 4'd9 && eat == 1'b1)  begin
                if(num3 == 4'd9)
                    num3 <= 4'd0;
                else
                    num3 <= num3 + 1'b1;
            end
            else
                num3 <= num3;
        //---------------------------------
        //step 4
        always@(posedge clk)
        if(rst)
            num4 <= 4'd0;
        else
            if(num3 == 4'd9 && num2 == 4'd9 && num1 == 4'd9 && eat == 1'b1)  begin
                if(num4 == 4'd9)
                    num4 <= 4'd0;
                else
                    num4 <= num4 + 1'b1;
            end
            else
                num4 <= num4;
        //-----------------------------------------//
        //number select
        reg [19:0]   cnt_seg;
        always@(posedge clk)
        if(rst)
            cnt_seg <= 20'd0;
        else
            cnt_seg <= cnt_seg + 1'b1;
        //------------------------------
        always@(cnt_seg[15:14] or num1 or num2 or num3 or num4)
            case (cnt_seg[15:14])
            2'd0 : begin wei_out <= 4'b1110; seg_data <= num1; end
            2'd1 : begin wei_out <= 4'b1101; seg_data <= num2; end
            2'd2 : begin wei_out <= 4'b1011; seg_data <= num3; end
            2'd3 : begin wei_out <= 4'b0111; seg_data <= num4; end
            endcase
        //-----------------------------------------//
        always @(seg_data)
            case (seg_data)
            4'b0001 : seg_out <= 8'b11111001;   // 1
            4'b0010 : seg_out <= 8'b10100100;   // 2
            4'b0011 : seg_out <= 8'b10110000;   // 3
            4'b0100 : seg_out <= 8'b10011001;   // 4
            4'b0101 : seg_out <= 8'b10010010;   // 5
            4'b0110 : seg_out <= 8'b10000010;   // 6
            4'b0111 : seg_out <= 8'b11111000;   // 7
            4'b1000 : seg_out <= 8'b10000000;   // 8
            4'b1001 : seg_out <= 8'b10010000;   // 9
            default : seg_out <= 8'b11000000;   // 0
            endcase

endmodule
