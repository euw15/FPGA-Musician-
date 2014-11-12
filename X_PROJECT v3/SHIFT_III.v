`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:01:08 10/30/2014 
// Design Name: 
// Module Name:    SHIFT_III 
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
module SHIFT_III(
   in,
	out
);

//Input Ports
input[22:0] in;

//Output Ports
output[22:0] out;

//Output Data Type
reg [22:0] out;

always @(*)
	begin
		out = in;
		if(in[22:19]>4)
			out[22:19] = in[22:19] + 4'b0011;
			
		if(in[18:15]>4)
			out[18:15] = in[18:15] + 4'b0011;
			
		if(in[14:11] >4)
		out[14:11] = in[14:11] + 4'b0011;
	end
endmodule


