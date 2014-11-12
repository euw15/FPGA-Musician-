`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:55 09/29/2014 
// Design Name: 
// Module Name:    MuxObjetos 
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
module MuxObjetos(
	input wire pentagramaOn,
	input wire [2:0] colorPentagrama,
	input wire objetoNotasOn,
	input wire objetoNotasOn2,
	input wire bordeActivo,
	input wire [2:0] colorNotas,
	input wire [2:0] colorNotas2,
	input wire [2:0] colorBorde,
	output reg [2:0] color
);

always @(*)
		begin
			 if(bordeActivo)
				color = 0;
			 else if(objetoNotasOn&&objetoNotasOn2)
				color = 3'b001;
			 else if(objetoNotasOn)
				color = 3'b101;
			 else if (objetoNotasOn2)
				color = 3'b011; 
			 else if (pentagramaOn)
				color = colorPentagrama;
			 else
				color = 0; 
		end
	

endmodule
