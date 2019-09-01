`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 22:49:26
// Design Name: 
// Module Name: seg_decoder
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


module seg_decoder(
    input iflag,         //�����������ѡ��
    input [3:0] iA,        //BCD��
    output reg [7:0] oY      //�߶ζ�����ʾ����
    );
    
    always@(iflag,iA)
        begin
            case(iA)           //�������߶����
                4'b0000:oY = 8'h3f;  //0
                4'b0001:oY = 8'h06;  //1
                4'b0010:oY = 8'h5b;  //2
                4'b0011:oY = 8'h4f;  //3
                4'b0100:oY = 8'h66;  //4
                4'b0101:oY = 8'h6d;  //5
                4'b0110:oY = 8'h7d;  //6
                4'b0111:oY = 8'h27;  //7
                4'b1000:oY = 8'h7f;  //8
                4'b1001:oY = 8'h6f;  //9
                default:oY = 8'h00;  //��ʾ
            endcase
            if(!iflag)
                oY = ~oY;    //�������߶����
        end
endmodule
