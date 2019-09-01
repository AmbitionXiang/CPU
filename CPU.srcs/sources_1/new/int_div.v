`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 22:24:51
// Design Name: 
// Module Name: int_div
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


module int_div(                   //ʱ�ӷ�Ƶ
    input clk_in,
    output clk_out
    );
    parameter F_DIV = 100000000;  //��Ƶϵ�� 100M
    parameter F_DIV_WIDTH = 32;   //��Ƶ���������
    
    reg clk_p_r;
    reg clk_n_r;
    reg[F_DIV_WIDTH-1:0] count_p;
    reg[F_DIV_WIDTH-1:0] count_n;
    
    wire full_div_p; //�����ؼ�������־
    wire half_div_p; //�����ؼ���������־
    wire full_div_n; //�½��ؼ�������־
    wire half_div_n; //�½��ؼ���������־
    //�жϼ�����־λ��λ���
    assign full_div_p = (count_p < F_DIV-1);
    assign half_div_p = (count_p < (F_DIV>>1)-1);
    assign full_div_n = (count_n < F_DIV-1);
    assign half_div_n = (count_n < (F_DIV>>1)-1);
    //ʱ���������Ƶϵ��Ϊ1ֱ�ӷ��أ��������ż����
    assign clk_out = (F_DIV == 1)? clk_in:(F_DIV[0]?(clk_p_r & clk_n_r):clk_p_r);
    always@(posedge clk_in)     //�������������
        begin
            if(full_div_p)
                begin
                    count_p <= count_p + 1'b1;
                    if(half_div_p)
                        clk_p_r <= 1'b0;  //С��50%Ϊ�͵�ƽ
                    else
                        clk_p_r <= 1'b1;  //����50%Ϊ�ߵ�ƽ
                end
            else
                begin
                    count_p <= 0;
                    clk_p_r <= 1'b0;
                end
        end
    always@(posedge clk_in)
        begin
            if(full_div_n)
                begin
                    count_n <= count_n + 1'b1;
                    if(half_div_n)
                        clk_n_r <= 1'b0;
                    else
                        clk_n_r <= 1'b1;
                end
            else
                begin
                    count_n <= 0;
                    clk_n_r <= 1'b0;
                end
        end
endmodule
