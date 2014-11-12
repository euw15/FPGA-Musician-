`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:31:14 10/30/2014 
// Design Name: 
// Module Name:    FSM_CONTROL 
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
module FSM_CONTROL(
   input wire clock,
	input wire reset,
	input wire execute,
	input wire start,
	input wire record,
	input wire finish,
	input wire erase,
   input wire [7:0] swTones,
	output reg write,
	output reg read,
	output reg listen,
	output reg track1,
	output reg track2,
	output reg mixtrack,
	output reg clean
	
);

//Others
reg [3:0] state = 0;

parameter INICIO = 0;
parameter GRABAR = 1;
parameter ESCRIBA = 2;
parameter ESCUCHAR = 3;
parameter SIGUIENTE = 4;
parameter CS_TRACK1 = 5;
parameter CS_TRACK2 = 6;
parameter MIX_TRACKS = 7;
parameter TRANSITION = 9;
parameter ERASE = 10;

always @(posedge clock)
     begin
		if (reset)
			state <= INICIO;
      else
         case (state)
				INICIO:		
					if(start)
						state <=GRABAR;
					else if(execute)
						state <=ESCUCHAR;
					else if(swTones[0])
						state <=CS_TRACK1;
					else if(swTones[1])
						state <=CS_TRACK2;
					else if(swTones[2])
						state <=MIX_TRACKS;
					else if(erase)
						state <=ERASE;
					else
						state <=INICIO;
				TRANSITION:
					state <= GRABAR;
				ERASE:
					state <= INICIO;
				CS_TRACK1:
					state <=TRANSITION;
				CS_TRACK2:
					state <=TRANSITION;
				MIX_TRACKS:
					state <= TRANSITION;
				GRABAR:
					if(record & swTones != 8'b0)
						state <=ESCRIBA;
					else if(execute)
						state <=ESCUCHAR;
					else
						state <=GRABAR;
				ESCRIBA:
						state <=SIGUIENTE;
				SIGUIENTE:
					if(swTones == 8'b0 & record == 1'b0)
						state <=GRABAR;
					else
						state <=SIGUIENTE;
					
				ESCUCHAR:
					if(finish)
						state <=INICIO;
					else
						state <=ESCUCHAR;
					
				default:
					state <= INICIO;
			endcase
		end
	
always @(state)
	begin
		case (state)
			INICIO:
				begin
					write = 0;
					read = 0;
					listen = 1;
					track1= 0;
					track2 = 0;
					mixtrack = 0;
					clean = 0;
				end
			CS_TRACK1:
				begin
					write = 0;
					read = 0;
					listen = 0;
					track1= 1;
					track2 = 0;
					mixtrack = 0;
					clean = 0;
					end
			CS_TRACK2:
				begin
					write = 0;
					read = 0;
					listen = 0;
					track1= 0;
					track2 = 1;
					mixtrack = 0;
					clean = 0;
				end
		   ERASE:
				begin
					write = 0;
					read = 0;
					listen = 0;
					track1= 1;
					track2 = 0;
					mixtrack = 0;
					clean = 1;
				end
			MIX_TRACKS:
				begin
					write = 0;
					read = 0;
					listen = 0;
					track1= 0;
					track2 = 0;
					mixtrack = 1;
					clean = 0;
				end
			GRABAR:
				begin
					write = 0;
					read = 0;				
					listen = 0;
					track1= 0;
					track2 = 0;
					mixtrack = 0;
					clean = 0;
				end
			ESCRIBA:
				begin
					write = 1;
					read = 0;
					listen = 0;
					track1= 0;
					track2 = 0;
					mixtrack = 0;
					clean = 0;
				end
			
			SIGUIENTE:
				begin
					write = 0;
					read = 0;
					listen = 0;
					track1= 0;
					track2 = 0;
					mixtrack = 0;
					clean = 0;
				end				
				
			ESCUCHAR:
				begin
					write = 0;
					read = 1;
					listen = 0;
					track1= 0;
					track2 = 0;
					mixtrack = 0;
					clean = 0;
				end
			TRANSITION:
				begin
					write = 0;
					read = 0;
					listen = 0;
					track1= 0;
					track2 = 0;
					mixtrack = 0;
					clean = 0;
				end
		   default:
				begin
					write = 0;
					read = 0;
					listen = 1;
					track1= 0;
					track2 = 0;
					mixtrack = 0;
					clean = 0;
				end
		endcase
	end

endmodule
