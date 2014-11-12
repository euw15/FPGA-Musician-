/*VGA Adapter Settings

The following settings adjust whether the VGA Adapter operates
in monochromatic or color mode. If the adapter is to operate in
color mode, the developer may specify the range of colors by
selecting the width of each color channel (i.e. RED, GREEN, BLUE).*/

 
module VgaAdapter(
	reset,
	CLOCK_50,
	color,
	x, // 0-159
	y, // 0-119
	writeEn,
	VGA_R,
	VGA_G,
	VGA_B,
	VGA_HS,
	VGA_VS,
	VGA_SYNC
);

// -- Parameters you can modify
parameter COLOR_CHANNEL_DEPTH = 1;

//--- Timing information
/*Do not modify these values unless you know what you are doing.
Incorrect values may cause harm to the monitor.*/

parameter C_VERT_NUM_PIXELS  = 10'd480;
parameter C_VERT_SYNC_START  = 10'd493;
parameter C_VERT_SYNC_END    = 10'd494; //(C_VERT_SYNC_START + 2 - 1); 
parameter C_VERT_TOTAL_COUNT = 10'd525;

parameter C_HORZ_NUM_PIXELS  = 10'd640;
parameter C_HORZ_SYNC_START  = 10'd659;
parameter C_HORZ_SYNC_END    = 10'd754; //(C_HORZ_SYNC_START + 96 - 1); 
parameter C_HORZ_TOTAL_COUNT = 10'd800;
	
	
//Input Ports
input reset;
input CLOCK_50;
input color;
input x;
input y;
input writeEn;

//Output Ports
output VGA_R;
output VGA_G;
output VGA_B;
output VGA_HS;
output VGA_VS;
output VGA_SYNC;

//Input Data Type
wire reset;
wire CLOCK_50;
wire [(COLOR_CHANNEL_DEPTH*3-1):0] color;
wire [7:0] x;
wire [6:0] y;
wire writeEn;

//Ouput Data Type
reg VGA_R;
reg VGA_G;
reg VGA_B;
reg VGA_HS;
reg VGA_VS;
wire VGA_SYNC;

//Others
wire VGA_CLK;
	
	
/*Clock Generator

The following module, provided by Quartus, declares a derived clock
inside the FPGA. The following derived clock, operates at 25MHz, which is
the frequency required for 640x480@60Hz.*/
/******************************* 25 MHZ*********************************/

Clock_25MHz clock25 (
	.clock(CLOCK_50), 
   .clock_25mhz(VGA_CLK), 
   .reset(reset)
);
	
/*CRT Controller (25 mhz)

These counters are responsible for traversing the onscreen pixels and
generating the approperiate sync and enable signals for the monitor.*/

reg [9:0] xCounter;
reg [9:0] yCounter;
	
/*
//Horizontal Counter
*/
wire xCounter_clear;
assign xCounter_clear = (xCounter == (C_HORZ_TOTAL_COUNT-1));

always @(posedge VGA_CLK or posedge reset)
	begin
		if (reset)
			xCounter <= 10'd0;
		else if (xCounter_clear)
			xCounter <= 10'd0;
		else
		begin
			xCounter <= xCounter + 1'b1;
		end
	end
	
/*
//- Vertical Counter
*/

wire yCounter_clear;
assign yCounter_clear = (yCounter == (C_VERT_TOTAL_COUNT-1)); 

always @(posedge VGA_CLK or posedge reset)
	begin
		if (reset)
			yCounter <= 10'd0;
		else if (xCounter_clear && yCounter_clear)
			yCounter <= 10'd0;
		else if (xCounter_clear)		//Increment when x counter resets
			yCounter <= yCounter + 1'b1;
	end
	
/*Frame buffer
Dual port RAM read at 25 MHz, written at 50 MHZ (synchronous with rest of circuit)*/

wire [14:0] writeAddr;
wire [14:0] readAddr;

// Color
wire [(COLOR_CHANNEL_DEPTH*3)-1:0] readData;
assign writeAddr = {y[6:0], x[7:0]};
assign readAddr = {yCounter[8:2], xCounter[9:2]};
	

RAM FrameBufferRam (
	.Clock_50(CLOCK_50), 
   .Clock_25(VGA_CLK), 
   .WAddress(writeAddr), 
   .RAddress(readAddr), 
   .WE(writeEn), 
   .DataIn(color), 
   .DataOut(readData)
);

always @(readData)
	begin		
		VGA_R <= readData[2];
		VGA_G <= readData[1];
		VGA_B <= readData[0];
	end


/*Output Display Sync and Enable

The following outputs are delayed by two clock cycles total because
of the ram. One cycle is added explicitly below and another cycle
is added on the registered output.*/

reg VGA_HS1;
reg VGA_VS1;

always @(posedge VGA_CLK)
	begin
		//- Sync Generator (ACTIVE HIGH)
		VGA_HS1 <= (xCounter >= C_HORZ_SYNC_START && xCounter <= C_HORZ_SYNC_END);
		VGA_VS1 <= (yCounter >= C_VERT_SYNC_START && yCounter <= C_VERT_SYNC_END);

		//- Add 1 cycle delay
		VGA_HS <= VGA_HS1;
		VGA_VS <= VGA_VS1;
	end
	
	assign VGA_SYNC = 1'b1;

endmodule
	