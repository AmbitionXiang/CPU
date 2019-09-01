`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 22:23:50
// Design Name: 
// Module Name: counter_sync_r
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


module counter_sync_r(  //具有复位端口的同步计数器
    input CP,
    input R,
    output reg [2:0] Q,
    output reg C0
    );
    always@(posedge CP)
        if(R)
            begin
                Q<=0;
                C0<=0;
            end
        else
            begin
                if(&Q==1)
                    C0<=1;
                else
                    C0<=0;
                Q<=Q+1'b1;
            end 
endmodule
