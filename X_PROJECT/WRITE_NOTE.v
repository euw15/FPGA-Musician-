`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:42 10/30/2014 
// Design Name: 
// Module Name:    WRITE_NOTE 
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
module WRITE_NOTE(
   clock,
	write,
	writeDirection,
	reset,
	WE
);

input wire clock;
input wire write;
input wire reset;
output reg WE;
output reg [5:0] writeDirection;



reg cuenteAux;


always@(posedge clock)
	begin
	if(reset)
		begin
			cuenteAux <= 1'b0;
			writeDirection <= 6'b0;
			WE <= 1'b0;
		end
	else
		if(cuenteAux)
			begin	
				writeDirection <= writeDirection + 1'b1;  
				cuenteAux <= 1'b0;
				WE <= 1'b1;
			end
		else
			begin
				cuenteAux <= write;
				writeDirection <= writeDirection;
				WE <= 1'b0;
			end
	end


endmodule
