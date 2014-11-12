`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:07:05 10/30/2014 
// Design Name: 
// Module Name:    VIDEO 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module VIDEO(
   input [10:0] entry,
	input clock,
	input reset,
	output a,
	output b,
	output c,
	output d,
	output e,
	output f,
	output g,
	output [3:0] an
);

wire [4:0] num0;
wire [4:0] num1;
wire [4:0] num2;
wire [4:0] num3;

BIN_TO_BCD bin_to_bcd (
    .entry(entry), 
    .out0(num0), 
    .out1(num1), 
    .out2(num2), 
    .out3(num3)
 );
 
SEVEN_SEG seven_seg (
    .clock(clock), 
    .reset(reset), 
    .in0(num0), 
    .in1(num1), 
    .in2(num2), 
    .in3(num3), 
    .a(a), 
    .b(b), 
    .c(c), 
    .d(d), 
    .e(e), 
    .f(f), 
    .g(g), 
    .an(an)
    );


endmodule
