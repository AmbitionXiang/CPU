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
    input [15:0] hex,    //16位二进制输入数据，ACC 16位
    output [47:0] dispout,  //6位十进制数的七段段码显示数据
    output reg sign    //符号位
    );
    reg[23:0] dec;
    reg[15:0] tmp;
    always@(hex)
        begin
            if(hex[15]==0)
            begin
                sign = 0;   //正数
                tmp = hex;
            end
            else
            begin
                sign = 1;
                tmp = ~hex;   //取反
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
    dual_hex u1(1'b0,dec[23:16],dispout[47:32]);  //调用2位共阳极七段显示模块
    dual_hex u2(1'b0,dec[15:8],dispout[31:16]);  //调用2位共阳极七段显示模块
    dual_hex u3(1'b0,dec[7:0],dispout[15:0]);  //调用2位共阳极七段显示模块
endmodule
