`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 19:17:56
// Design Name: 
// Module Name: main
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


module main(
input clk,
input rst,
output reg seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0,   //8�������
output reg segA,segB,segC,segD,segE,segF,segG,segP  //ÿ��������е�8��
    );
wire[15:0] acc;
wire clk_1000Hz, clk_10Hz;
wire[15:0] mbr;
wire[31:0] ctrlsignals;
wire[7:0] flags;
wire[7:0] ir;
wire[15:0] memoryin;
wire[15:0] memoryout;
wire[7:0] mar;
reg we;
wire[7:0] pc;
wire [2:0] q;  //ģ8��������� 
wire co;       //ģ8����������������
wire [47:0] display;
wire sign;

always @(posedge clk_10Hz)
begin
    if(rst)
        we <= 0; //1д0��
    if(ctrlsignals[12])
        we <= 1;
    else 
        we <= 0; 
end
always @(posedge clk_1000Hz)
begin
    case(q)
        3'd7:begin
            if(sign==0) //����
                {segP,segG,segF,segE,segD,segC,segB,segA} <= 8'b11111111;
            else
                {segP,segG,segF,segE,segD,segC,segB,segA} <= 8'b10111111;
            {seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0} <= 8'b01111111;
        end
        3'd5:begin
            {segP,segG,segF,segE,segD,segC,segB,segA} <= display[47:40];
            {seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0} <= 8'b11011111;
        end
        3'd4:begin
            {segP,segG,segF,segE,segD,segC,segB,segA} <= display[39:32];
            {seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0} <= 8'b11101111;
        end
        3'd3:begin
            {segP,segG,segF,segE,segD,segC,segB,segA} <= display[31:24];
            {seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0} <= 8'b11110111;
        end
        3'd2:begin
            {segP,segG,segF,segE,segD,segC,segB,segA} <= display[23:16];
            {seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0} <= 8'b11111011;
        end
        3'd1:begin
            {segP,segG,segF,segE,segD,segC,segB,segA} <= display[15:8];
            {seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0} <= 8'b11111101;
        end
        3'd0:begin
            {segP,segG,segF,segE,segD,segC,segB,segA} <= display[7:0];
            {seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0} <= 8'b11111110;
        end
    endcase
end
dist_mem_gen_0 memory(
  .a(mar),      // input wire [7 : 0] a
  .d(memoryout),      // input wire [15 : 0] d
  .clk(clk_10Hz),  // input wire clk
  .we(we),    // input wire we
  .spo(memoryin)  // output wire [15 : 0] spo
);

int_div #(100000,32) nclk1000(clk,clk_1000Hz);  //����ܶ�̬��ʾʱ��
int_div #(10000000,32) nclk1(clk,clk_10Hz);  //ָ��ʱ��
//int_div #(1,32) nclk1000(clk,clk_1000Hz);  //����ܶ�̬��ʾʱ��
//int_div #(10,32) nclk1(clk,clk_10Hz);  //ָ��ʱ��
counter_sync_r c(clk_1000Hz,rst,q,co);        //ģ8������ 
disp_dec dis(acc,display,sign);
alu alu1(clk_10Hz, rst, mbr, ctrlsignals, flags, acc); 
ctrlunit ctrlunit1(clk_10Hz, rst, ir, flags, ctrlsignals);
register register1(clk_10Hz, rst, ctrlsignals, memoryin, acc, memoryout, mbr, ir, mar, pc); 

endmodule
