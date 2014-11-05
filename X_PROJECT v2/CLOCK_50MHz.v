`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:21:19 10/30/2014 
// Design Name: 
// Module Name:    CLOCK_50MHz 
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
module CLOCK_50MHz(
	clock,
   clock_50Mhz,
	reset
);
//Input Ports
input wire clock;
input wire reset;

//Output Ports
output reg clock_50Mhz;



//Others
wire temporal;

//----------------------CODE -----------------
always @(posedge clock,posedge reset)

	if(reset) begin
		clock_50Mhz <= 1'b0;
	end else begin
		clock_50Mhz <= temporal;
	end
	
assign temporal = ~clock_50Mhz;

endmodule
