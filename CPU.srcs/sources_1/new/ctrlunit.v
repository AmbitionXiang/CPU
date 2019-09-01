`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 16:07:46
// Design Name: 
// Module Name: ctrlunit
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


module ctrlunit(
    input clk,
    input rst,
    input [7:0] ir,
    input [7:0] flags,
    output [31:0] ctrlsignals

    );
reg[7:0] car;
reg[31:0] data;
reg we;
always @(posedge clk)
begin
    if(rst)
    begin
        car <= 8'b00000000;
        we <= 0;   //读 
    end
    if (ctrlsignals[0])
        car <= car+1;
    if (ctrlsignals[1])
        case (ir)
            8'b00000001: car<= 8'd8;  //store
            8'b00000010: car<= 8'd3;  //load
            8'b00000011: car<= 8'd12; //add
            8'b00000100: car<= 8'd17; //sub
            8'b00000101: car<= 8'd66; //jmp gez
            8'b00000110: car<= 8'd64; //jmp
            8'b00000111: car<= 8'd71; //hlt
            8'b00001000: car<= 8'd54; //mul
            8'b00001001: car<= 8'd59; //div
            8'b00001010: car<= 8'd22; //and 
            8'b00001011: car<= 8'd27; //or
            8'b00001100: car<= 8'd32; //not
            8'b00001101: car<= 8'd45; //shr
            8'b00001110: car<= 8'd42; //shl
            8'b00001111: car<= 8'd51; //sar
            8'b00010000: car<= 8'd48; //sal
            8'b00010001: car<= 8'd37; //xor
        endcase
    if (ctrlsignals[2])
        car <= 0;
    if (ctrlsignals[27])
    begin
        if(flags[4]==0)
            car <= car+3;
    end 
end
   
dist_mem_gen_1 your_instance_name (
  .a(car),      // input wire [7 : 0] CAR
  .d(data),      // input wire [31 : 0] 解码后要送入的指令
  .clk(clk),  // input wire clk
  .we(we),    // input wire we
  .spo(ctrlsignals)  // output wire [31 : 0] 控制信号
);
endmodule
