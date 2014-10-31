// i2s_tst.v - Test I2S interface
// E. Brombaugh 08-26-2008

module i2s_tst(
	clk,
	reset,
	mclk, 
	sclk, 
	lrck,
	sdout,
	sw_tones
);
	input wire clk;			// 16MHz system clock
	input wire reset;		// POR
	output wire mclk;		// Master clock
	output wire sclk;		// Serial clock
	output wire lrck;		// Left/Right word clock
	output wire sdout;		// Audio data
	input wire [7:0] sw_tones;
	
	// Sample rate
	wire ena;
	
	// Audio Data Source
	wire signed [23:0] l_data, r_data;
	audiogen uag(
		.clk(clk),
		.reset(reset),
		.ena(ena),
		.sw_tones(sw_tones),
		.l_data(l_data),
		.r_data(r_data)
	);
	
	
	// I2S serializer
	i2s_out ui2s(
		.clk(clk),
		.reset(reset),
		.l_data(l_data), 
		.r_data(r_data),
		.sdout(sdout), 
		.sclk(sclk), 
		.lrclk(lrck),
		.load(ena)
	);
	
	// Master I2S clock is just system clock
	assign mclk = clk;
	
	
	
	
endmodule
