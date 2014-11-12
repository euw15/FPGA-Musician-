`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:52:00 11/05/2014 
// Design Name: 
// Module Name:    DivisorReloj50MHz 
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
module DivisorReloj50MHz(
   reloj,
   clock_50mhz,
	reset
);

//Input Ports
input reloj;
input reset;

//Output Ports
output clock_50mhz;

//Input Data Type
wire reloj;
wire reset;

//Output Data Type
reg clock_50mhz = 0;

//Others
wire temporal;

//----------------------CODE -----------------
always @(posedge reloj,posedge reset)

	if(reset) begin
		clock_50mhz <= 1'b0;
	end else begin
		clock_50mhz <= temporal;
	end
	
assign temporal = ~clock_50mhz;

endmodule

