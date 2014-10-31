`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:51:06 10/30/2014 
// Design Name: 
// Module Name:    CLOCK_DIVISOR 
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
module CLOCK_DIVISOR(
   clock,
	reset,
	clock_Salida
 );
 
//Input Ports
input wire clock;
input wire reset;

//Output Ports
output reg clock_Salida;


//Others
reg [23:0] counter_50M = 0;


//-----------------CODE ----------------

parameter  count_50M = 12500000;//250 ms

//DIVISOR DE RELOJ
always @(posedge clock or posedge reset)

	begin
		if(reset)
			begin
				counter_50M <= 24'b0;
				clock_Salida <= 1'b0;
			end
		else
			if(counter_50M == count_50M)
				begin
					counter_50M <= 24'b0;
					clock_Salida <= !clock_Salida;
				end
			else
				counter_50M <= counter_50M + 1'b1;
	end
			

endmodule
