`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 22:47:31
// Design Name: 
// Module Name: disp_dec
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


module disp_dec(
    input [15:0] hex,    //16λ�������������ݣ�ACC 16λ
    output [47:0] dispout,  //6λʮ���������߶ζ�����ʾ����
    output reg sign    //����λ
    );
    reg[23:0] dec;
    reg[15:0] tmp;
    always@(hex)
        begin
            if(hex[15]==0)
            begin
                sign = 0;   //����
                tmp = hex;
            end
            else
            begin
                sign = 1;
                tmp = ~hex;   //ȡ��
                tmp = tmp + 1; //+1
            end
            
            dec[3:0] = tmp%4'd10;
            tmp = tmp/4'd10;
            dec[7:4] = tmp%4'd10;
            tmp = tmp/4'd10;
            dec[11:8] = tmp%4'd10;
            tmp = tmp/4'd10;
            dec[15:12] = tmp%4'd10;
            tmp = tmp/4'd10;
            dec[19:16] = tmp%4'd10;
            tmp = tmp/4'd10;
            dec[23:20] = tmp%4'd10;          
        end
    dual_hex u1(1'b0,dec[23:16],dispout[47:32]);  //����2λ�������߶���ʾģ��
    dual_hex u2(1'b0,dec[15:8],dispout[31:16]);  //����2λ�������߶���ʾģ��
    dual_hex u3(1'b0,dec[7:0],dispout[15:0]);  //����2λ�������߶���ʾģ��
endmodule
