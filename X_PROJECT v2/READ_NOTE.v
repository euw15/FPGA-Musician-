`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:27:58 10/30/2014 
// Design Name: 
// Module Name:    READ_NOTE 
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
module READ_NOTE(
	clock,
	reset,
	read,
	limit,
	listen,
	finish,
	readDirection,
	mix_audio,
	limit_mix
);
//Input 
input wire mix_audio;
input wire clock;
input wire reset;
input wire listen;
input wire read;
input wire [5:0] limit;
input wire [6:0] limit_mix;
//Ouput
output reg [5:0] readDirection = 0;
output reg finish = 0;

//CODE
always @(posedge clock or posedge reset)

	begin	
		if(reset)
			begin
				finish <= 1'b0;
				readDirection <= 1'b0;
			end
		
		else if(listen)
			begin
				finish <= 1'b0;
				readDirection <= 1'b0;
			end	
			
		else if(read)
			begin
				if(!mix_audio)
					begin
						if(readDirection>=limit)
							begin
								finish <= 1'b1;
								readDirection <= 1'b0;
							end
						else
							begin
								finish <= 1'b0;
								readDirection <= readDirection + 1'b1;			
							end
					end
				else
					begin
						if(readDirection>=limit_mix)
							begin
								finish <= 1'b1;
								readDirection <= 1'b0;
							end
						else
							begin
								finish <= 1'b0;
								readDirection <= readDirection + 1'b1;			
							end
					end
					
			end

	end
	
endmodule

