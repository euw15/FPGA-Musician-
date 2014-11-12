`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:38 11/05/2014 
// Design Name: 
// Module Name:    Clock_Divisor_VGA 
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
module Clock_Divisor_VGA(
	clock,
	reset,
	clock_1S
 );
 
//Input Ports
input clock;
input reset;

//Output Ports
output clock_1S;

//Input Data Type
wire clock;
wire reset;


//Output Data Type
reg clock_1S;

//Others
reg [18:0] counter_50M = 0;


//-----------------CODE ----------------

parameter  count_50M = 300000;

//DIVISOR DE RELOJ

always @(posedge clock or posedge reset)

	begin
		if(reset)
			begin
				counter_50M <= 1'b0;
				clock_1S <= 1'b1;
			end
		else
			if(counter_50M == count_50M)
				begin
					counter_50M <= 1'b0;
					clock_1S <= !clock_1S;
				end
			else
				counter_50M <= counter_50M + 1'b1;
	end
			

endmodule


