// clkgen.v - master clock generator for I2S test
// E. Brombaugh - 08-26-2008

// NOTE: Initially set up for Fsamp = Fclk/384. 
// @ 16MHz => 41.7 kHz sample rate

module clkgen(
	clk, 
	reset,
	rate
);

	input wire clk;		// system clock
	input wire reset;	// POR
	output reg rate;	// Sample rate clock output
	
	// rate counter
	reg [8:0] cnt;
	always @(posedge clk)
		if(reset | rate)
			cnt <= 9'd383;
		else
			cnt <= cnt - 1'd1;
	
	// detect end condition
	always @(posedge clk)
		rate <= (cnt == 9'd1);
endmodule
