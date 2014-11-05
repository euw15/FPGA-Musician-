`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:02:30 10/30/2014 
// Design Name: 
// Module Name:    BIN_TO_BCD 
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
module BIN_TO_BCD(
	entry,
	out0, 
	out1,
	out2,
	out3
);

	//Input Ports
	input wire [10:0] entry;
	
	//Output Ports
	output reg [4:0] out0;
	output reg [4:0] out1;
	output reg [4:0] out2;
	output reg [4:0] out3;


	// ------------- CODE -------------------
	wire[22:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,w9;
	assign w0 = entry;

	SHIFT_III T0(.in(w0<<3),.out(w1));
	SHIFT_III T1(.in(w1<<1),.out(w2));
	SHIFT_III T2(.in(w2<<1),.out(w3));
	SHIFT_III T3(.in(w3<<1),.out(w4));
	SHIFT_III T4(.in(w4<<1),.out(w5));
	SHIFT_III T5(.in(w5<<1),.out(w6));
	SHIFT_III T6(.in(w6<<1),.out(w7));
	SHIFT_III T7(.in(w7<<1),.out(w8));
	
	assign w9 = w8 << 1;


always @(*)
		begin
			out0 = w9[14:11]; 
			out1 = w9[18:15];
			out2 = w9[22:19];
			out3 = 0;
		end	
endmodule



