`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:42 10/30/2014 
// Design Name: 
// Module Name:    WRITE_NOTE 
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
module WRITE_NOTE(
   clock,
	write,
	mem_enable,
	writeDirection,
	writeDirectionTemporal,
	clearWriteDirection,
	reset,
	WE
);
input wire mem_enable;
input wire clock;
input wire write;
input wire reset;
input wire clearWriteDirection;
output reg WE;
output reg [5:0] writeDirection;
output reg [5:0] writeDirectionTemporal;

reg cuenteAux;


always@(posedge clock)
	begin
	if(reset)
		begin
			cuenteAux <= 1'b0;
			writeDirection <= 6'b0;
			WE <= 1'b0;
		end
	else
		if(cuenteAux)
			begin	
				writeDirectionTemporal <= writeDirectionTemporal + 1'b1;  
				writeDirection <= writeDirection + 1'b1;  
				cuenteAux <= 1'b0;
				WE <= 1'b1;
			end
		/** Limpia la direccion temporal y el contador para que inicie escribiendo en 
		posicion cero **/
		else if(clearWriteDirection)
			begin
				writeDirectionTemporal <= 6'b0;
			end
		else
			begin
				cuenteAux <= (write & mem_enable);
				writeDirectionTemporal <= writeDirectionTemporal;
				writeDirection <= writeDirection;
				WE <= 1'b0;
			end
	end


endmodule
