`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:55:59 10/30/2014 
// Design Name: 
// Module Name:    RAM 
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
module RAM(
	clock,
	WAddress,
	RAddress,
	WE,
	DataIn,
	DataOut
);

//Special
parameter Width = 8, Depth = 65 ,SynchronousRead = 1;
localparam AWidth = 6;

//Input Ports
input wire clock;
input wire [AWidth-1:0] WAddress;
input wire [AWidth-1:0] RAddress;
input wire WE;
input wire [Width -1:0] DataIn;

//Output Ports
output wire [Width -1:0] DataOut;
	
//MEMORY
reg [Width-1:0] mem [Depth -1:0];

//DIRECTION
reg [AWidth-1:0] ReadAddressp;
	
	
//---------------CODE ------------------------

	always @(posedge clock)
		begin
			if (WE) 
				begin
					mem[WAddress] <= DataIn;
				end
		end
		
	generate
		if (SynchronousRead) 
			begin
				always @(posedge clock)
					begin 
						ReadAddressp <= RAddress;		
					end
				assign DataOut = mem[ReadAddressp];
			end
		else 
			begin
				assign DataOut = mem[RAddress];
			end
	endgenerate
	
endmodule