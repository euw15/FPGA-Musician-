// i2s_out.v:
// 2008-08-26 E. Brombaugh

module i2s_out(
	clk, 
	reset,
	l_data,
	r_data,
	sdout, 
	sclk, 
	lrclk,
	load
);
	
	input wire clk;									// System clock
	input wire reset;								// System POR
	input signed [23:0] l_data, r_data;			// inputs
	output  sdout;								// I2S serial data
	output  sclk;								// I2S serial clock
	output  lrclk;								// I2S Left/Right clock
	output  load;								// Sample rate enable output
	
	// Sample rate generation
	clkgen uclk(
		.clk(clk), 
		.reset(reset),
		.rate(load)
	);
	
	
	
	// Serial Clock divider
	reg [2:0] scnt;		// serial clock divide register
	always @(posedge clk)
		if(reset)
			scnt <= 1'b0;
		else if(load)
			scnt <= 1'b0;
		else
			scnt <= scnt + 1'b1;
	
	
	// Generate serial clock pulse
	reg p_sclk;			// 1 cycle wide copy of serial clock
	always @(posedge clk)
		begin
			p_sclk <= ~|scnt;
		end
			
	
	// Shift register advances on serial clock
	reg [47:0] sreg;
	always @(posedge clk)
		begin
			if(load)
				sreg <= {l_data,r_data};
			else if(p_sclk)
				sreg <= {sreg[46:0],1'b0};
		end
	
	
	// 1 serial clock cycle delay on data relative to LRCLK
	reg sdout;
	always @(posedge clk)
		begin
			if(p_sclk)
				sdout <= sreg[47];
		end	
			
			
	// Generate LR clock
	reg [4:0] lrcnt;
	reg lrclk;
	
	always @(posedge clk)
		if(reset | load)
			begin
				lrcnt <= 1'b0;
				lrclk <= 1'b0;
			end
		else if(p_sclk)
			begin
				if(lrcnt == 5'd23)
					begin
						lrcnt <= 1'b0;
						lrclk <= ~lrclk;
					end
				else
					lrcnt <= lrcnt + 1'b1;
			end
	
	
	// align everything
	reg sclk_p0, sclk;
	always @(posedge clk)
		begin
			sclk_p0 <= scnt[2];
			sclk <= sclk_p0;
		end
	
	
endmodule
