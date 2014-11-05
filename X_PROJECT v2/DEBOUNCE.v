`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:47:21 10/30/2014 
// Design Name: 
// Module Name:    DEBOUNCE 
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
module DEBOUNCE(
   btn,
	clock,
	reset,
	btnSalida
 );

//INPUT
input wire btn;
input wire reset;
input wire clock;

//OUTPUT
output wire btnSalida;

//CODE 
reg [2:0] aux;

always @ (posedge clock)
	if (reset == 1)
		aux <= 3'b000;
   else
		aux <= {aux[1:0], btn};
		
assign btnSalida = aux[0] & aux[1] & !aux[2];
				
				
endmodule
