`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:22 11/05/2014 
// Design Name: 
// Module Name:    Pentagrama 
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
module Pentagrama( 
	input clk, 
	input wire [7:0] x,
	input wire [6:0] y,
	input wire reset,
	output reg [2:0] color,
	output wire lineaActiva
);

//********************************************************

//linea 1 
parameter Linea1InicioX = 0;
parameter Linea1FinalX = 300;
parameter Linea1InicioY = 40;
parameter Linea1FinalY = 41;

//linea 2 
parameter Linea2InicioX = 0;
parameter Linea2FinalX = 300;
parameter Linea2InicioY = 50;
parameter Linea2FinalY = 51;

//linea 3
parameter Linea3InicioX = 0;
parameter Linea3FinalX = 300;
parameter Linea3InicioY = 60;
parameter Linea3FinalY = 61;

//linea 4
parameter Linea4InicioX = 0;
parameter Linea4FinalX = 300;
parameter Linea4InicioY = 70;
parameter Linea4FinalY = 71;

//linea 5
parameter Linea5InicioX = 0;
parameter Linea5FinalX = 300;
parameter Linea5InicioY = 80;
parameter Linea5FinalY = 81;


assign linea1 = ((x >= Linea1InicioX && x <= Linea1FinalX) &&(y >= Linea1InicioY && y<= Linea1FinalY))? 1'b1:1'b0;
assign linea2 = ((x >= Linea2InicioX && x <= Linea2FinalX) &&(y >= Linea2InicioY && y<= Linea2FinalY))? 1'b1:1'b0;
assign linea3 = ((x >= Linea3InicioX && x <= Linea3FinalX) &&(y >= Linea3InicioY && y<= Linea3FinalY))? 1'b1:1'b0;
assign linea4 = ((x >= Linea4InicioX && x <= Linea4FinalX) &&(y >= Linea4InicioY && y<= Linea4FinalY))? 1'b1:1'b0;
assign linea5 = ((x >= Linea5InicioX && x <= Linea5FinalX) &&(y >= Linea5InicioY && y<= Linea5FinalY))? 1'b1:1'b0;

assign lineaActiva = linea1 || linea2 || linea3 || linea4 || linea5;

//********************************************************
	
always @(lineaActiva or x or y)
      begin
			if (lineaActiva)
				color = 3'b111;
			else
				color= 3'b000;
		end		

	
endmodule
