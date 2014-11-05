`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:06:32 11/04/2014 
// Design Name: 
// Module Name:    LIMITE_CANCION 
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
module LIMITE_CANCION(
		input wire clock,
		input wire CS,
		input wire clean_limite,
		input wire [5:0] dir_temporal,
		output reg [5:0] limitDirection
    );
always@(posedge clock)
	begin
		if(clean_limite)//Limpia el valor limite de la cancion
			begin
				limitDirection <= 6'b0;
			end
		else if(CS)// Si esta activo el CS de dicha memoria
			begin
				limitDirection <= dir_temporal;
			end
		
	end
endmodule
