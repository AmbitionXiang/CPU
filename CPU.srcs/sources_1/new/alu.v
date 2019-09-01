`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 16:07:46
// Design Name: 
// Module Name: alu
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


module alu(
input clk,
input rst,
input [15:0] mbr,
input [31:0] ctrlsignals,
output reg[7:0] flags,
output reg[15:0] acc
    );
reg[15:0] br;
reg[15:0] tmp;
reg sign;
always @(posedge clk)
begin
    if(rst)
    begin
        flags = 8'b00000000;
    end
    if(ctrlsignals[7])
        br <= mbr;
    if(ctrlsignals[8])
        acc <= 0;
    if(ctrlsignals[9])
        acc <= acc + br;
    if(ctrlsignals[11])
    begin
        br = ~br;  //取反
        br = br + 1;  //加一
        acc <= acc + br;
    end
    if(ctrlsignals[17])
        acc <= acc & br;
    if(ctrlsignals[18])
        acc <= acc | br;
    if(ctrlsignals[19])
        acc <= ~br;
    if(ctrlsignals[20])
        acc <= acc ^ br;
    if(ctrlsignals[21]||ctrlsignals[23])
    begin
        acc[15:1] <= acc[14:0];
        acc[0]    <= 0; 
    end
    if(ctrlsignals[22])
    begin
        acc[14:0] <= acc[15:1];
        acc[15] <= 0;
    end
    if(ctrlsignals[24])
    begin
        acc[14:0]<=acc[15:1];
    end
    if(ctrlsignals[25])   //假设输入的br小于8位
    begin
        if(acc[15]==0)
        begin
            tmp = acc;
            sign = 0;
        end
        else
        begin
            tmp = ~acc;
            tmp = tmp + 1;
            sign = 1;
        end
        acc = 0;
        if(br[7])
            acc = acc + (tmp<<7); 
        if(br[6])
            acc = acc + (tmp<<6); 
        if(br[5])
            acc = acc + (tmp<<5); 
        if(br[4])
            acc = acc + (tmp<<4); 
        if(br[3])
            acc = acc + (tmp<<3); 
        if(br[2])
            acc = acc + (tmp<<2);   
        if(br[1])
            acc = acc + (tmp<<1); 
        if(br[0])
            acc = acc + (tmp<<0);
        if(sign==1)
        begin
            acc = ~acc;
            acc = acc + 1;
        end
    end
    if(acc[15])  //负数
        flags[4] = 1;
    else
        flags[4] = 0;
end
endmodule
