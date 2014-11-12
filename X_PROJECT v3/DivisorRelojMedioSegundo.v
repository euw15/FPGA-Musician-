`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:08 11/07/2014 
// Design Name: 
// Module Name:    DivisorRelojMedioSegundo 
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
module DivisorRelojMedioSegundo(
	clock,
	reset,
	clock_MedioSegundo
 );
 
//Input Ports
input clock;
input reset;

//Output Ports
output clock_MedioSegundo;

//Input Data Type
wire clock;
wire reset;


//Output Data Type
reg clock_MedioSegundo;

//Others
reg [20:0] counter_50M = 0;


//-----------------CODE ----------------

parameter  count_50M = 5000000;

//DIVISOR DE RELOJ

always @(posedge clock or posedge reset)

	begin
		if(reset)
			begin
				counter_50M <= 1'b0;
				clock_MedioSegundo <= 1'b1;
			end
		else
			if(counter_50M == count_50M)
				begin
					counter_50M <= 1'b0;
					clock_MedioSegundo <= !clock_MedioSegundo;
				end
			else
				counter_50M <= counter_50M + 1'b1;
	end
			

endmodule

