`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:27:54 11/05/2014 
// Design Name: 
// Module Name:    FSMVGA 
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
module FSMVGA(
	input wire clock,
	input wire reset,
	output reg writeEnable
);

//Others
reg [2:0] state = 0;

parameter box = 2;
parameter readBox = 3;

always @(posedge clock )
     begin
		if (reset)
			state <= box;
      else
         case (state)
				box:
					state <=readBox;
				readBox:
					state <= box;
				default:
					state <= box;
			endcase
		end
	
always @(state)
	begin
		case (state)
			box:
				begin
					writeEnable = 1;
				end
			readBox:
				begin
					writeEnable = 0;
				end
			default:
				begin
					writeEnable = 0;
				end
		endcase
	end

endmodule
