`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:55:49 11/10/2014 
// Design Name: 
// Module Name:    RegistroNumeroNota 
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
module RegistroNumeroNota(
	input wire [6:0] numeroNotaIn,
	input wire [9:0] posicionNotaYIn,
	input wire clock,
	output reg [6:0] numeroNotaOut,
	output reg [9:0] posicionNotaYOut
    );


always @(posedge clock)
	begin
		numeroNotaOut <= numeroNotaIn;
		posicionNotaYOut <= posicionNotaYIn;
	end

endmodule
