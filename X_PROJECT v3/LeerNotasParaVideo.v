`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:22:07 11/05/2014 
// Design Name: 
// Module Name:    LeerNotasParaVideo 
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

/*Genera las direcciones para ir leyendo siempre la memoria para ir leyendo*/
module LeerNotasParaVideo(
	input wire clock,
	input wire reset,
	input wire [5:0] limiteCancion1,
	input wire empiece,
	input wire cuente,
	output reg [6:0] direccionCancion1,
	output reg termino
    );

/*Itera por la direccion de todas las notas de la cancion 1*/
always @(posedge clock or posedge reset)
	begin	
		if(reset)
			begin
				direccionCancion1 <= 0;
				termino <= 0;
			end
		else if(empiece)
			begin
				direccionCancion1 <= 0;
				termino <= 0;
			end
		else if(cuente)
			begin
				if(direccionCancion1>=limiteCancion1)
					begin
						direccionCancion1 <= 0;
						termino <= 1;
					end
				else
					begin
						direccionCancion1 <= direccionCancion1 + 1;	
						termino <= 0;
					end
			end
			
	end

endmodule
