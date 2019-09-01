`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 20:10:26
// Design Name: 
// Module Name: testbench
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


module testbench();
reg clk;
reg rst;
wire[15:0] acc;

wire[15:0] mbr;
wire[31:0] ctrlsignals;
wire[7:0] flags;
wire[7:0] ir;
wire[15:0] memoryin;
wire[15:0] memoryout;
wire[7:0] mar;
wire we;
wire[7:0] pc;
initial
begin
    clk = 0;
    forever
    #1 clk = ~clk;
end
initial
begin
    rst = 1;
    #2 rst = 0;
end

main process1(clk,rst,acc,
mbr,ctrlsignals,flags,ir,memoryin,memoryout,mar,we,pc);
endmodule
