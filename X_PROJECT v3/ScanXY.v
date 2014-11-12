`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:14:10 11/05/2014 
// Design Name: 
// Module Name:    ScanXY 
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
module ScanXY(
	clk,
	reset,
	x,
	y
 );

//Input Ports
input clk;
input reset;

//Output Ports
output x;
output y;

//Input Data Type
wire clk;
wire reset;

//Output Data Type
reg [7:0] x;
reg [6:0] y;

//Others
wire xClear, yClear;
assign xClear = (x == 8'd159);
assign yClear = (y == 8'd119);


//-----------CODE -------------------

//BARRIDO EN X
always @(posedge clk or posedge reset)
	begin
		if (reset)
			x <= 8'd0;
		else
			begin
				if (xClear)	
					x <= 8'd0;
				else
					x <= x + 1'b1;
			end
	end
	
//BARRIDO EN Y
always @(posedge clk or posedge reset)
	begin
		if (reset)
			y <= 8'd0;
		else
			begin
				if (xClear && yClear)
					y <= 8'd0; //YA RECORRIO TODO EL CUADRO
				else if (xClear)		
					y <= y + 1'b1; //AUMENTE DE FILA
			end
	end


endmodule
