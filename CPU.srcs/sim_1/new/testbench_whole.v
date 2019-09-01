`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 00:17:41
// Design Name: 
// Module Name: testbench_whole
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


module testbench_whole();
reg clk;
reg rst;
wire[15:0] acc;
wire seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0;   //8个数码管
wire segA,segB,segC,segD,segE,segF,segG,segP;  //每个数码管中的8段
wire clk_1000Hz, clk_10Hz;
initial
begin
    clk = 0;
    forever
    #1 clk = ~clk;
end
initial
begin
    rst = 1;
    #20 rst = 0;
end

main process2(clk,rst,
seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0,segA,segB,segC,segD,segE,segF,segG,segP,acc);
endmodule
