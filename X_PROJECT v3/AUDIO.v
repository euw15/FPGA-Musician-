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
	tonos_cancion1,
	tonos_cancion2,
	read,
	CS1,
	CS2
);
	input wire CS1;
	input wire CS2;
	input wire clk;				// 50MHz oscillator
	input wire reset;
	input wire [7:0] tonos_cancion1;
	input wire [7:0] tonos_cancion2;
	output [3:0] JA;		// Digilent socket JA - I2S DAC
	wire clock_50Mhz;
	input wire read;

	// Clock divider
	reg clk2;
	always @(posedge clock_50Mhz)
		begin
			clk2 <= ~clk2;
		end
		
	// Instance of I2S test module track1
	i2s_tst audio_i2s(
			.clk(clk2), 
			.reset(reset),
			.mclk(JA[0]),
			.sclk(JA[2]),
			.lrck(JA[1]),
			.sdout(JA[3]),
			.tonos_cancion1(tonos_cancion1),
			.tonos_cancion2(tonos_cancion2),
			.play(read),
			.CS1(CS1),
			.CS2(CS2)
		);

	
	
	CLOCK_50MHz clock_50MHz (
    .clock(clk), 
    .clock_50Mhz(clock_50Mhz), 
    .reset(reset)
    );
	 
	 /*wire clockS;
	 assign clockS = (clock_50Mhz) ? clk:1'b0;*/
	 
	 
	 
		
endmodule
