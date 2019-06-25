`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2014 05:00:31 AM
// Design Name: 
// Module Name: rp
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


module rp(
    input [31:0] ain,
    input [31:0] bin,
    input Clk,
    input Reset_n,
    output [31:0] result
    );
reg [31:0] result;

always @(posedge Clk)
	if(Reset_n==1'b0)
		result <= 32'b0;
	else
		result <= ain + bin;    
endmodule
