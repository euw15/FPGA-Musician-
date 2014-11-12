`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:03 11/12/2014 
// Design Name: 
// Module Name:    FSMMovimientoNotas 
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
module FSMMovimientoNotas(
	input wire clock,
	input wire reset,
	input wire [5:0] notaActual,
	output reg movimientoIzquierda,
	output reg movimientoDerecha
    );
	 
reg [2:0] state = 1;
reg [5:0] ultimaNotaUtilizada=100;

parameter inicio = 1;	
parameter moverIzquierda = 0;

always @(clock)
  begin
		case (state)
			inicio:
				if(notaActual>14&ultimaNotaUtilizada!=notaActual)
					begin
						ultimaNotaUtilizada<=notaActual;
						state<=moverIzquierda;
					end
				else
						state<=inicio;
			moverIzquierda:
				state<=inicio;
			default:
				state <= inicio;
		endcase
	end
	
always @(state)
	begin
		case (state)
			inicio:
				begin
					movimientoIzquierda = 0;
					movimientoDerecha = 0;
				end
			moverIzquierda:
				begin
					movimientoIzquierda = 1;
					movimientoDerecha = 0;
				end
			default:
				begin
					movimientoIzquierda = 0;
					movimientoDerecha = 0;
				end
		endcase
	end

endmodule
