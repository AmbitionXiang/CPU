`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 22:48:09
// Design Name: 
// Module Name: dual_hex
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


module dual_hex(
    input iflag,     //�����������ѡ��
    input [7:0] datain,      //2��BCD��
    output [15:0] dispout     //2���߶ζ�������
    );
    seg_decoder u1(iflag,datain[7:4],dispout[15:8]);
    seg_decoder u2(iflag,datain[3:0],dispout[7:0]);
endmodule