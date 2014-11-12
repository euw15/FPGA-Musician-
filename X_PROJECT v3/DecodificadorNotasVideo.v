`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:03:48 11/05/2014 
// Design Name: 
// Module Name:    DecodificadorNotasVideo 
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
module DecodificadorNotasVideo(
	input wire clock,
	input wire reset,
	input wire leyendo,
	input wire [7:0] notaCancion1,
	output reg  [9:0] posicionYNotaCancion1
    );


//Se encarga de dar posicion a la nota actual*/
always @(notaCancion1)
	begin
		if(reset)
			begin
				posicionYNotaCancion1 <= 0;
			end
		else if(leyendo)
			begin
				/*Si es DO*/
				if(notaCancion1==128)
					begin
						posicionYNotaCancion1 <= 80;
					end
				/*Si es RE*/
				else if(notaCancion1==64)
					begin
						posicionYNotaCancion1 <= 75;
					end
				/*Si es MI*/
				else if(notaCancion1==32)
					begin
						posicionYNotaCancion1 <= 70;
					end
				/*Si es FA*/
				else if(notaCancion1==16)
					begin
						posicionYNotaCancion1 <= 65;
					end
				/*Si es SOL*/
				else if(notaCancion1==8)
					begin
						posicionYNotaCancion1 <= 60;
					end
				/*Si es LA*/
				else if(notaCancion1==4)
					begin
						posicionYNotaCancion1 <= 55;
					end
				/*Si es SI*/
				else if(notaCancion1==2)
					begin
						posicionYNotaCancion1 <= 50;
					end
				/*Si es DO*/
				else if(notaCancion1==1)
					begin
						posicionYNotaCancion1 <= 45;
					end
			end
	end

endmodule
