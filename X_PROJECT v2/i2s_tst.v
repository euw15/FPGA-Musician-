// i2s_tst.v - Test I2S interface
// E. Brombaugh 08-26-2008

module i2s_tst(
	clk,
	reset,
	mclk, 
	sclk, 
	lrck,
	sdout,
	tonos_cancion1,
	tonos_cancion2,
	play,
	CS1,
	CS2
);	
	input wire CS1;
	input wire CS2;
	input wire clk;			// 16MHz system clock
	input wire reset;		// POR
	output wire mclk;		// Master clock
	output wire sclk;		// Serial clock
	output wire lrck;		// Left/Right word clock
	output wire sdout;		// Audio data
	input wire [7:0] tonos_cancion1;
	input wire [7:0] tonos_cancion2;
	input wire play; // controla el gate
	// Sample rate
	wire ena;
	
	// Audio Data Source
	wire signed [23:0] l_data, r_data;
	wire signed [23:0] l_data_track1, r_data_track1;
	wire signed [23:0] l_data_track2, r_data_track2;
	
	assign l_data = (CS1 & CS2) ? (l_data_track1 + l_data_track2) : (CS1) ? l_data_track1 : l_data_track2;
	assign r_data = (CS1 & CS2) ? (r_data_track1 + r_data_track2) : (CS1) ? r_data_track1 : r_data_track2;
	
	audiogen gen_track1(
		.clk(clk),
		.reset(reset),
		.ena(ena),
		.sw_tones(tonos_cancion1),
		.l_data(l_data_track1),
		.r_data(r_data_track1),
		.play(play),
		.CS(CS1)
	);
	audiogen gen_track2(
		.clk(clk),
		.reset(reset),
		.ena(ena),
		.sw_tones(tonos_cancion2),
		.l_data(l_data_track2),
		.r_data(r_data_track2),
		.play(play),
		.CS(CS2)
	);
	
	// I2S serializer
	i2s_out ui2s(
		.clk(clk),
		.reset(reset),
		.l_data(l_data), 
		.r_data(r_data),
		.sdout(sdout), //Serial Data Out
		.sclk(sclk), 
		.lrclk(lrck),
		.load(ena)
	);
	
	// Master I2S clock is just system clock
	assign mclk = clk;
	
	
	
	
endmodule
