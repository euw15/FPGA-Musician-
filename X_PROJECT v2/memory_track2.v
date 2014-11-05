`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:33:39 11/03/2014 
// Design Name: 
// Module Name:    memory_track2 
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
module memory_track2(
	clock,
	WAddress,
	RAddress,
	WE,
	DataIn,
	DataOut,
	CS
);

//Special
parameter Width = 8, Depth = 65;
localparam AWidth = 6;

//Input Ports
input wire clock;
input wire [AWidth-1:0] WAddress;
input wire [AWidth-1:0] RAddress;
input wire WE;
input wire CS;
input wire [Width -1:0] DataIn;

//Output Ports
output reg [Width -1:0] DataOut;
	
//MEMORY
reg [Width-1:0] mem [Depth -1:0];

//DIRECTION
reg [AWidth-1:0] ReadAddressp;
	
	
//---------------CODE ------------------------

	always @(posedge clock)
		begin
			if (WE && CS) 
				begin
					mem[WAddress] <= DataIn;
				end
		end
		
	always @(posedge clock)
			begin 
					if(CS)
						begin
							ReadAddressp <= RAddress;
							DataOut <= mem[ReadAddressp];			
						end
					else
						begin
							ReadAddressp <= 6'b0;
							DataOut <= 8'b0;
						end
				
			end
		
	
endmodule
