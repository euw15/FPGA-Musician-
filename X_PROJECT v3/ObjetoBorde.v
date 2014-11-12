`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:09:31 11/12/2014 
// Design Name: 
// Module Name:    ObjetoBorde 
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
module ObjetoBorde(
	input clk, 
	input wire [7:0] x,
	input wire [6:0] y,
	input wire reset,
	output reg [2:0] colorBorde,
	output wire bordeActivo
    );

//linea 1 
parameter LineaInicioX = 0;
parameter LineaFinalX = 300;
parameter LineaInicioY = 0;
parameter LineaFinalY = 20;

assign bordeActivo = ((x >= LineaInicioX && x <= LineaFinalX) &&(y >= LineaInicioY && y<= LineaFinalY))? 1'b1:1'b0;


//********************************************************
	
always @(bordeActivo or x or y)
      begin
			if (bordeActivo)
				begin
					colorBorde = 3'b000;
				end
		else
				begin
					colorBorde= 3'b000;
				end
		end	

endmodule
