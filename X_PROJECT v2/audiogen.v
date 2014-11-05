// audiogen.v - stereo audio data generator for I2S testing
// E. Brombaugh - 08-26-2008

module audiogen(
	clk, 
	reset,
	ena,
	sw_tones,
	l_data, 
	r_data,
	play,
	CS
);
	
	input wire CS;
	input wire clk;								// system clock
	input wire reset;							// POR
	input wire ena;								// Sample rate enable
	input wire play;
	input wire [7:0] sw_tones;				// sw_tones
	
	output reg signed [23:0] l_data ;	// stereo audio data output
	output reg signed [23:0] r_data ;
	
	
   wire gate;								// amp_ctl
	assign gate = (sw_tones[0] | sw_tones[1] |sw_tones[2] |sw_tones[3] |sw_tones[4] |sw_tones[5] |sw_tones[6] |sw_tones[7]);
	
	
	parameter FREQ = 45318599;			// for 1kHz @ 41.7kHz
	
	// Freq reg
	reg [26:0] freq;
	
	always @(posedge clk)
		begin
			if(reset)
				freq <= FREQ;
			else if(ena)
				if(play & CS)
					begin
						if(sw_tones[0])
							freq <= 107786375; //Do quinta octaba
						else if(sw_tones[1])
							freq <= 101736857; //Si cuarta octaba
						else if(sw_tones[2])
							freq <= 90637199; //La cuarta octaba
						else if(sw_tones[3])
							freq <= 80749505; //Sol cuarta octaba
						else if(sw_tones[4])
							freq <= 71891779; //Fa cuarta octaba
						else if(sw_tones[5])
							freq <= 67874903; //Mi cuarta octaba
						else if(sw_tones[6])
							freq <= 60459132; //Re cuarta octaba
						else if(sw_tones[7])
							freq <= 53867335; //Do cuarta octaba
						else
							freq <= 32'd1000;
					end
			  else
					freq <= 32'd1000;
			
		end
		
		
	// NCO
	reg [31:0] phase;
	always @(posedge clk)
		begin
			if(reset)
				phase <= 32'b0;
			else if(ena)
				phase <= phase + freq;
		end
	
	
	// Sinewave lookup
	wire signed [13:0] sin;
	sine usine(
		.clk(clk),
		.phs(phase[31:20]),
		.sin(sin)
	);
	
	
	// Outputs
	//reg signed [23:0] l_data, r_data;
	always @(posedge clk)
		begin
			if(ena)
				begin
					l_data <= {24{gate}} & phase[31:8];	// ascending ramp
					r_data <= {24{gate}} & {sin,10'b0};	// sinewave
				end
		end
			
endmodule
