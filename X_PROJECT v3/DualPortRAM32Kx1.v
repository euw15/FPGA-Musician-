`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:23:57 09/25/2014 
// Design Name: 
// Module Name:    DualPortRAM32Kx1 
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
	Clock_50,
	Clock_25,
	WAddress,
	RAddress,
	WE,
	DataIn,
	DataOut
);

//Special
parameter Width = 3, Depth = 1024*32 ,SynchronousRead = 1;
localparam AWidth = 15;

//Input Ports
input Clock_50;
input Clock_25;
input WAddress;
input RAddress;
input WE;
input DataIn;

//Output Ports
output DataOut;
	
//Input Data Type
wire Clock_50;
wire Clock_25;
wire WE;
wire [AWidth-1:0] WAddress;
wire [AWidth-1:0] RAddress;
wire [Width -1:0] DataIn;
	
//Output Data Type
wire [Width -1:0] DataOut;
	
//MEMORY
reg [Width-1:0] mem [Depth -1:0];

//DIRECTION
reg [AWidth-1:0] ReadAddressp;
	
	
//---------------CODE ------------------------

	always @(posedge Clock_50)
		begin
			if (WE) 
				begin
					mem[WAddress] <= DataIn;
				end
		end
		
	generate
		if (SynchronousRead) 
			begin
				always @(posedge Clock_25)
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