// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Mon Jan 01 21:53:11 2018
// Host        : APTXTION running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/youyaoyin/vga_game_cnm/vga_game_cnm.srcs/sources_1/ip/boom_down/boom_down_stub.v
// Design      : boom_down
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module boom_down(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[8:0],dina[23:0],clkb,enb,addrb[8:0],doutb[23:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [8:0]addra;
  input [23:0]dina;
  input clkb;
  input enb;
  input [8:0]addrb;
  output [23:0]doutb;
endmodule
