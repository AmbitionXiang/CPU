`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 16:07:46
// Design Name: 
// Module Name: register
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


module register(
input clk,
input rst,
input [31:0] ctrlsignals,
input [15:0] memoryin,
input [15:0] acc,
output reg[15:0] memoryout,
output reg[15:0] mbr,
output reg[7:0] ir,
output reg[7:0] mar,
output reg[7:0] pc
    );
always @(posedge clk)
begin
    if(rst)
    begin
        pc <= 0;
        mar <= 0;
    end
    if(ctrlsignals[3])
        mbr <= memoryin;
    if(ctrlsignals[4])
        ir <= memoryin[15:8];
    if(ctrlsignals[5])
        mar <= memoryin[7:0];
    if(ctrlsignals[6])
        pc <= pc + 1;
    if(ctrlsignals[10])
        mar <= pc;
    if(ctrlsignals[12])
        memoryout <= mbr;
    if(ctrlsignals[14])
        mbr <= acc;
    if(ctrlsignals[15])
        pc <= mbr;
    if(ctrlsignals[16])
        mbr <= pc;     
end
endmodule
