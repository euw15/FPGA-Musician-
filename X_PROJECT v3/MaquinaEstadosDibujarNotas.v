`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:47:02 11/08/2014 
// Design Name: 
// Module Name:    MaquinaEstadosDibujarNotas 
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
module MaquinaEstadosDibujarNotas(
    input wire botonCrearDirecciones,
	 input wire terminoDirecciones,
	 input wire clock,
	 input wire reset,
	 output reg empiece,
	 output reg cuente
	 );

//Others
reg [2:0] state = 1;


parameter noCrearDirecciones = 1;
parameter crearDirecciones = 2;

always @(posedge clock )
     begin
		if (reset)
			state <= noCrearDirecciones;
      else
         case (state)
				noCrearDirecciones:
					if(botonCrearDirecciones)
						begin
							state<=crearDirecciones;
						end
					else
						begin
							state<=noCrearDirecciones;
						end
				crearDirecciones:
					if(terminoDirecciones)
						begin
							state<=noCrearDirecciones;
						end
					else
						begin
							state<=crearDirecciones;
						end
				default:
					state <= noCrearDirecciones;
			endcase
		end
	
always @(state)
	begin
		case (state)
			noCrearDirecciones:
				begin
					empiece = 1;
					cuente = 0;
				end
			crearDirecciones:
				begin
					empiece = 0;
					cuente = 1;
				end
			default:
				begin
					empiece = 1;
					cuente = 0;
				end
		endcase
	end
	
endmodule
