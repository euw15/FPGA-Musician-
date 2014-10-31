`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:00:16 10/30/2014 
// Design Name: 
// Module Name:    AUDIO 
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
module AUDIO(
   clk,
	JA,
	reset,
	sw_tones
);

	input wire clk;				// 50MHz oscillator
	input wire reset;
	input wire [7:0] sw_tones;
	output [3:0] JA;		// Digilent socket JA - I2S DAC
	wire clock_50Mhz;


	// Clock divider
	reg clk2;
	always @(posedge clock_50Mhz)
		begin
			clk2 <= ~clk2;
		end
		
	// Instance of I2S test module
	i2s_tst ui2stst(
			.clk(clk2), 
			.reset(reset),
			.mclk(JA[0]),
			.sclk(JA[2]),
			.lrck(JA[1]),
			.sdout(JA[3]),
			.sw_tones(sw_tones)
		);
	
	
	CLOCK_50MHz clock_50MHz (
    .clock(clk), 
    .clock_50Mhz(clock_50Mhz), 
    .reset(reset)
    );
	 
	 /*wire clockS;
	 assign clockS = (clock_50Mhz) ? clk:1'b0;*/
	 
	 
	 
		
endmodule
