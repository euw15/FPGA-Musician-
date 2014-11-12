`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:33 09/25/2014 
// Design Name: 
// Module Name:    Clock_25MHz 
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
module Clock_25MHz(
     clock,
     clock_25mhz,
	  reset
);
//Input Ports
input clock;
input reset;

//Output Ports
output clock_25mhz;

//Input Data Type
wire clock;
wire reset;

//Output Data Type
reg clock_25mhz = 0;

//Others
wire temporal;

//----------------------CODE -----------------
always @(posedge clock,posedge reset)

	if(reset) begin
		clock_25mhz <= 0;
	end else begin
		clock_25mhz <= temporal;
	end
	
assign temporal = ~clock_25mhz;

endmodule
